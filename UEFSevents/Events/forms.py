from django import forms

class EventForm(forms.Form):
    title=forms.CharField(max_length=100)
    description=forms.TextField()

    start_date=forms.DateTimeField()
    end_date=forms.DateTimeField()

    start_time=forms.TimeField()
    endtime=forms.TimeField()

    status= forms.BooleanField()
    category=forms.CharField(max_length=100)

    space=forms.CharField(max_length=100)

    type_event=forms.CharField(max_length=100)

    age_range=forms.IntegerField()

class SpaceForm(forms.Model):
    space_id = forms.AutoField(primary_key=True)
    max_capacity=forms.IntegerField()
    name=forms.CharField(max_length=100)
    acessibility=forms.BooleanField()
    phone=forms.CharField(max_length=12)
    mobile=forms.BooleanField()
    type_adress=forms.CharField(max_length=100)


class AdressForm(forms.Model):
    adress_id = forms.AutoField(primary_key=True)
    adress_zip_code=forms.IntegerField()
    adress_city=forms.CharField(max_length=100)
    adress_state=forms.CharField(max_length=100)
    adress_street=forms.CharField(max_length=100)
    adress_neighborhood=forms.CharField(max_length=100)