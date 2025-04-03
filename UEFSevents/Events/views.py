from django.http import HttpResponse
from django import forms
from .models import Event,Space,Adress,Image
from django.views.generic.edit import CreateView, DeleteView, UpdateView
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST




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
    return render(request, 'event_detail.html', {'event': event})# Renderiza o template    

class EventCreateView(CreateView):
    model = Event  
    fields = '__all__' 
    template_name = 'create_event.html'  
    success_url = '/event/'  
    
class EventUpdateView(UpdateView):
    model = Event  
    fields = '__all__' 
    template_name = 'event_update.html'  
    pk_url_kwarg = 'id'
    success_url = '/event/'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Passa todos os espaços para o template para preencher o select
        context['spaces'] = Space.objects.all()
        return context
    
def event_delete_view(request, id):
    event = get_object_or_404(Event, pk=id)
    event.delete()
    return redirect('/event/')

class EventForm(forms.ModelForm):
    class Meta:
        model=Event
        fields = '__all__'

class SpaceForm(forms.ModelForm):
    class Meta:
        model=Space
        fields = '__all__'


class AdressForm(forms.ModelForm):
    class Meta:
        model=Adress
        fields = '__all__'

class ImageForm(forms.ModelForm):
    class Meta:
        model=Image
        fields = '__all__'

# contexto={:}
# return render(request,'events_template',contexto)


class SpaceCreateView(CreateView):
    model = Space  
    fields = '__all__' 
    template_name = 'criar_espaco.html'  
    success_url = '/events/'

class AdressCreateView(CreateView):
    model = Adress 
    fields = '__all__' 
    template_name = 'criar_endereço.html'  
    success_url = '/events/'

class ImageCreateView(CreateView):
    model = Image
    fields = '__all__' 
    template_name = 'events/events_template.html'  
    success_url = '/events/'
   
# def iodaste_view():     
# def delete_view():  


from rest_framework import viewsets
from .models import Event,Adress,Space,Image
from .serializers import EventSerializer,AdressSerializer,ImageSerializer,SpaceSerializer

class EventViewSet(viewsets.ModelViewSet):
    queryset=Event.objects.all()
    serializer_class=EventSerializer

class AdressViewSet(viewsets.ModelViewSet):
    queryset=Adress.objects.all()
    serializer_class=AdressSerializer

class SpaceViewSet(viewsets.ModelViewSet):
    queryset=Space.objects.all()
    serializer_class=SpaceSerializer

class ImageViewSet(viewsets.ModelViewSet):
    queryset=Image.objects.all()
    serializer_class=ImageSerializer