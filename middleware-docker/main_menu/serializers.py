from rest_framework import serializers
from .models import MainMenu

class MainMenuSerializer(serializers.ModelSerializer):
    class Meta:
        model = MainMenu
        fields = ('__all__') 
        depth = 1