from django.contrib import admin
from .models import LayerWebMap
# Register your models here.


class LayerWebMapAdmin(admin.ModelAdmin):
    list_display = ("layer_title",)

admin.site.register(LayerWebMap,LayerWebMapAdmin)
