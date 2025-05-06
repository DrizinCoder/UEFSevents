from django.test import TestCase
from django.utils import timezone
from ..models import Questions, Answers, Complaints
from Events.models import Event, Space
from Users.models import CustomUser


#Classe para usar de base ao criar um usuario e evento principais
class FAQBaseEventTestCase(TestCase):
    def setUp(self):
        self.user = CustomUser.objects.create_user(
            username = 'Ninja_Gamer',
            vat = '12345678901',
            phone = '75999999999',
            mobile = '7588888888',
            password = 'regra5'
        )

        self.space = Space.objects.create(
            max_capacity = 30,
            name = 'Aldeia Ninja',
            acessibility = True,
            phone = '75999999999',
            mobile = '7588888888',
            type_adress = 'aldeia'
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

class QuestionsTestCase(FAQBaseEventTestCase, TestCase):
    def setUp(self):
        FAQBaseEventTestCase.setUp(self)

        self.question = Questions.objects.create(
            question_description = 'Sabe oq acontece quando vc encontra um doente mental tratado com lixo pela sociedade?',
            question_likes = 51,
            question_dislikes = 51,
            question_fk_user = self.user,
            question_fk_events = self.event,
            question_created_at = timezone.now()
        )
    
    def test_sucess_create_question(self):
        self.assertEqual(self.question.question_description, 'Sabe oq acontece quando vc encontra um doente mental tratado com lixo pela sociedade?')
        self.assertNotEqual(self.question.question_description, '')

    def test_likes(self):
        self.assertEqual(self.question.question_likes, 51)
    
    def test_dislikes(self):
        self.assertEqual(self.question.question_dislikes, 51)
    
    def test_date_question(self):
        self.assertEqual(self.question.question_created_at.date(), timezone.now().date())

    def test_relation_question_event(self):
        self.assertEqual(self.question.question_fk_events.id, self.event.id)
        self.assertEqual(self.question.question_fk_events.title, 'Cantar 7Minutoz')

        if hasattr(self.event, 'questions'):
            self.assertIn(self.question, self.event.questions.all())
    
    def test_relation_question_user(self):
        self.assertEqual(self.question.question_fk_user.username, 'Ninja_Gamer')
        self.assertEqual(self.question.question_fk_user.id, self.user.id)
        self.assertEqual(self.question.question_fk_user.vat, "12345678901")

        if hasattr(self.user, 'questions'):
            self.assertIn(self.question, self.user.questions.all())

class AnswersTestCase(QuestionsTestCase, TestCase):
    def setUp(self):
        QuestionsTestCase.setUp(self)

        self.user_answer = CustomUser.objects.create_user(
            username = 'Haruzin',
            vat = '12345678902',
            phone = '75777777777',
            mobile = '75666666666',
            password = 'gachalife'
        )

        self.answer = Answers.objects.create(
            answer_description = 'Você ganha o que merece!',
            answer_fk_question = self.question,
            answer_fk_user = self.user_answer,
            answer_created_at = timezone.now()
        )
    

    def test_sucess_create_answer(self):
        self.assertEqual(self.answer.answer_description, 'Você ganha o que merece!')
        self.assertNotEqual(self.answer.answer_description, '')
    
    def test_relation_question_answer(self):
        self.assertEqual(self.answer.answer_fk_question.question_description, 'Sabe oq acontece quando vc encontra um doente mental tratado com lixo pela sociedade?')
        self.assertEqual(self.answer.answer_fk_question.id, self.question.id)
    
    def test_relation_user_answer(self):
        self.assertEqual(self.answer.answer_fk_user.username, 'Haruzin')
        self.assertNotEqual(self.answer.answer_fk_user, self.question.question_fk_user)
        self.assertNotEqual(self.user_answer.id, self.user.id)
    
    def test_date_answer(self):
        self.assertEqual(self.answer.answer_created_at.date(), timezone.now().date())    

class ComplaintTestCase(FAQBaseEventTestCase, TestCase):
    def setUp(self):
        FAQBaseEventTestCase.setUp(self)

        self.user_complaint = CustomUser.objects.create_user(
            username = 'Sanji',
            vat = '12345678902',
            phone = '75777777777',
            mobile = '75666666666',
            password = 'senhoritaNami'
        )

        self.complaint = Complaints.objects.create(
            complaint_status = 'Não Respondida',
            complaint_reason = 'Tocaram a música daquele marimo e a minha não',
            complaint_fk_user = self.user_complaint,
            complaint_fk_event = self.event,
            complaint_created_at = timezone.now()
        )

    def test_status(self):
        self.assertNotEqual(self.complaint.complaint_status, 'Respondida')
    
    def test_reason(self):
        self.assertEqual(self.complaint.complaint_reason, 'Tocaram a música daquele marimo e a minha não')

    def test_relation_user_complaint(self):
        self.assertEqual(self.complaint.complaint_fk_user.id, self.user_complaint.id)
        self.assertEqual(self.complaint.complaint_fk_user.username, 'Sanji')
    
    def test_relation_event_complaint(self):
        self.assertEqual(self.complaint.complaint_fk_event.title, 'Cantar 7Minutoz')
        self.assertEqual(self.complaint.complaint_fk_event.id, self.event.id)
        self.assertEqual(self.complaint.complaint_fk_event.description, 'Rap do Coringa')