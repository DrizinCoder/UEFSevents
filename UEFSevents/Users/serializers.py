from rest_framework import serializers
from .models import CustomUser

class CustomUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    user_type = serializers.CharField(read_only=True)
    verified_seal = serializers.BooleanField(read_only=True)

    class Meta:
        model = CustomUser
        fields = [
            'id', 'username', 'first_name', 'last_name', 'email',
            'vat', 'phone', 'mobile', 'birth_date', 'password',
            'user_type', 'verified_seal','company_name'
        ]

    def validate_vat(self, value):
        cleaned_vat = value.replace(".", "").replace("-", "").replace("/", "")
        
        if len(cleaned_vat) == 11:
            if not CustomUser.is_valid_cpf(cleaned_vat):
                raise serializers.ValidationError("CPF inválido.")
        elif len(cleaned_vat) == 14:
            if not CustomUser.is_valid_cnpj(cleaned_vat):
                raise serializers.ValidationError("CNPJ inválido.")
        else:
            raise serializers.ValidationError("VAT deve ter 11 ou 14 dígitos.")
        
        return value

    def validate(self, attrs):
        if 'vat' in attrs:
            cleaned_vat = ''.join(filter(str.isdigit, attrs['vat']))
            if len(cleaned_vat) == 11:
                if not CustomUser.is_valid_cpf(cleaned_vat):
                    raise serializers.ValidationError({"vat": "CPF inválido."})       
            elif len(cleaned_vat) == 14:
                if not CustomUser.is_valid_cnpj(cleaned_vat):
                    raise serializers.ValidationError({"vat": "CNPJ inválido."})
                    
            else:
                raise serializers.ValidationError({"vat": "VAT deve ter 11 ou 14 dígitos."})
            attrs['vat'] = cleaned_vat
            
        return attrs

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = CustomUser(**validated_data)
        user.set_password(password)
        user.save()
        return user

    def update(self, instance, validated_data):
        password = validated_data.pop('password', None)
        if password:
            instance.set_password(password)
        return super().update(instance, validated_data)