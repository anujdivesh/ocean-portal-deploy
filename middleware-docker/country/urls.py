from django.urls import path, include
from . import views
from .views import CountryView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'country', CountryView)

urlpatterns = [
    path('', include(router.urls))  
]
