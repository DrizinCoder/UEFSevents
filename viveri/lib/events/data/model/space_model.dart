
class SpaceModel {
  final String max_capacity;
  final String name;
  final String acessibility;
  final String phone;
  final String mobile;
  final String type_adress;
  final String adress;
  final String created_at;
  
  SpaceModel({
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
      max_capacity: map['max_capacity'],
      name: map['name'],
      acessibility: map['acessibility'],
      phone: map['phone'],
      mobile: map['mobile'],
      type_adress: map['type_adress'],
      adress: map['adress'],
      created_at: map['created_at'],
    );
  }
}
