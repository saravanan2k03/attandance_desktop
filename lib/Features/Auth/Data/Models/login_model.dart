import 'dart:convert';

class LoginModel {
  User? user;
  Tokens? tokens;
  LoginModel({this.user, this.tokens});
  LoginModel copyWith({User? user, Tokens? tokens}) {
    return LoginModel(user: user ?? this.user, tokens: tokens ?? this.tokens);
  }

  Map<String, dynamic> toMap() {
    return {'user': user?.toMap(), 'tokens': tokens?.toMap()};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      user: User.fromMap(map['user']),
      tokens: Tokens.fromMap(map['tokens']),
    );
  }
  String toJson() => json.encode(toMap());
  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));
  @override
  String toString() =>
      'LoginModel(user: ${user.toString()}, tokens: ${tokens.toString()})';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel && other.user == user && other.tokens == tokens;
  }

  @override
  int get hashCode => user.hashCode ^ tokens.hashCode;
}

class User {
  String? username;
  int? id;
  String? email;
  String? userType;

  User({this.username, this.id, this.email, this.userType});
  User copyWith({String? username, int? id, String? email, String? userType}) {
    return User(
      username: username ?? this.username,
      id: id ?? this.id,
      email: email ?? this.email,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'id': id,
      'email': email,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      userType: map['user_type'],
      id: map['id'],
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  @override
  String toString() {
    return 'User(username: $username, id: $id, email: $email, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.id == id &&
        other.email == email &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return username.hashCode ^ id.hashCode ^ email.hashCode ^ userType.hashCode;
  }
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});
  Tokens copyWith({String? refresh, String? access}) {
    return Tokens(
      refresh: refresh ?? this.refresh,
      access: access ?? this.access,
    );
  }

  Map<String, dynamic> toMap() {
    return {'refresh': refresh, 'access': access};
  }

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return Tokens(refresh: map['refresh'], access: map['access']);
  }
  String toJson() => json.encode(toMap());
  factory Tokens.fromJson(String source) => Tokens.fromMap(json.decode(source));
  @override
  String toString() => 'Tokens(refresh: $refresh, access: $access)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tokens &&
        other.refresh == refresh &&
        other.access == access;
  }

  @override
  int get hashCode => refresh.hashCode ^ access.hashCode;
}
