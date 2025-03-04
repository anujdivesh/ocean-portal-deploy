from django.urls import path, include
from . import views
from .views import DatasetView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'dataset', DatasetView)

urlpatterns = [
    path('', include(router.urls))  
]
