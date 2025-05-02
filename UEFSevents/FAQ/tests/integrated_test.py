from django.test import TestCase
from django.test.client import Client
from django.urls import reverse
from time import timezone
from ..models import Questions
from Events.models import Event, Space


class FAQBaseEventTestCase(TestCase):
    def setUp(self):
        self.client = Client()

        self.space = Space.objects.create(
            max_capacity = 30,
            name = 'Rua do palhaço',
            acessibility = True,
            phone = '75999999999',
            mobile = '7588888888',
            type_adress = 'avenida'
        )

        self.event = Event.objects.create(
            title = 'Gang Bang',
            description = 'Preciso dizer?',
            start_date = timezone.now(),
            end_date = timezone.now(),
            start_time = timezone.now().time(),
            endtime = timezone.now().time(),
            status = True,
            category = 'Adulto',
            space = self.space,
            type_event = 'Adulto',
            age_range = 18
        )

class QuestionIntegratedTestCase(FAQBaseEventTestCase):
    def setUp(self):
        FAQBaseEventTestCase.setUp(self)

    def test_event_create_by_POST(self):
        url = reverse('criar_evento')