from rest_framework.serializers import ModelSerializer
from core.models import Partner


class PartnerSerializer(ModelSerializer):
    class Meta:
        model = Partner
        fields = ['id', 'name', 'logo', 'description', 'id_athletic']