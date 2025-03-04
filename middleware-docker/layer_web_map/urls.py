from django.urls import path, include
from . import views
from .views import LayerWebMapView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'layer_web_map', LayerWebMapView)

urlpatterns = [
    path('', include(router.urls)),

]
