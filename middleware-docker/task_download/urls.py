from django.urls import path, include
from . import views
from .views import TaskDownloadView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'task_download', TaskDownloadView)

urlpatterns = [
    path('', include(router.urls)),

]
