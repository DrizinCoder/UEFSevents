class NotificationsModel {
  final String title;
  final String text;
  final String date;

  NotificationsModel({
    required this.title,
    required this.text,
    required this.date,
  });

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      title: map['title'] ?? '',
      text: map['text'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
