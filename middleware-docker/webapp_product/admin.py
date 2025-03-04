from django.contrib import admin
from .models import WebProduct
# Register your models here.


class WebProductAdmin(admin.ModelAdmin):
    list_display = ("name",)

admin.site.register(WebProduct,WebProductAdmin)
