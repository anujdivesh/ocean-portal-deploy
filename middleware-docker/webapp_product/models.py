from django.db import models
from layer_web_map.models import LayerWebMap
# Create your models here.
class WebProduct(models.Model):
    name = models.CharField()
    layer_information = models.ForeignKey(LayerWebMap, on_delete=models.CASCADE, related_name='layer_id',blank=True)
    copyright = models.CharField()
    has_bbox = models.BooleanField()
    bbox_type = models.CharField(max_length=255,default='rectangle')
    west_bound_longitude = models.FloatField()
    east_bound_longitude = models.FloatField()
    south_bound_latitude = models.FloatField()
    north_bound_latitude = models.FloatField()
    metadata_one_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_one_value = models.CharField(max_length=255,null=True,blank=True)
    metadata_two_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_two_value = models.CharField(max_length=255,null=True,blank=True)
    metadata_three_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_three_value = models.CharField(max_length=255,null=True,blank=True)
    metadata_four_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_four_value = models.CharField(max_length=255,null=True,blank=True)
    metadata_five_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_five_value = models.CharField(max_length=255,null=True,blank=True)
    metadata_six_id = models.CharField(max_length=255,null=True,blank=True)
    metadata_six_value = models.CharField(max_length=255,null=True,blank=True)
    enabled = models.BooleanField()

    def __str__(self):
        return f"{self.name}"