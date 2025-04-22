from django.test import TestCase

# Create your tests here.
from django.test import TestCase
from rest_framework_simplejwt.tokens import AccessToken
from rest_framework.test import APITestCase
from django.core.exceptions import ValidationError
from django.core.files.uploadedfile import SimpleUploadedFile
from django.contrib.auth import get_user_model
from .models import CustomUser, ImageCustomUser, Registrations, Documentation
from Events.models import Adress, Space, Event
from django.utils import timezone
from django.urls import reverse
from django.test import Client

class AuthenticationTests(APITestCase):  # Classe SEPARADA para autenticação
    def setUp(self):
        self.customer = CustomUser.objects.create_user(
            username='customer',
            password='testpass123',
            vat='12345678901',
            phone='1234567890',
            mobile='0987654321',
        )
        
        self.fugleman = CustomUser.objects.create_user(
            username='fugleman',
            password='testpass123',
            vat='12345678901234', 
            phone='1234567890',
            mobile='0987654321',
        )
        
        self.token_url = reverse('token_obtain_pair')
        self.user_detail_url = reverse('users-me')

    def test_successful_customer_login(self):
        response = self.client.post(self.token_url, {
            'username': 'customer',
            'password': 'testpass123'
        })
        self.assertEqual(response.status_code, 200)
        self.assertIn('access', response.data)
        
        token = AccessToken(response.data['access'])
        self.assertEqual(token['user_id'], self.customer.id)

    def test_successful_fugleman_login(self):
        response = self.client.post(self.token_url, {
            'username': 'fugleman',
            'password': 'testpass123'
        })
        self.assertEqual(response.status_code, 200)
        self.assertTrue(self.fugleman.verified_seal)

    def test_protected_endpoint_access(self):
        login_response = self.client.post(self.token_url, {
            'username': 'customer',
            'password': 'testpass123'
        })
        access_token = login_response.data['access']
        
        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {access_token}')
        response = self.client.get(self.user_detail_url)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['username'], 'customer')

# class CustomUserTests(TestCase):
#     def setUp(self):
#         self.user_data_customer = {
#             'username': 'customer',
#             'password': 'testpass123',
#             'vat': '12345678901',
#             'phone': '1234567890',
#             'mobile': '0987654321',
#         }
        
#         self.user_data_fugleman = {
#             'username': 'fugleman',
#             'password': 'testpass123',
#             'vat': '12345678901234', 
#             'phone': '1234567890',
#             'mobile': '0987654321',
#         }

#         self.token_url = reverse('token_obtain_pair')
#         self.user_detail_url = reverse('users-detail', kwargs={'pk': 'me'})

#     def test_create_customer_user(self):
#         user = CustomUser.objects.create_user(**self.user_data_customer)
#         self.assertEqual(user.user_type, 'customer')
#         self.assertFalse(user.verified_seal)

#     def test_create_fugleman_user(self):
#         user = CustomUser.objects.create_user(**self.user_data_fugleman)
#         self.assertEqual(user.user_type, 'fugleman')
#         self.assertTrue(user.verified_seal)  

#     def test_vat_validation_cpf(self):
#         user = CustomUser(**self.user_data_customer)
#         user.clean_vat()  
#         self.assertEqual(user.user_type, 'customer')

#     def test_vat_validation_cnpj(self):
#         user = CustomUser(**self.user_data_fugleman)
#         user.clean_vat()
#         self.assertEqual(user.user_type, 'fugleman')

#     def test_invalid_vat_length(self):
#         user = CustomUser(vat='12345', username='invalid', password='test')
#         with self.assertRaises(ValidationError):
#             user.clean_vat()

#     def test_unique_vat_constraint(self):
#         CustomUser.objects.create_user(**self.user_data_customer)
#         with self.assertRaises(Exception):  
#             CustomUser.objects.create_user(
#                 username='customer2',
#                 password='testpass123',
#                 vat='12345678901', 
#                 phone='0000',
#                 mobile='0000',
#             )

#     def test_managers(self):
#         CustomUser.objects.create_user(**self.user_data_customer)
#         CustomUser.objects.create_user(**self.user_data_fugleman)
        
#         self.assertEqual(CustomUser.customers.count(), 1)
#         self.assertEqual(CustomUser.fuglemans.count(), 1)

#     def test_str_representation(self):
#         user = CustomUser.objects.create_user(**self.user_data_customer)
#         self.assertEqual(str(user), "customer (Customer)")


#     def test_successful_customer_login(self):
#         response = self.client.post(self.token_url, {
#             'username': 'customer',
#             'password': 'testpass123'
#         })
        
#         self.assertEqual(response.status_code, 200)
#         token = AccessToken(response.data['access'])
#         self.assertEqual(token['user_id'], self.customer.id)

#     def test_successful_fugleman_login(self):
#         response = self.client.post(self.token_url, {
#             'username': 'fugleman',
#             'password': 'testpass123'
#         })
        
