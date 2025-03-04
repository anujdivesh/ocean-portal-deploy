from django.contrib import admin
from .models import Plotter
# Register your models here.


class PlotterAdmin(admin.ModelAdmin):
    list_display = ("title",)

admin.site.register(Plotter,PlotterAdmin)
