import 'package:flutter/foundation.dart';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/model/space_model.dart';
import 'package:viveri/events/data/repositories/space_repositories.dart';

class SpaceStore {
  final ISpaceReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<SpaceModel>> state = ValueNotifier<List<SpaceModel>>(
    [],
  );

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  SpaceStore({required this.repository});
  Future getSpace() async {
    isLoading.value = true;

    try {
      final result = await repository.getSpace();
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
