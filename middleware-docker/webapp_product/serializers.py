from rest_framework import serializers
from .models import WebProduct

class WebProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = WebProduct
        fields = ('__all__') 