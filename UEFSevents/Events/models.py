from django.db import models

class Space(models.Model):
    max_capacity=models.IntegerField()
    name=models.CharField(max_length=100)
    acessibility=models.BooleanField()
    phone=models.CharField(max_length=12)
    mobile=models.BooleanField()
    type_adress=models.CharField(max_length=100)
    
class Event(models.Model):
    title=models.CharField(max_length=100)
    description=models.TextField()
    start_date=models.DateTimeField()
    end_date=models.DateTimeField()
    start_time=models.TimeField()
    endtime=models.TimeField()
    status= models.BooleanField()
    category=models.CharField(max_length=100)
    space=models.ForeignKey(Space, on_delete=models.CASCADE )
    type_event=models.CharField(max_length=100)
    age_range=models.IntegerField()

class Adress(models.Model):
    adress_zip_code=models.IntegerField()
    adress_city=models.CharField(max_length=100)
    adress_state=models.CharField(max_length=100)
    adress_street=models.CharField(max_length=100)
    adress_neighborhood=models.CharField(max_length=100)

class Image(models.Model):
    url=models.URLField()
    events=models.ForeignKey(Event,on_delete=models.CASCADE )