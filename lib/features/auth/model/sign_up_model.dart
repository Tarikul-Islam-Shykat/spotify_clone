// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSignUpModel {
  final String? name;
  final String? email;
  final String? password;
  final String? id;
  final String? token;
  UserSignUpModel({
    this.name,
    this.email,
    this.password,
    this.id,
    this.token,
  });

  UserSignUpModel copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? token,
  }) {
    return UserSignUpModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'token': token,
    };
  }

  factory UserSignUpModel.fromMap(Map<String, dynamic> map) {
    return UserSignUpModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignUpModel.fromJson(String source) =>
      UserSignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSignUpModel(name: $name, email: $email, password: $password, id: $id, token: $token)';
  }

  @override
  bool operator ==(covariant UserSignUpModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        id.hashCode ^
        token.hashCode;
  }
}




/*
class UserSignUpModel {
  final String? name;
  final String? email;
  final String? password;
  final String? id;

  UserSignUpModel(
      {this.name = '',
      required this.email,
      required this.password,
      this.id = ''});

  UserSignUpModel copyWith(
      {String? name, String? email, String? password, String? id}) {
    return UserSignUpModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  
}
*/