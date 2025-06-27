// import 'dart:convert';
// import 'package:viveri/events/data/http/exceptions.dart';
// import 'package:viveri/events/data/http/http_client.dart';
// abstract class INotificationsRepository {
//   Future<List<String>> getNotifications();
// }

// class NotificationsRepository implements INotificationsRepository {
//   final IHttpClient client;

//   NotificationsRepository({required this.client});

//   @override
//   Future<List<String>> getNotifications() async {
//     final response = await client.get(
//       url: 'http://localhost:8000/api/notifications/',
//     );
//     if (response.statusCode == 200) {
//       final List<String> notifications = [];

//       final body = jsonDecode(response.body);

//       body['notifications'].map((item) {
//         final String notification = item['title'] as String;
//         notifications.add(notification);
//       }).toList();
//       return notifications;
//     } else if (response.statusCode == 404) {
//       throw NotFoundException(message: 'A url informada não é válida');
//     } else {
//       throw Exception('Não foi possível encontrar as notificações');
//     }
//   }
// }


import 'dart:convert';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/notifications_model.dart';

abstract class INotificationsRepository {
  Future<List<NotificationsModel>> getNotifications();
}

class NotificationsRepository implements INotificationsRepository {
  final IHttpClient client;

  NotificationsRepository({required this.client});

  @override
  Future<List<NotificationsModel>> getNotifications() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/notifications/',
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      // Verifica se o formato da resposta é compatível
      final List<NotificationsModel> notifications = body['notifications']
          .map<NotificationsModel>((item) => NotificationsModel.fromMap(item))
          .toList();

      return notifications;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A URL informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar as notificações');
    }
  }
}
