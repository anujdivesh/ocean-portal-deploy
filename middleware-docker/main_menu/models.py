from django.db import models
from datasets.models import Dataset
from webapp_product.models import WebProduct
from theme.models import Theme
from django.contrib.postgres.fields import ArrayField
# Create your models here.
class MainMenu(models.Model):
    title = models.CharField(max_length=255)
    display_title = models.CharField(max_length=255,null=True,blank=True)
    theme = models.ForeignKey(Theme, on_delete=models.CASCADE, related_name='theme_id',blank=False)
    #content = ArrayField(models.CharField(max_length=100), blank=True, default=list)
    content = models.ManyToManyField(WebProduct, related_name='web_products',blank=True)

    class Meta:
        verbose_name_plural = 'Main Menu'  # Prevent pluralization
