from django.db import models


class Partner(models.Model):
    name = models.CharField(max_length=50, blank=True, null=True)
    logo = models.ImageField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    id_athletic = models.IntegerField(null=False)

    def __str__(self):
        return self.name