#         self.assertEqual(response.status_code, 200)
#         self.assertTrue(self.fugleman.verified_seal)

#     def test_protected_endpoint_access(self):
#         login_response = self.client.post(self.token_url, {
#             'username': 'customer',
#             'password': 'testpass123'
#         })
#         access_token = login_response.data['access']
        
#         self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {access_token}')
#         response = self.client.get(self.user_detail_url)
        
#         self.assertEqual(response.status_code, 200)
#         self.assertEqual(response.data['username'], 'customer')

class ImageCustomUserTests(TestCase):
    def test_image_creation(self):
        user = CustomUser.objects.create_user(
            username='user1',
            password='testpass123',
            vat='12345678901',
            phone='1234567890',
            mobile='0987654321',
        )
        image = ImageCustomUser.objects.create(
            url='http://example.com/image.jpg',
            fk_user=user,
        )
        self.assertEqual(image.fk_user.username, 'user1')



class RegistrationsTests(TestCase):
    def setUp(self):
        self.address = Adress.objects.create(
            adress_zip_code=12345678,
            adress_city="Cidade Teste",
            adress_state="Estado Teste",
            adress_street="Rua Teste",
            adress_neighborhood="Bairro Teste"
        )

        self.space = Space.objects.create(
            max_capacity=100,
            name="Espaço Teste",
            acessibility=True,
            phone="1234567890",
            mobile="0987654321",
            type_adress="Tipo Teste",
            adress=self.address
        )

        start_date = timezone.make_aware(timezone.datetime(2024, 1, 1, 10, 0))
        end_date = timezone.make_aware(timezone.datetime(2024, 1, 1, 18, 0))

        self.event = Event.objects.create(
            title="Evento Teste",
            description="Descrição do evento",
            start_date=start_date,  
            end_date=end_date,      
            start_time="10:00:00",
            endtime="18:00:00",
            status=True,
            category="Categoria Teste",
            space=self.space,
            type_event="Tipo Teste",
            age_range=18
        )

        self.user = CustomUser.objects.create_user(
            username='user1',
            password='testpass123',
            vat='12345678901',
            phone='1234567890',
            mobile='0987654321',
        )

    def test_registration_creation(self):
        registration = Registrations.objects.create(
            fk_user=self.user,
            fk_event=self.event,
        )
        self.assertIsNotNone(registration.date)

class DocumentationTests(TestCase):
    def setUp(self):
        self.address = Adress.objects.create(
            adress_zip_code=12345678,
            adress_city="Cidade Teste",
            adress_state="Estado Teste",
            adress_street="Rua Teste",
            adress_neighborhood="Bairro Teste"
        )

        self.space = Space.objects.create(
            max_capacity=100,
            name="Espaço Teste",
            acessibility=True,
            phone="1234567890",
            mobile="0987654321",
            type_adress="Tipo Teste",
            adress=self.address
        )

        self.user = CustomUser.objects.create_user(
            username='user1',
            password='testpass123',
            vat='12345678901',
            phone='1234567890',
            mobile='0987654321',
        )

    def test_documentation_creation(self):
        doc = Documentation.objects.create(
            type='passport',
            issue_date='2023-01-01',
            file=SimpleUploadedFile('doc.pdf', b'file_content'),
            fk_user=self.user,
            fk_space=self.space,
        )
        self.assertEqual(doc.type, 'passport')

class IntegrationTests(TestCase):
    def test_user_with_multiple_relations(self):
        user = CustomUser.objects.create_user(
            username='integration_user',
            password='testpass123',
            vat='12345678901234', 
            phone='1234567890',
            mobile='0987654321',
        )

        address = Adress.objects.create(
            adress_zip_code=12345678,
            adress_city="Cidade Integração",
            adress_state="Estado Integração",
            adress_street="Rua Integração",
            adress_neighborhood="Bairro Integração"
        )

        space = Space.objects.create(
            max_capacity=200,
            name="Espaço Integração",
            acessibility=True,
            phone="1234567890",
            mobile="0987654321",
            type_adress="Tipo Integração",
            adress=address
        )

        event = Event.objects.create(
            title="Evento Integração",
            description="Descrição do evento",
            start_date=timezone.now(),
            end_date=timezone.now() + timezone.timedelta(hours=3),
            start_time="10:00:00",
            endtime="13:00:00",
            status=True,
            category="Categoria Teste",
            space=space,
            type_event="Tipo Teste",
            age_range=18
        )

        registration = Registrations.objects.create(fk_user=user, fk_event=event)

        doc = Documentation.objects.create(
            type='contract',
            issue_date='2023-01-01',
            file=SimpleUploadedFile('doc.pdf', b'content'),
            fk_user=user,
            fk_space=space,
        )

        self.assertEqual(user.registrations_set.count(), 1)
        self.assertEqual(user.documentation_set.count(), 1)
        self.assertTrue(user.verified_seal)