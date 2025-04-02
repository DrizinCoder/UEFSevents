from django.shortcuts import render, redirect, get_object_or_404
from .models import CustomUser
from .forms import CustomUserForm


def create_user(request):
    if request.method == 'POST':
        form = CustomUserForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('user_list')
    else:
        form = CustomUserForm()

    return render(request, 'create_user.html', {'form': form})

def user_list(request):
    users = CustomUser.objects.all()
    return render(request, 'user_list.html', {'users': users})

def user_detail(request, user_id):
    user = get_object_or_404(CustomUser.objects, pk=user_id)
    return render(request, 'user_detail.html', {'user': user})
