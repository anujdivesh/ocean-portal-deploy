from django.urls import path, include
from . import views
from .views import ThemeView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'theme', ThemeView)

urlpatterns = [
    path('', include(router.urls)),

]
