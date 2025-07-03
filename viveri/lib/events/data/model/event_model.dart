import 'dart:convert';

class EventModel {
  final int id;
  final String title;
  final String description;
  final String start_date;
  final String end_date;
  final String start_time;
  final String endtime;
  final bool status;
  final String category;
  final int space;
  final String type_event;
  final int age_range;
  final String crated_at;
  final String documentations;
  final List<dynamic> participants;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.start_date,
    required this.end_date,
    required this.start_time,
    required this.endtime,
    required this.status,
    required this.category,
    required this.space,
    required this.type_event,
    required this.age_range,
    required this.crated_at,
    required this.documentations,
    required this.participants,
  });
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id']??0,
      title: map['title']??'',
      description: map['description']??'',
      start_date: map['start_date']??'',
      end_date: map['end_date']??'',
      start_time: map['start_time']??'',
      endtime: map['endtime']??'',
      status: map['status']??false,
      category: map['category']??'',
      space: map['space']??0,
      type_event: map['type_event']??'',
      age_range: map['age_range']??0,
      crated_at: map['crated_at']??'',
      documentations: map['documentations']??'',
      participants: map['participants']??[],
    );
  }

  Map<String, dynamic> toJson(){
    return{
     // 'id':id,
      'title':title,
      'description':description,
      'start_date':start_date,
      'end_date':end_date,
      'start_time':start_time,
      'endtime':endtime,
      'status':status,
      'category':category,
      'space':space,
      'type_event':type_event,
      'age_range':age_range,
     // 'crated_at':crated_at,
     // 'documentations':documentations,
   //   'participants':participants,
    };
  }

}
//mapa = JsonEncoder(eventModel.toMap()).convert(eventModel);)
