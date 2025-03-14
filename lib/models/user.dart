import 'dart:convert';

import 'package:soluxe/constants/constants.dart';

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final int? emailVerifiedCode;
  final bool? emailVerified;
  final String? authProvider;
  final String? profilePic;
  final String? phone;
  final String? phoneVerifyCode;
  final bool? phoneVerified;
  final String? createdAt;
  final String? updatedAt;
  User({
    this.fullName,
    this.email,
    this.profilePic,
    this.phone,
    this.id,
    this.emailVerifiedCode,
    this.emailVerified,
    this.authProvider,
    this.phoneVerifyCode,
    this.phoneVerified,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    int? emailVerifiedCode,
    bool? emailVerified,
    String? authProvider,
    String? profilePic,
    String? phone,
    String? phoneVerifyCode,
    bool? phoneVerified,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      emailVerifiedCode: emailVerifiedCode ?? this.emailVerifiedCode,
      emailVerified: emailVerified ?? this.emailVerified,
      authProvider: authProvider ?? this.authProvider,
      profilePic: profilePic ?? this.profilePic,
      phone: phone ?? this.phone,
      phoneVerifyCode: phoneVerifyCode ?? this.phoneVerifyCode,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'email': email,
      'email_verified_code': emailVerifiedCode,
      'email_verified': emailVerified,
      'auth_provider': authProvider,
      'profile_pic': profilePic,
      'phone': phone,
      'phone_verify_code': phoneVerifyCode,
      'phone_verified': phoneVerified,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toInt() as int,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      emailVerifiedCode: map['email_verified_code'].toInt() as int,
      emailVerified: map['email_verified'] as bool,
      authProvider: map['auth_provider'] as String,
      profilePic: '${Constants.imgUrl}/${map['profile_pic'] as String}',
      phone: map['phone'] as String,
      phoneVerifyCode: map['phone_verify_code'] as String,
      phoneVerified: map['phone_verified'] as bool,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
