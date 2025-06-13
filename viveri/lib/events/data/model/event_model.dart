class EventModel {
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
}
