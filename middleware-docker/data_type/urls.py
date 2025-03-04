from django.urls import path, include
from . import views
from .views import DataTypeView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'data_type', DataTypeView)

urlpatterns = [
    path('', include(router.urls))  
]
