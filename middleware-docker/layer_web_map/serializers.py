from rest_framework import serializers
from .models import LayerWebMap

class LayerWebMapSerializer(serializers.ModelSerializer):
    class Meta:
        model = LayerWebMap
        fields = ('__all__') 