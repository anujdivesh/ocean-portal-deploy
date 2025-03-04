from django.contrib import admin
from .models import DownloadMethod
# Register your models here.


class DownloadMethodAdmin(admin.ModelAdmin):
    list_display = ("id","name",)

admin.site.register(DownloadMethod,DownloadMethodAdmin)
