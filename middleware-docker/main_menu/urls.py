from django.urls import path, include
from . import views
from .views import MainMenuView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'main_menu', MainMenuView)

urlpatterns = [
    path('', include(router.urls)),

]
