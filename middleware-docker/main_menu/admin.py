from django.contrib import admin
from .models import MainMenu
# Register your models here.


class MainMenuAdmin(admin.ModelAdmin):
    list_display = ("title","display_title",)

admin.site.register(MainMenu,MainMenuAdmin)
