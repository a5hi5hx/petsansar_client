import 'dart:convert';

class User {
final String? name;
  final String? email;
  final String? phoneNumber;
  final String? image;
  final String? id;
  final String? password;
  final String? isVerified;
  final String? token;

  User(
      { this.name,
    this.email,
    this.phoneNumber,
    this.image,
    this.id,
    this.password,
    this.isVerified,
    this.token,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'isVerified': isVerified,
       'password': password,
     'phoneNumber': phoneNumber,
       'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      image: map['image'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      isVerified: map['isVerified'] ?? '',
       password: map['password'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
