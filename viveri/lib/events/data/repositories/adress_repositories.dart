import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/adress_model.dart';

abstract class IAdressReposity {
  Future<List<AdressModel>> getAdress();
}

class AdressRepository implements IAdressReposity {
  final IHttpClient client;

  AdressRepository({required this.client});
  @override
  Future<List<AdressModel>> getAdress() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/eventsapi/',
    );
    if (response.statusCode == 200) {
      final List<AdressModel> adress = [];

      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final AdressModel event = AdressModel.fromMap(item);
        adress.add(event);
      }).toList();
      return adress;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }
  }


  Future createAdress(AdressModel adress) async {
    final url = 'http://localhost:8000/api/address/';

    final response = await client.post(
      url: url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk' // se necessário
      },

        body: jsonEncode(adress.toJson()),
      // ou event.toJson() se você tiver esse método
    );
    print('Corpo do erro: ${response.body}');

    if (response.statusCode == 201) {
      final adressId = jsonDecode(response.body)['id'];
      return adressId;
    //  print('endereço criado com sucesso');
    } else {
     // return 'Erro ao criar evento: ${response.statusCode}';
      throw Exception('Erro ao criar evento');
    }
  }
}
