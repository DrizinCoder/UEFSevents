from django.shortcuts import render
from django.http import HttpResponse
from django import forms
from .models import Event,Space,Adress

def event_view(request):
    # return HttpResponse("Events!")
    events=Event.objects.all()    #recuperando eventos
    # form=EventForm()                #instanciando formulario
    # if request.method=='POST':      #formulario submetido
    #     form=EventForm(request.POST)  #salva dados da solicitação
    #     if form.isvalid():
    #         form.save()    
    #         return redirect ('events_list')
    return render(request,'events_template.html', {'events':events})  

def event_detail_view(request, id):
    event = Event.objects.get(pk=id)  # Busca o evento pela primary key (ID)
    return render(request, 'event_detail.html', {'event': event})  # Renderiza o template               

class EventForm(forms.ModelForm):
    class Meta:
        model=Event
        fields = '__all__'

class SpaceForm(forms.ModelForm):
    class Meta:
        model=Space
        fields = '__all__'


class SpaceForm(forms.ModelForm):
    class Meta:
        model=Adress
        fields = '__all__'
# contexto={:}
# return render(request,'events_template',contexto)
   
