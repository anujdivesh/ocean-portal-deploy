from django.contrib import admin
from .models import Theme
# Register your models here.

class ThemeAdmin(admin.ModelAdmin):
    list_display = ("name",)

admin.site.register(Theme,ThemeAdmin)
