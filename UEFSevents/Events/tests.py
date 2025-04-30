from django.test import TestCase
from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse
from .models import Event, Adress, Space, Image, EventDocumentation, EventRegistration
from Events.models import Category
from Users.models import CustomUser
from django.utils import timezone
from datetime import datetime, date, time
from rest_framework_simplejwt.tokens import RefreshToken
from django.core.files.uploadedfile import SimpleUploadedFile
# Create your tests here.

class TestandoAPI(APITestCase):
    def setUp(self):
        self.user = CustomUser.objects.create_user(
            username='cliente1',
            password='senha123',
            vat='12345678909',
            phone='1122334455',
            mobile='11987654321',
            user_type='customer'
        )

        # Gerando token JWT
        refresh = RefreshToken.for_user(self.user)
        self.access_token = str(refresh.access_token)
        # Adicionando o token ao cabeçalho da requisição
        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {self.access_token}')

        self.adress = Adress.objects.create(
            adress_zip_code=43242,
            adress_city="Cidade X",
            adress_state="Estado Y",
            adress_street="Rua Z",
            adress_neighborhood="Bairro Q",
            created_at=timezone.now()
        )
        self.space = Space.objects.create(
            max_capacity=100,
            name="Espaço Principal",
            acessibility=True,
            phone="123456789",
            mobile="987654321",
            type_adress="Auditório",
            adress=self.adress,
            created_at=timezone.now()
        )
        self.testarqv = SimpleUploadedFile("documento.pdf",b"file_content",content_type="aplication/pdf")
        self.url = reverse('eventsapi-list') 


        self.event_data = {
            "title": "Evento Teste",
            "description": "Descrição qualquer",
            "start_date": timezone.now(),
            "end_date": timezone.now(),
            "start_time": timezone.now().time(),
            "endtime": timezone.now().time(),
            "status": True,
            "category": "Show",
            "type_event": "Aberto",
            "age_range": 18,
            "space": self.space.id,
            "created_at": timezone.now()
        }
        
    def test_inscricao(self):
        self.event_data = Event.objects.create(
            title="Evento Teste",
            description="Descrição qualquer",
            start_date=timezone.now(),
            end_date=timezone.now(),
            start_time=timezone.now().time(),
            endtime=timezone.now().time(),
            status=True,
            category="Show",
            type_event="Aberto",
            age_range=18,
            space=self.space,
            created_at=timezone.now()
        )


        EventRegistration.objects.create(
            user = self.user,
            event = self.event_data,
            registration_date = timezone.now()
        )

        self.assertEqual(EventRegistration.objects.count(), 1)
        #self.assertEqual(doc.to_event.title, "Evento Teste")


    def test_criar_documentacao(self):
        self.event_data = Event.objects.create(
            title="Evento Teste",
            description="Descrição qualquer",
            start_date=timezone.now(),
            end_date=timezone.now(),
            start_time=timezone.now().time(), 
            endtime=timezone.now().time(),
            status=True,
            category=Category.Others,
            type_event="Aberto",
            age_range=18,
            space=self.space,
            created_at=timezone.now()
        )


        doc = EventDocumentation.objects.create(
            from_space=self.space,
            to_event=self.event_data,
            document=self.testarqv
        )

        self.assertEqual(EventDocumentation.objects.count(), 1)
        self.assertEqual(doc.to_event.title, "Evento Teste")



    def test_criar_evento(self):
        response = self.client.post(self.url, self.event_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Event.objects.count(), 1)
        self.assertEqual(Event.objects.get().title, "Evento Teste")
        

    def test_delete_event(self):
    # 1. Cria o evento via POST na URL de listagem
        response_create = self.client.post(self.url, self.event_data, format='json')
        self.assertEqual(response_create.status_code, status.HTTP_201_CREATED)
    
    # 2. Obter o ID do evento criado
        event_id = response_create.data['id']
    
    # 3. Gerar a URL de detalhe para esse evento usando o reverse e o ID.
        detail_url = reverse('eventsapi-detail', args=[event_id])
    
    # 4. Enviar uma requisição DELETE para a URL de detalhe (apaga o evento específico).
        response_delete = self.client.delete(detail_url)
        self.assertEqual(response_delete.status_code, status.HTTP_204_NO_CONTENT)
    
    # 5. Verificar se o evento foi realmente deletado (não existe mais no banco)
        self.assertFalse(Event.objects.filter(id=event_id).exists())

    def test_update_event(self):
        response_create = self.client.post(self.url, self.event_data, format='json')
        self.assertEqual(response_create.status_code, status.HTTP_201_CREATED)
        
        event_id = response_create.data['id']
        
        detail_url = reverse('eventsapi-detail', args=[event_id])
        
        # 4. Define os dados atualizados para o evento.
        update_data = {
            "title": "Evento Atualizado",
            "description": "Descrição atualizada",
            "start_date": self.event_data["start_date"],
            "end_date": self.event_data["end_date"],
            "start_time": self.event_data["start_time"],
            "endtime": self.event_data["endtime"],
            "status": self.event_data["status"],
            "category": self.event_data["category"],
            "type_event": self.event_data["type_event"],
            "age_range": self.event_data["age_range"],
            "space": self.event_data["space"],
            "created_at": self.event_data["created_at"]
        }
        
        # 5. Envia a requisição PUT com os dados atualizados para a URL de detalhe
        response_update = self.client.put(detail_url, update_data, format='json')
        self.assertEqual(response_update.status_code, status.HTTP_200_OK)
        
        # 6. Recupera o evento do banco para confirmar que foi atualizado
        updated_event = Event.objects.get(id=event_id)
        self.assertEqual(updated_event.title, "Evento Atualizado")
        self.assertEqual(updated_event.description, "Descrição atualizada")

















