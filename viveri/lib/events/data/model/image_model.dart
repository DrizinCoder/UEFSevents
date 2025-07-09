
class ImageModel {
  final int id;
  final String url;
  final int events;
  final String created_at;


  ImageModel({
    required this.id,
    required this.url,
    required this.events,
    required this.created_at,
  });
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id']??0,
      url: map['url']??'',
      events: map['events']??0,
      created_at: map['created_at']??'',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'url':url,
      'events':events,
    };
  }

}
