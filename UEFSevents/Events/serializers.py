from  rest_framework import serializers
from .models import Event,Adress,Space,Image



class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model=Event
        fields='__all__'

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model=Image
        fields='__all__'

class AdressSerializer(serializers.ModelSerializer):
    class Meta:
        model=Adress
        fields='__all__'

class SpaceSerializer(serializers.ModelSerializer):
    class Meta:
        model=Space
        fields='__all__'
