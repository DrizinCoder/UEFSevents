from django.db import models
from Users.models import CustomUser


class Adress(models.Model):
    adress_zip_code=models.IntegerField()
    adress_city=models.CharField(max_length=100)
    adress_state=models.CharField(max_length=100)
    adress_street=models.CharField(max_length=100)
    adress_neighborhood=models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)  # Data e hora em que a tarefa foi criada


class Space(models.Model):
    max_capacity=models.IntegerField()
    name=models.CharField(max_length=100)
    acessibility=models.BooleanField()
    phone=models.CharField(max_length=12)
    mobile=models.CharField(max_length=12)
    type_adress=models.CharField(max_length=100)
    adress=models.ForeignKey(Adress, on_delete=models.CASCADE, null=True )
    created_at = models.DateTimeField(auto_now_add=True, null=True)  # Data e hora em que a tarefa foi criada


class Event(models.Model):
    title=models.CharField(max_length=100)
    description=models.TextField()
    start_date=models.DateTimeField()
    end_date=models.DateTimeField()
    start_time=models.TimeField()
    endtime=models.TimeField()
    status= models.BooleanField()

    class Category(models.TextChoices):
        Festival = 'FST', 'Festival'
        Party = 'PRT', 'Party'
        Celebration = 'CLB', 'Celebration'
        Concert = 'CRT', 'Concert'
        Theater = 'TTR', 'Theater'
        ArtExhibition = 'ART', 'Art Exhibition'
        Sports = 'SPT', 'Sports'
        Competition = 'COP', 'Competition'
        Lecture = 'LCT', 'Lecture'
        Conference = 'CFE', 'Conference'
        Fair = 'FAR', 'Fair'
        Gastronomy = 'GST', 'Gastronomy'                    
        StandUp = 'SUP', 'Stand-up Comedy'                  
        Tour = 'TRS', 'Tour / Sightseeing'                  
        Workshop = 'WRK', 'Course / Workshop'               
        Kids = 'KID', 'Kids / Family'                       
        Pride = 'PRD', 'Pride / LGBTQIA+'                   
        OnlineEvent = 'ONL', 'Online Event'                 
        Spirituality = 'REL', 'Religion / Spirituality'     
        Technology = 'TEC', 'Technology'                    
        Others = 'OTH', 'Others'
        

    category=models.CharField(max_length=3, choices=Category.choices,default=Category.Others)
    space=models.ForeignKey(Space, on_delete=models.CASCADE)
    type_event=models.CharField(max_length=100)
    age_range=models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True, null=True)  # Data e hora em que a tarefa foi criada
    documentations = models.ManyToManyField(
        'self',
        through='EventDocumentation',
        symmetrical=False,  # Relação não recíproca
        blank=True
    )
    participants = models.ManyToManyField(
        'Users.CustomUser', 
        through='EventRegistration',
        related_name='events_participated',
        blank=True
    )


class EventDocumentation(models.Model):
    from_space = models.ForeignKey(
        Space, 
        on_delete=models.CASCADE,
        #related_name='documentations_created'
    )
    to_event = models.ForeignKey( 
        Event, 
        on_delete=models.CASCADE,
        #related_name='documentations_received'
    )
    document = models.FileField(upload_to='event_docs/')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('from_space', 'to_event')
    def __str__(self):
        return f"Documento de {self.from_space} para {self.to_event}"


class EventRegistration(models.Model):
    user = models.ForeignKey('Users.CustomUser', on_delete=models.CASCADE)
    event = models.ForeignKey('Event', on_delete=models.CASCADE)
    registration_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'event')  # Evita registros duplicados

    def __str__(self):
        return f"{self.user.username} - {self.event.title}"


class Image(models.Model):
    url=models.URLField()
    events=models.ForeignKey(Event,on_delete=models.CASCADE )
    created_at = models.DateTimeField(auto_now_add=True, null=True)  # Data e hora em que a tarefa foi criada
