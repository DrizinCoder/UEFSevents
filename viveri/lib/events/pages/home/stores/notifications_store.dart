import 'package:flutter/foundation.dart';
import 'package:viveri/events/data/model/notifications_model.dart';
import 'package:viveri/events/data/repositories/notifications_repositories.dart';
import 'package:viveri/events/data/http/exceptions.dart';

class NotificationsStore {
  final INotificationsRepository repository;
  final ValueNotifier<List<NotificationsModel>> state = ValueNotifier([]);
  final ValueNotifier<bool> isLoading=ValueNotifier(false);
  final ValueNotifier<String?> error=ValueNotifier<String>("");

  NotificationsStore({required this.repository});
  getNotifications() async {
    isLoading.value = true;
    try {
      await repository.getNotifications();
      final notificationsVar = await repository.getNotifications();
      state.value = notificationsVar;
    } on NotFoundException catch (e) {
      error.value = e.message;
    }catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


}