from rest_framework import serializers
from .models import DownloadMethod

class DownloadMethodSerializer(serializers.ModelSerializer):
    class Meta:
        model = DownloadMethod
        fields = ('__all__') 