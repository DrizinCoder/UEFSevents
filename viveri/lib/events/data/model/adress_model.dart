
class AdressModel {
  final String adress_zip_code;
  final String adress_city;
  final String adress_state;
  final String adress_street;
  final String adress_neighborhood;
  final String created_at;


  AdressModel({
    required this.adress_zip_code,
    required this.adress_city,
    required this.adress_state,
    required this.adress_street,
    required this.adress_neighborhood,
    required this.created_at
  });
  factory AdressModel.fromMap(Map<String, dynamic> map) {
    return AdressModel(
      adress_zip_code: map['adress_zip_code'],
      adress_city: map['adress_city'],
      adress_state: map['adress_state'],
      adress_street: map['adress_street'],
      adress_neighborhood: map['adress_neighborhood'],
      created_at: map['created_at'],
    
    );
  }
}
