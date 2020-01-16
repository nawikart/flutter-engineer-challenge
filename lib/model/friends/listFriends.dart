import 'friendModel.dart';

class ListFriends {
  static var empty = ListFriends(new List());

  final List<FriendModel> data;

  ListFriends(this.data);

  ListFriends.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List)
            .map((i) => new FriendModel.fromJson(i as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {'data': data};

  @override
  String toString() => "$data";
}
