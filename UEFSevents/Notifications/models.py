from django.db import models

class Notifications(models.Model):
    notification_id = models.IntegerField(primary_key=True)
    notification_message = models.CharField(max_length=250)
    notification_status = models.CharField(max_length=30)
    notification_fk_user = models.ForeignKey(notification_id, on_delete=models.CASCADE)
    