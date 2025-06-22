import 'package:flutter/foundation.dart';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';

class EventStore {
  final IEventReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<EventModel>> state = ValueNotifier<List<EventModel>>(
    [],
  );

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  EventStore({required this.repository});
  Future getEvents() async {
    isLoading.value = true;

    try {
      final result = await repository.getEvent();
      state.value = result;
    } on NotFoundException catch(e){
      erro.value = e.message;
    }
     catch (e) {
      erro.value = e.toString();
     }
     isLoading.value=false;
  }
}
