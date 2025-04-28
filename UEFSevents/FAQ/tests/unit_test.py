from django.test import TestCase
from django.utils import timezone
from FAQ.models import Questions, Answers, Complaints
from Events.models import Event, Space
from Users.models import CustomUser


class FAQBaseEventTestCase(TestCase):
    def setUp(self):
        self.user = CustomUser.objects.create_user(
            username = 'Clovis_Basilio_dos_Santos',
            vat = '12345678901',
            phone = '75999999999',
            mobile = '7588888888',
            password = 'k8424n71l1'
        )

        self.space = Space.objects.create(
            max_capacity = 30,
            name = 'Rua do cacete',
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

class QuestionsTestCase(FAQBaseEventTestCase, TestCase):
    def setUp(self):
        FAQBaseEventTestCase.setUp(self)

        self.question = Questions.objects.create(
            question_description = 'Quem é o dono do evento?',
            question_likes = 51,
            question_dislikes = 51,
            question_fk_user = self.user,
            question_fk_events = self.event,
            question_created_at = timezone.now()
        )
    
    def test_sucess_create_question(self):
        self.assertEqual(self.question.question_description, 'Quem é o dono do evento?')
        self.assertNotEqual(self.question.question_description, '')

    def test_likes(self):
        self.assertEqual(self.question.question_likes, 51)
    
    def test_dislikes(self):
        self.assertEqual(self.question.question_dislikes, 51)
    
    def test_date_question(self):
        self.assertEqual(self.question.question_created_at.date(), timezone.now().date())

    def test_relation_question_event(self):
        self.assertEqual(self.question.question_fk_events.id, self.event.id)
        self.assertEqual(self.question.question_fk_events.title, 'Gang Bang')

        if hasattr(self.event, 'questions'):
            self.assertIn(self.question, self.event.questions.all())
    
    def test_relation_question_user(self):
        self.assertEqual(self.question.question_fk_user.username, 'Clovis_Basilio_dos_Santos')
        self.assertEqual(self.question.question_fk_user.id, self.user.id)
        self.assertEqual(self.question.question_fk_user.vat, "12345678901")

        if hasattr(self.user, 'questions'):
            self.assertIn(self.question, self.user.questions.all())

class AnswersTestCase(QuestionsTestCase, TestCase):
    def setUp(self):
        QuestionsTestCase.setUp(self)

        self.user_answer = CustomUser.objects.create_user(
            username = 'Dalafi_Maal',
            vat = '12345678902',
            phone = '75777777777',
            mobile = '75666666666',
            password = 'm91k81l961'
        )

        self.answer = Answers.objects.create(
            answer_description = 'O apelido tá na senha',
            answer_fk_question = self.question,
            answer_fk_user = self.user_answer,
            answer_created_at = timezone.now()
        )
    

    def test_sucess_create_answer(self):
        self.assertEqual(self.answer.answer_description, 'O apelido tá na senha')
        self.assertNotEqual(self.answer.answer_description, '')
    
    def test_relation_question_answer(self):
        self.assertEqual(self.answer.answer_fk_question.question_description, 'Quem é o dono do evento?')
        self.assertEqual(self.answer.answer_fk_question.id, self.question.id)
    
    def test_relation_user_answer(self):
        self.assertEqual(self.answer.answer_fk_user.username, 'Dalafi_Maal')
        self.assertNotEqual(self.answer.answer_fk_user, self.question.question_fk_user)
        self.assertNotEqual(self.user_answer.id, self.user.id)
    
    def test_date_answer(self):
        self.assertEqual(self.answer.answer_created_at.date(), timezone.now().date())    

class ComplaintTestCase(FAQBaseEventTestCase, TestCase):
    def setUp(self):
        FAQBaseEventTestCase.setUp(self)

        self.user_complaint = CustomUser.objects.create_user(
            username = 'Elisa_Sanches',
            vat = '12345678902',
            phone = '75777777777',
            mobile = '75666666666',
            password = '5l9s1s1n385s'
        )

        self.complaint = Complaints.objects.create(
            complaint_status = 'Não Respondida',
            complaint_reason = 'Minha mulher foi participar',
            complaint_fk_user = self.user_complaint,
            complaint_fk_event = self.event,
            complaint_created_at = timezone.now()
        )

    def test_status(self):
        self.assertNotEqual(self.complaint.complaint_status, 'Respondida')
    
    def test_reason(self):
        self.assertEqual(self.complaint.complaint_reason, 'Minha mulher foi participar')

    def test_relation_user_complaint(self):
        self.assertEqual(self.complaint.complaint_fk_user.id, self.user_complaint.id)
        self.assertEqual(self.complaint.complaint_fk_user.username, 'Elisa_Sanches')
    
    def test_relation_event_complaint(self):
        self.assertEqual(self.complaint.complaint_fk_event.title, 'Gang Bang')
        self.assertEqual(self.complaint.complaint_fk_event.id, self.event.id)
        self.assertEqual(self.complaint.complaint_fk_event.description, 'Preciso dizer?')