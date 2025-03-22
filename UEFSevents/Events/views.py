from django.shortcuts import render
from django.http import HttpResponse
from django import forms
from .models import Event,Space,Adress

def event_view(request):
    return HttpResponse("Events!")
    events=Event.objects.all()    #recuperando eventos
    form=EventForm()                #instanciando formulario
    if request.method=='POST':      #formulario submetido
        form=EventForm(request.POST)  #salva dados da solicitação
        if form.isvalid():
            form.save()    
            return redirect ('events_list')

    return render(request,'events_template.html', {'events':events,'form':form})                 

class EventForm(forms.ModelForm):
    class Meta:
        model=Event
        fields=['title','description','start_dsate','end_date','start_time','endtime','status','category','space','type_event','age_range']

class SpaceForm(forms.ModelForm):
    class Meta:
        model=Space
        fields=['max_capacity','name','acessibility','phone','mobile','type_adress']


class SpaceForm(forms.ModelForm):
    class Meta:
        model=Adress
    fields=['adress_zip_code','adress_city','adress_state','adress_street','adress_neighborhood']
# contexto={:}
# return render(request,'events_template',contexto)
   
