from django.urls import path, include
from . import views
from .views import DownloadMethodView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'download_method', DownloadMethodView)

urlpatterns = [
    path('', include(router.urls))  
]
