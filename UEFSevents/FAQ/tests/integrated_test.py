from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from django.utils import timezone
from ..models import Questions, Answers, Complaints
from Events.models import Event, Space
from Users.models import CustomUser
import json


class FAQAPITestCase(TestCase):
    def setUp(self):
        self.client = APIClient()

        self.admin = CustomUser.objects.create_user(
            username='admin',
            vat='12345678901',
            password='admin123',
            phone='75999999999',
            mobile='7588888888',
            is_staff=True
        )

        self.user = CustomUser.objects.create_user(
            username='testuser',
            vat='98765432109',
            password='test123',
            phone='75777777777',
            mobile='75666666666'
        )

        self.space = Space.objects.create(
            max_capacity = 30,
            name = 'Aldeia Ninja',
            acessibility = True,
            phone = '75999999999',
            mobile = '7588888888',
            type_adress = 'Aldeia'
        )

        self.event = Event.objects.create(
            title = 'Cantar 7Minutoz',
            description = 'Rap do Coringa',
            start_date = timezone.now(),
            end_date = timezone.now(),
            start_time = timezone.now().time(),
            endtime = timezone.now().time(),
            status = True,
            category = 'Todas as idades',
            space = self.space,
            type_event = 'Todas as idades',
            age_range = 18
        )

        self.question_data = {
            'question_description': 'Como participar do evento?',
            'question_fk_events': self.event.id
        }

        self.answer_data = {
            'answer_description': 'Basta se inscrever no site',
            'answer_fk_question': None
        }
        
        self.complaint_data = {
            'complaint_status': 'open',
            'complaint_reason': 'Problema no cadastro',
            'complaint_fk_event': self.event.id,
            'complaint_fk_user': self.user.id
        }

    def _create_question(self):
        self.client.force_authenticate(user=self.user)
        url = reverse('perguntas-frequentes-list')
        response = self.client.post(url, self.question_data, format='json')
        return response
    
    def _create_answer(self, question_id):
        self.client.force_authenticate(user=self.admin)
        answer_data = {
            'answer_description': self.answer_data['answer_description'],
            'answer_fk_question': question_id  # Garante que estamos passando apenas o ID
        }
        url = reverse('respostas-list')
        response = self.client.post(url, answer_data, format='json')
        return response
    
    def _create_complaint(self):
        self.client.force_authenticate(user=self.user)
        url = reverse('reclame-aqui-list')
        response = self.client.post(url, self.complaint_data, format='json')
        return response
    
    def test_create_question(self):
        response = self._create_question()
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Questions.objects.count(), 1)
        self.assertEqual(response.data['question_description'], self.question_data['question_description'])
    
    def test_list_question(self):
        self._create_question()
        url = reverse('perguntas-frequentes-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)

    def test_create_answer(self):
        question = self._create_question()
        answer = self._create_answer(question.data['id'])

        self.assertEqual(answer.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Answers.objects.count(), 1)
        self.assertEqual(answer.data['answer_description'], self.answer_data['answer_description'])

    def test_answer_relation_with_question(self):
        question = self._create_question()
        answer = self._create_answer(question.data['id'])

        answer_id = answer.data['id']  # Agora deve existir
        answer_obj = Answers.objects.get(id=answer_id)
        self.assertEqual(answer_obj.answer_fk_question.id, question.data['id'])
        
        url = reverse('respostas-detail', kwargs={'pk': answer.data['id']})
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_create_complaint(self):
        response = self._create_complaint()
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Complaints.objects.count(), 1)
        self.assertEqual(response.data['complaint_status'], 'open')

    def test_only_owner_can_see_own_complaints(self):
        self._create_complaint()

        user2 = CustomUser.objects.create_user(
            username='user2',
            vat='11122233344',
            password='user2123'
        )

        self.client.force_authenticate(user=user2)
        url = reverse('reclame-aqui-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 0)