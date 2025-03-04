from rest_framework import serializers
from .models import TaskDownload

class TaskDownloadSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskDownload
        fields = ('__all__') 