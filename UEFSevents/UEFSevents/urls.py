"""
URL configuration for UEFSevents project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from Events.views import (
    EventViewSet
    )

from FAQ.views import (
    QuestionViewSet, AnswerViewSet, Ans_To_AnsViewSet, ComplaintsViewSet
    )

from Users.views import CustomUserViewSet

router=DefaultRouter()
router.register('eventsapi',EventViewSet, basename='eventsapi')
router.register('users', CustomUserViewSet, basename='customuser')
router.register('perguntas-frequentes', QuestionViewSet, basename='perguntas-frequentes')
router.register('respostas', AnswerViewSet, basename='respostas')
router.register('resposta_respotas', Ans_To_AnsViewSet, basename='resposta_respostas')
router.register('reclame-aqui', ComplaintsViewSet, basename='reclame-aqui')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/users/me/', CustomUserViewSet.as_view({'get': 'me'}), name='users-me'),
]
