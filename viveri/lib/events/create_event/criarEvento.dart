/*
import 'dart:convert';

Future<void> createEvent(EventModel event) async {
  final url = 'http://localhost:8000/api/eventsapi/';

  final response = await client.post(
    url: url,
    headers: {
      'Content-Type': 'application/json',
       'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk' // se necessário
    },
    body: jsonEncode(event.toMap()), // ou event.toJson() se você tiver esse método
  );

  if (response.statusCode == 201) {
    print('Evento criado com sucesso');
  } else {
    print('Erro ao criar evento: ${response.statusCode}');
    throw Exception('Erro ao criar evento');
  }
}

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk

 */