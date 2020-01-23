class User {
  final String id;
  final String displayName;
  final String email;
  final String gender;
  final String phone;
  final String address;
  final String dob;
  final String status;
  final String avatar;

  User(
      {this.id,
      this.displayName,
      this.email,
      this.gender,
      this.phone,
      this.address,
      this.dob,
      this.status,
      this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'].toString(),
        displayName: json['first_name'] + ' ' + json['last_name'],
        email: json['email'],
        gender: json['gender'],
        phone: json['phone'],
        address: json['address'],
        dob: json['dob'],
        status: json['status'],
        avatar: json['_links']['avatar']['href']);
  }
}
