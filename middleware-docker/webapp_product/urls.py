from django.urls import path, include
from . import views
from .views import WebProductView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'webapp_product', WebProductView)

urlpatterns = [
    path('', include(router.urls)),

]
