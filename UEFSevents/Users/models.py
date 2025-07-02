from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission, UserManager
from django.core.exceptions import ValidationError
from django.contrib.auth.models import BaseUserManager

class CustomUserManager(BaseUserManager):
    def create_user(self, username, vat, password=None, **extra_fields):
        if not vat:
            raise ValueError('O VAT é obrigatório')
            
        extra_fields.setdefault('phone', '000000000')
        extra_fields.setdefault('mobile', '000000000')
        
        user = self.model(
            username=username,
            vat=vat,
            **extra_fields
        )
        user.set_password(password)
        user.save(using=self._db)
        return user


    def create_superuser(self, username, password=None, vat=None, **extra_fields):
        if not vat:
            vat = input('VAT (CPF ou CNPJ): ')
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(username, vat, password, **extra_fields)

class CustomUser(AbstractUser):
    groups = models.ManyToManyField(
        Group,
        related_name="customuser_set",
        blank=True
    )
    user_permissions = models.ManyToManyField(
        Permission,
        related_name="customuser_permissions_set",
        blank=True
    )
    
    vat = models.CharField(max_length=20, unique=True)
    verified_seal = models.BooleanField(default=False)
    phone = models.CharField(max_length=20)
    mobile = models.CharField(max_length=20)
    birth_date = models.DateField(null=True, blank=True)

    USER_TYPES = [
        ('customer', 'Cliente'),
        ('fugleman', 'Fugleman'),
    ]
    user_type = models.CharField(
        max_length=10,
        choices=USER_TYPES,
        default='customer'
    )

    company_name = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name="Nome da Empresa"
    )

    objects = CustomUserManager()

    class FuglemanManager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(user_type='fugleman')

    class CustomerManager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(user_type='customer')

    customers = CustomerManager()
    fuglemans = FuglemanManager()

    def __str__(self):
        return f"{self.username} ({self.get_user_type_display()})"

    def clean(self):
        super().clean()
        
        vat = self.vat.replace(".", "").replace("-", "").replace("/", "")
        
        if self.email:
            self.email = self.__class__.objects.normalize_email(self.email)

        if len(vat) == 11:
            if not self.is_valid_cpf(vat):
                raise ValidationError({'vat': 'CPF inválido'})
            self.user_type = 'customer'
        elif len(vat) == 14:
            if not self.is_valid_cnpj(vat):
                raise ValidationError({'vat': 'CNPJ inválido'})
            self.user_type = 'fugleman'
        else:
            raise ValidationError({'vat': 'VAT deve ter 11 (CPF) ou 14 (CNPJ) dígitos'})
        if self.user_type == 'fugleman':
            if not self.company_name:
                raise ValidationError({'company_name': 'Nome da empresa é obrigatório para Fuglemans'})
            if len(self.company_name.strip()) < 3:
                raise ValidationError({'company_name': 'Nome da empresa deve ter pelo menos 3 caracteres'})

    @staticmethod
    def is_valid_cpf(cpf):
        """Validação básica de formato de CPF"""
        return cpf.isdigit() and len(cpf) == 11

    @staticmethod
    def is_valid_cnpj(cnpj):
        """Validação básica de formato de CNPJ"""
        return cnpj.isdigit() and len(cnpj) == 14

    def save(self, *args, **kwargs):
        """Garante validação antes de salvar e define selo de verificação"""
        self.full_clean()  # Força validação completa
        
        # Fugleman recebe selo de verificação automático
        if self.user_type == 'fugleman':
            self.verified_seal = True
        
        if self.company_name:
            self.company_name = self.company_name.strip()
            
        super().save(*args, **kwargs)


class ImageCustomUser(models.Model):
    profile_photo = models.URLField(default='https://cdn-icons-png.flaticon.com/512/3106/3106921.png')
    fk_user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)

