from rest_framework.viewsets import ModelViewSet
from core.models import Partner
from .serializers import PartnerSerializer


class PartnerViewSet(ModelViewSet):
    queryset = Partner.objects.all()
    serializer_class = PartnerSerializer

    def get_queryset(self):
        queryset = Partner.objects.all()
        id_partner = self.request.query_params.get('id', None)  # Esse none é pra caso não venha um id na url não parar a aplicação

        if id_partner:
            queryset = Partner.objects.filter(id=id_partner)
        return queryset