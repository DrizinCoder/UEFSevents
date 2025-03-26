from django.contrib.auth.models import AbstractUser
from Events.models import Space
from Events.models import Event
from django.db import models

class CustomUser(AbstractUser):
    vat = models.CharField(max_length=14, unique=True)
    verified_seal = models.BooleanField(default=False)
    phone = models.CharField(max_length=20)
    mobile = models.CharField(max_length=20)
    birth_date = models.DateField(null=True, blank=True)

    def __str__(self):
        return (
            f"ID: {self.id}\n"
            f"Username: {self.username}\n"
            f"Nome: {self.first_name} {self.last_name}\n"
            f"Vat: {self.vat}\n"
            f"Verified Seal: {self.verified_seal}\n"
            f"Telefone: {self.phone}\n"
            f"Celular: {self.mobile}\n"
            f"Data de Nascimento: {self.birth_date}\n"
            f"Email: {self.email}\n"
            f"Password: {self.password}\n"
            f"Ativo: {self.is_active}\n"
            f"Criado em: {self.date_joined}\n"
            f"Último login: {self.last_login}\n"
        )

class CustomUserCostumer(CustomUser):
    
    def __init__(self, *args, **kwargs):
       kwargs.setdefault('verified_seal', False)
    
class CustomUserFugleman(CustomUser):
    
    def __init__(self, *args, **kwargs):
       kwargs.setdefault('verified_seal', True)

class ImageCustomUser(models.Model):
    #profile_photo = models.ImageField(upload_to='images/')
    fk_user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)

class Registrations(models.Model):
    date = models.DateTimeField(auto_now_add=True)
    fk_user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    fk_event = models.ForeignKey(Event, on_delete=models.CASCADE)
    
    def __str__(self):
        return (
            f"ID: {self.id}\n"
            f"Data: {self.date}\n"
            f"Usuário: {self.fk_user}\n"
            f"Evento: {self.fk_event}\n"
        )
    
class Documentation(models.Model):
    class DocumentationType(models.TextChoices):
        PASSPORT = "passport", "Passport"
        ID_CARD = "id_card", "ID Card"
        DRIVER_LICENSE = "driver_license", "Driver License"
        CONTRACT = "contract", "Contract"
        OTHER = "other", "Other"

    type = models.CharField(
        max_length=50,
        choices=DocumentationType.choices,
        default=DocumentationType.OTHER
    )

    issue_date = models.DateField()
    expiration_date = models.DateField(null=True, blank=True)
    file = models.FileField(upload_to='documents/')
    is_validated = models.BooleanField(default=False)
    submission_date = models.DateField(auto_now_add=True)
    fk_user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    fk_space = models.ForeignKey(Space, on_delete=models.CASCADE)
    
    def __str__(self):
        return (
            f"ID: {self.id}\n"
            f"Tipo: {self.type}\n"
            f"Data de Expiração: {self.expiration_date}\n"
            f"Arquivo: {self.file}\n"
            f"Válido: {self.is_validated}\n"
            f"Data de Envio: {self.submission_date}\n"
            f"Usuário: {self.fk_user}\n"
            f"Espaço: {self.fk_space}\n"

        )
