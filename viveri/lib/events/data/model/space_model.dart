
class SpaceModel {
  final int id;
  final String max_capacity;
  final String name;
  final bool acessibility;
  final String phone;
  final String mobile;
  final String type_adress;
  final String adress;
  final String created_at;
  
  SpaceModel({
    required this.id,
    required this.max_capacity,
    required this.name,
    required this.acessibility,
    required this.phone,
    required this.mobile,
    required this.type_adress,
    required this.adress,
    required this.created_at,
  });
  factory SpaceModel.fromMap(Map<String, dynamic> map) {
    return SpaceModel(
      id: map['id']??0,
      max_capacity: map['max_capacity']??'',
      name: map['name']??'',
      acessibility: map['acessibility']??false,
      phone: map['phone']??'',
      mobile: map['mobile']??'',
      type_adress: map['type_adress']??'',
      adress: map['adress']??'',
      created_at: map['created_at']??'',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'max_capacity':int.parse(max_capacity),
      'name':name,
      'acessibility':acessibility,
      'phone':phone,
      'mobile':mobile,
      'type_adress':type_adress,
      'adress':adress,
    };
  }

}
