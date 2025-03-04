from rest_framework import serializers
from .models import DataType

class DataTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DataType
        fields = ('__all__') 