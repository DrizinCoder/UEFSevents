import 'package:flutter/foundation.dart';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/model/adress_model.dart';
import 'package:viveri/events/data/repositories/adress_repositories.dart';

class AdressStore {
  final IAdressReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<AdressModel>> state = ValueNotifier<List<AdressModel>>(
    [],
  );

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  AdressStore({required this.repository});
  Future getAdress() async {
    isLoading.value = true;

    try {
      final result = await repository.getAdress();
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
