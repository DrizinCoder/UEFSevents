# tests.py
from django.urls import reverse
from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from django.contrib.auth import get_user_model
from .models import CustomUser

User = get_user_model()
class CustomUserModelTests(APITestCase):
    def test_create_customer_with_valid_cpf(self):
        user = User.objects.create_user(
            username='cliente1',
            password='senha123',
            vat='12345678909',
            phone='1122334455',
            mobile='11987654321',
            user_type='customer'
        )
        self.assertEqual(user.user_type, 'customer')
        self.assertFalse(user.verified_seal)

    def test_create_fugleman_with_valid_cnpj(self):
        user = User.objects.create_user(
            username='empresa1',
            password='senha123',
            vat='11222333000144',
            phone='1122334455',
            mobile='11987654321',
            user_type='fugleman'
        )
        self.assertEqual(user.user_type, 'fugleman')
        self.assertTrue(user.verified_seal)

    def test_vat_validation(self):
        with self.assertRaises(Exception):
            User.objects.create_user(
                username='invalido',
                password='senha123',
                vat='123',
                phone='1122334455',
                mobile='11987654321'
            )

class CustomUserSerializerTests(APITestCase):
    def test_serializer_vat_validation(self):
        data = {
            'username': 'testuser',
            'password': 'testpass123',
            'vat': '123.456.789-09',
            'phone': '1234567890',
            'mobile': '0987654321',
            'birth_date': '2000-01-01'
        }
        
        response = self.client.post(reverse('customuser-list'), data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['user_type'], 'customer')

class CustomUserViewSetTests(APITestCase):
    def setUp(self):
        self.client = APIClient()
        self.user_data = {
            'username': 'testuser',
            'password': 'testpass123',
            'vat': '12345678909',
            'phone': '1234567890',
            'mobile': '0987654321',
            'birth_date': '2000-01-01'
        }
        self.user = User.objects.create_user(**self.user_data)
        self.fugleman = User.objects.create_user(
            username='fugleman1',
            password='fuglemanpass',
            vat='11222333000144',
            phone='1122334455',
            mobile='11987654321',
            user_type='fugleman'
        )

    def test_user_registration(self):
        data = {
            'username': 'newuser',
            'password': 'newpass123',
            'vat': '98765432100',
            'phone': '1122334455',
            'mobile': '11987654321',
            'birth_date': '1990-01-01'
        }
        response = self.client.post(reverse('customuser-list'), data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn('tokens', response.data)

    def test_user_login(self):
        data = {
            'username': 'testuser',
            'password': 'testpass123'
        }
        response = self.client.post(reverse('token_obtain_pair'), data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('access', response.data)

    def test_retrieve_current_user(self):
        self.client.force_authenticate(user=self.user)
        response = self.client.get(reverse('customuser-me'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['username'], self.user.username)

    def test_user_update(self):
        self.client.force_authenticate(user=self.user) 
        data = {'vat': '12345678901'}
        response = self.client.patch(
            reverse('customuser-detail', args=[self.user.id]),
            data
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_user_deactivation(self):
        self.client.force_authenticate(user=self.user)
        response = self.client.delete(
            reverse('customuser-detail', args=[self.user.id])
        )
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.user.refresh_from_db()
        self.assertFalse(self.user.is_active)

    def test_fuglemans_list(self):
        self.client.force_authenticate(user=self.fugleman)
        response = self.client.get(reverse('customuser-fuglemans'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]['user_type'], 'fugleman')

    def test_user_activation(self):
        admin_user = User.objects.create_superuser(
            username='admin',
            vat='98765432109',
            password='adminpass',
            phone='123456789',  
            mobile='987654321' 
        )
        self.client.force_authenticate(user=admin_user)
        
        response = self.client.post(
            reverse('customuser-activate-user', args=[self.user.id])
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_permissions(self):
        self.client.logout()
        response = self.client.get(reverse('customuser-list'))
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

class JWTAuthenticationTests(APITestCase):
    def test_jwt_token_obtainment(self):
        user = User.objects.create_user(
            username='jwtuser',
            password='jwtpass123',
            vat='12345678909',
            phone='1234567890',
            mobile='0987654321'
        )
        data = {
            'username': 'jwtuser',
            'password': 'jwtpass123'
        }
        response = self.client.post(reverse('token_obtain_pair'), data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('access', response.data)

    def test_protected_endpoint_access(self):
        user = User.objects.create_user(
            username='protecteduser',
            password='protected123',
            vat='12345678909',
            phone='1234567890',
            mobile='0987654321'
        )
        self.client.force_authenticate(user=user)
        response = self.client.get(reverse('customuser-me'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)