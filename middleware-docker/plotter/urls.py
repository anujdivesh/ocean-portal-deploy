from django.urls import path, include
from . import views
from .views import PlotterView  
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'plotter', PlotterView)

urlpatterns = [
    path('', include(router.urls)),

]