class EventModelTest(TestCase):

    def test_criar(self):
        adress= Adress.objects.create(
            adress_zip_code=43242,
            adress_city="CITY",
            adress_state="STATE",
            adress_street="STREET",
            adress_neighborhood="BAIRRO",
            created_at = timezone.now()
        )
        
        space = Space.objects.create(
            max_capacity=15,
            name="sapo",
            acessibility=False,
            phone="533434",
            mobile="434243",
            type_adress="sei la vleho de verdade",
            adress= adress,
            created_at = timezone.now()
        ) 

        event = Event.objects.create(
            title = "nirvana show",
              description = "smels like teen spirit",
                start_date = timezone.now(),
                end_date = timezone.now(),
                start_time = timezone.now().time(),
                endtime = timezone.now().time(),
                status = True,
                category = "seila",
                space = space,
                type_event= "tipo de evento sla que porar [e essa]",
                age_range = 34,
                created_at = timezone.now()
        )

        self.event2 = Event.objects.create(
            title="Evento 2",
            description="Segundo evento",
            start_date=timezone.now(),
            end_date=timezone.now(),
            start_time=timezone.now().time(),
            endtime=timezone.now().time(),
            status=False,
            category="Categoria B",
            space = space,
            age_range=21,
            created_at=timezone.now()
        )
        

        # Verifica se o título foi salvo corretamente.
        self.assertEqual(event.title, "nirvana show", "O título do evento está incorreto")

        # Verifica se a descrição foi salva corretamente.
        self.assertEqual(event.description, "smels like teen spirit", "A descrição do evento está incorreta")
        
        # Verifica se o status (ativo/inativo) é True conforme esperado.
        self.assertTrue(event.status, "O status do evento deveria ser True")
        
        # Verifica se a categoria do evento é a esperada.
        self.assertEqual(event.category, "seila", "A categoria está incorreta")
        
        #self.assertEqual(event.age_range, 19, "A faixa etária está incorreta")
        
        # Verifica se o espaço associado ao evento é o mesmo que foi criado.
        self.assertEqual(event.space, space, "O espaço associado não é o esperado")
        
        # Verifica se os dados do endereço do espaço estão corretos.  
        self.assertEqual(event.space.adress.adress_city, "CITY", "A cidade do endereço não é a esperada")

        self.assertGreaterEqual(event.age_range, 1, "idade inferior a 1")
        self.assertLessEqual(event.age_range, 100, "idade superior a 100")

        
    def test_LendoModelsTest(self):
        adress= Adress.objects.create(
            adress_zip_code=43242,
            adress_city="CITY",
            adress_state="STATE",
            adress_street="STREET",
            adress_neighborhood="BAIRRO",
            created_at = timezone.now()
        )
        
        space = Space.objects.create(
            max_capacity=15,
            name="sapo",
            acessibility=False,
            phone="533434",
            mobile="434243",
            type_adress="sei la vleho de verdade",
            adress= adress,
            created_at = timezone.now()
        ) 

        event = Event.objects.create(
            title = "nirvana show",
              description = "smels like teen spirit",
                start_date = timezone.now(),
                end_date = timezone.now(),
                start_time = timezone.now().time(),
                endtime = timezone.now().time(),
                status = True,
                category = "seila",
                space = space,
                type_event= "tipo de evento sla que porar [e essa]",
                age_range = 34,
                created_at = timezone.now()
        )

        self.event2 = Event.objects.create(
            title="Evento 2",
            description="Segundo evento",
            start_date=timezone.now(),
            end_date=timezone.now(),
            start_time=timezone.now().time(),
            endtime=timezone.now().time(),
            status=False,
            category="Categoria B",
            space = space,
            age_range=21,
            created_at=timezone.now()
        )
       
        events = Event.objects.all()
        spaces = Space.objects.all()
        adresss = Adress.objects.all()
        images = Image.objects.all()
        
        #self.assertEqual(images.count(), 2, "imagem não adicionada")
        self.assertGreaterEqual(events.count(), 1, "Event não adicionado")

            #print (images.name)

    def test_ApagaMOdelTest(self):
        adress= Adress.objects.create(
            adress_zip_code=43242,
            adress_city="CITY",
            adress_state="STATE",
            adress_street="STREET",
            adress_neighborhood="BAIRRO",
            created_at = timezone.now()
        )
        
        space = Space.objects.create(
            max_capacity=15,
            name="sapo",
            acessibility=False,
            phone="533434",
            mobile="434243",
            type_adress="sei la vleho de verdade",
            adress= adress,
            created_at = timezone.now()
        ) 
        event = Event.objects.create(
            title = "nirvana show",
              description = "smels like teen spirit",
                start_date = timezone.now(),
                end_date = timezone.now(),
                start_time = timezone.now().time(),
                endtime = timezone.now().time(),
                status = True,
                category = "seila",
                space = space,
                type_event= "tipo de evento sla que porar [e essa]",
                age_range = 34,
                created_at = timezone.now()
        )
        event.delete()
        space.delete()
        adress.delete()
        self.assertLess(Event.objects.count(),1, "falha ao deletar evento")
        self.assertLess(Space.objects.count(),1, "falha ao deletar espaço")
        self.assertLess(Adress.objects.count(),1, "falha ao deletar adress")
        #self.assertLess(event.count(),1, "falha ao deletar evento")

    def test_updateModelTest(self):
        adress= Adress.objects.create(
            adress_zip_code=43242,
            adress_city="CITY",
            adress_state="STATE",
            adress_street="STREET",
            adress_neighborhood="BAIRRO",
            created_at = timezone.now()
        )
        
        space = Space.objects.create(
            max_capacity=15,
            name="sapo",
            acessibility=False,
            phone="533434",
            mobile="434243",
            type_adress="sei la vleho de verdade",
            adress= adress,
            created_at = timezone.now()
        ) 
        event = Event.objects.create(
            title = "nirvana show",
              description = "smels like teen spirit",
                start_date = timezone.now(),
                end_date = timezone.now(),
                start_time = timezone.now().time(),
                endtime = timezone.now().time(),
                status = True,
                category = "seila",
                space = space,
                type_event= "tipo de evento sla que porar [e essa]",
                age_range = 34,
                created_at = timezone.now()
        )

        event.title= "AC/DC show"
        event.description = "BACK IN BLACK"
        event.save()
        event = Event.objects.get(id=1)
        self.assertEqual(event.title, "AC/DC show", "Falha em update title")
        self.assertEqual(event.description, "BACK IN BLACK", "Falha em update descricao")