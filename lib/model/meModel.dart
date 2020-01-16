class MeModel {
  final String name;
  final String email;
  final String gender;
  final String phone;
  final String address;
  final String dob;
  final String description;

  MeModel({this.name, this.email, this.gender, this.phone, this.address,
      this.dob, this.description});

  factory MeModel.fromJson(Map<String, dynamic> json){
    final data = json['data'];
    print(data['name']);
    return MeModel(
      name : data['name'],
      email : data['email'],
      gender : data['gender'],
      phone : data['phone'],
      address : data['address'],
      dob : data['dob'],
      description : data['description']
    );
  }
}