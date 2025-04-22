#from email.headerregistry import Address
from django import forms
from UEFSevents import models
from .models import Event
from .models import Address
from .models import Space
from .models import Image


class EventForm(forms.Form):
    title = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    description = forms.CharField(
        widget=forms.Textarea(attrs={'class': 'form-control', 'rows': 3})
    )
    start_date = forms.DateTimeField(
        widget=forms.DateTimeInput(attrs={'class': 'form-control', 'type': 'datetime-local'})
    )
    end_date = forms.DateTimeField(
        widget=forms.DateTimeInput(attrs={'class': 'form-control', 'type': 'datetime-local'})
    )
    start_time = forms.TimeField(
        widget=forms.TimeInput(attrs={'class': 'form-control', 'type': 'time'})
    )
    end_time = forms.TimeField(
        widget=forms.TimeInput(attrs={'class': 'form-control', 'type': 'time'})
    )
    status = forms.BooleanField(
        required=False,
        widget=forms.CheckboxInput(attrs={'class': 'form-check-input'})
    )
    category = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    space = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    type_event = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    age_range = forms.IntegerField(
        widget=forms.NumberInput(attrs={'class': 'form-control'})
    )

class SpaceForm(forms.ModelForm):
    class Meta:
        model = Space  # Você precisará importar seu modelo Space
        fields = '_all_'
        widgets = {
            'space_id': forms.HiddenInput(),
            'max_capacity': forms.NumberInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'acessibility': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'mobile': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'type_adress': forms.TextInput(attrs={'class': 'form-control'}),
        }

class AddressForm(forms.ModelForm):
    class Meta:
        model = Address  # Você precisará importar seu modelo Address
        fields = '_all_'
        widgets = {
            'address_id': forms.HiddenInput(),
            'address_zip_code': forms.NumberInput(attrs={'class': 'form-control'}),
            'address_city': forms.TextInput(attrs={'class': 'form-control'}),
            'address_state': forms.TextInput(attrs={'class': 'form-control'}),
            'address_street': forms.TextInput(attrs={'class': 'form-control'}),
            'address_neighborhood': forms.TextInput(attrs={'class': 'form-control'}),
        }

class ImageForm(forms.ModelForm):
    class Meta:
        model = Image  # Você precisará importar seu modelo Image
        fields = '_all_'
        widgets = {
            'url': forms.URLInput(attrs={'class': 'form-control'}),
            'events': forms.Select(attrs={'class': 'form-control'}),
        }



# def clean(self):
#     cleaned_data=super().clean()

#VALIDÇÃO
# def clean_space(self):
#     space=self.cleaned_data['space']
#     if auetntication==false:
#         raise forms.ValidationError("Necessário documento de autorização")
#         return spacefrom django import forms


#GET pegar dados(venviar form vazio)
#POST (guardar dados)

#IMPORTAR forms NO HTML


# class EventForm(forms.Form):
#     title=forms.CharField(max_length=100)
#     description=forms.TextField()

#     start_date=forms.DateTimeField()
#     end_date=forms.DateTimeField()

#     start_time=forms.TimeField()
#     endtime=forms.TimeField()

#     status= forms.BooleanField()
#     category=forms.CharField(max_length=100)

#     space=forms.CharField(max_length=100)

#     type_event=forms.CharField(max_length=100)

#     age_range=forms.IntegerField()

# class SpaceForm(forms.Model):
#     space_id = forms.AutoField(primary_key=True)
#     max_capacity=forms.IntegerField()
#     name=forms.CharField(max_length=100)
#     acessibility=forms.BooleanField()
#     phone=forms.CharField(max_length=12)
#     mobile=forms.BooleanField()
#     type_adress=forms.CharField(max_length=100)


# class AdressForm(forms.Model):
#     adress_id = forms.AutoField(primary_key=True)
#     adress_zip_code=forms.IntegerField()
#     adress_city=forms.CharField(max_length=100)
#     adress_state=forms.CharField(max_length=100)
#     adress_street=forms.CharField(max_length=100)
#     adress_neighborhood=forms.CharField(max_length=100)

# class ImageForm(forms.Model):
#     url=forms.URLField()
#     events=forms.ForeignKey(Event,on_delete=forms.CASCADE )