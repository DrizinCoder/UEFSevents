from django.shortcuts import get_object_or_404
from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.decorators import action
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import CustomUserSerializer
from rest_framework.permissions import IsAuthenticated, AllowAny
from .models import CustomUser
from rest_framework.permissions import IsAdminUser

class CustomUserViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = ['user_type', 'verified_seal']
    search_fields = ['username', 'email', 'vat']
    ordering_fields = ['date_joined', 'last_login']
    ordering = ['-date_joined']

    def get_permissions(self):
        if self.action in ['create']:
            return [AllowAny()]
        return [IsAuthenticated()]

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = self.perform_create(serializer)
        
        # Gera tokens JWT
        refresh = RefreshToken.for_user(user)
        data = serializer.data
        data['tokens'] = {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }
        
        headers = self.get_success_headers(serializer.data)
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)

    def perform_create(self, serializer):
        user = serializer.save()
        if 'password' in serializer.validated_data:
            user.set_password(serializer.validated_data['password'])
            user.save()
        return user

    def get_queryset(self):
        # Filtra usuários inativos para não-administradores
        queryset = super().get_queryset()
        if not self.request.user.is_staff:
            queryset = queryset.filter(is_active=True)
        return queryset

    @action(detail=True, methods=['post'], url_path='activate')
    def activate_user(self, request, pk=None):
        """Ativa um usuário desativado"""
        user = self.get_object()
        user.is_active = True
        user.save()
        return Response({'status': 'user activated'})

    @action(detail=False, methods=['get'], url_path='me')
    def get_current_user(self, request):
        """Obtém dados do usuário logado"""
        serializer = self.get_serializer(request.user)
        return Response(serializer.data)

    @action(detail=False, methods=['get'], url_path='fuglemans')
    def list_fuglemans(self, request):
        """Lista todos os Fuglemans"""
        queryset = self.get_queryset().filter(user_type='fugleman')
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def destroy(self, request, *args, **kwargs):
        """Desativação suave do usuário"""
        instance = self.get_object()
        instance.is_active = False
        instance.save()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
    @action(detail=False, methods=['get'], permission_classes=[IsAuthenticated])
    def me(self, request):
        serializer = self.get_serializer(request.user)
        return Response(serializer.data)

    @action(
        detail=True,
        methods=['post'],
        permission_classes=[IsAdminUser],  # Restringe a admins
        url_path='activate',
        url_name='activate-user'
    )
    def activate(self, request, pk=None):
        user = self.get_object()
        user.is_active = True
        user.save()
        return Response({'status': 'user activated'})

    @action(detail=False, methods=['get'])
    def fuglemans(self, request):
        fuglemans = CustomUser.fuglemans.all()
        serializer = self.get_serializer(fuglemans, many=True)
        return Response(serializer.data)