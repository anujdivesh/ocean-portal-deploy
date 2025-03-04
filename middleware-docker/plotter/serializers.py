from rest_framework import serializers
from .models import Plotter

class PlotterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plotter
        fields = ('__all__') 