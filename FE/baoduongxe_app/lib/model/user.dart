import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.userId,
    this.name,
    this.username,
    this.email,
    this.password,
  });

  int? userId;
  String? name;
  String? username;
  String? email;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userID"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    // "userID": userId,
    "name": name,
    "username": username,
    "email": email,
    "password": password,
  };
}
