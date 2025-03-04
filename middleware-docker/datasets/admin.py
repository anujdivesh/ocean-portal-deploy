from django.contrib import admin
from .models import Dataset
from django.db import models
from django.forms import TextInput, Textarea
# Register your models here.


class DatasetAdmin(admin.ModelAdmin):
    list_display = ("id","short_name", "long_name", "data_type","download_method","data_provider",)
    #formfield_overrides = {
    #    models.CharField: {'widget': TextInput(attrs={'size':'70'})}
    #}
    

admin.site.register(Dataset,DatasetAdmin)
