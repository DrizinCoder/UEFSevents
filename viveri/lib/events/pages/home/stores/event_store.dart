import 'package:flutter/foundation.dart';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/events_search.dart'show limit;

class EventStore {
 // var next = '';
 //int page = 1;
  final IEventReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<EventModel>> state = ValueNotifier<List<EventModel>>(
    [],
  );

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  EventStore({required this.repository});

  Future getEvents(page) async {
 //   print(page);
    isLoading.value = true;

    try {
     // if(limit){
     //   return;
    //  }
   //  // print(page);
      final result = await repository.getEvent(page);
      print(page);
      //print(result);
   //   print(result.last.id);
      //print(state.value.length);
    //  print(result.length);
      state.value = result;
   //   print(state.value.length);

    } on NotFoundException catch (e) {
      erro.value = e.message;
    }
    catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
 // page++;
  }

}