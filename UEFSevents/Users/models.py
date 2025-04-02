from django.contrib.auth.models import AbstractUser
from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.core.exceptions import ValidationError
import re

class CustomUser(AbstractUser):
    groups = models.ManyToManyField(Group, related_name="customuser_set", blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name="customuser_permissions_set", blank=True)
    vat = models.CharField(max_length=14, unique=True)
    verified_seal = models.BooleanField(default=False)
    phone = models.CharField(max_length=20)
    mobile = models.CharField(max_length=20)
    birth_date = models.DateField(null=True, blank=True)

    USER_TYPES = [
        ('customer', 'Customer'),
        ('fugleman', 'Fugleman'),
    ]
    user_type = models.CharField(max_length=10, choices=USER_TYPES, default='customer')

    def __str__(self):
        return f"{self.username} ({self.get_user_type_display()})"

    def clean_vat(self):
        vat = self.vat.replace(".", "").replace("-", "").replace("/", "")  

        if len(vat) == 11:
            if not self.is_valid_cpf(vat):
                raise ValidationError("O CPF fornecido é inválido.")
            self.user_type = 'customer' 

        elif len(vat) == 14: 
            if not self.is_valid_cnpj(vat):
                raise ValidationError("O CNPJ fornecido é inválido.")
            self.user_type = 'fugleman' 

        else:
            raise ValidationError("O VAT deve ter 11 (CPF) ou 14 (CNPJ) caracteres.") 

    def is_valid_cpf(self, cpf):
        if not cpf.isdigit(): 
            return False
        return len(cpf) == 11  

    def is_valid_cnpj(self, cnpj):
        if not cnpj.isdigit():  
            return False
        return len(cnpj) == 14  

    def save(self, *args, **kwargs):
        self.clean_vat()

        if self.user_type == 'fugleman':
            self.verified_seal = True
        super().save(*args, **kwargs)

    class FuglemanManager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(user_type="fugleman")

    class CustomerManager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(user_type="customer")

    customers = CustomerManager()
    fuglemans = FuglemanManager()
