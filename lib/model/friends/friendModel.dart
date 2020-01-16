class FriendModel {
  String name;
  String address;

  FriendModel(this.name, this.address);

  FriendModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'];

  Map<String, dynamic> toJson() => {'name': name, 'address': address};

  @override
  String toString() {
    return "$name: $address";
  }
}
