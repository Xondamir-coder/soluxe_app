import 'dart:convert';
import 'package:soluxe/models/user.dart';

class Account {
  final String? token;
  final User? user;
  Account({
    this.token,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'user': user?.toMap(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      token: map['token'] as String,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
}
