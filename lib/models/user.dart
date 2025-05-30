import 'dart:convert';

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
      id: map['id'] as int?,
      fullName: map['full_name'] as String?,
      email: map['email'] as String?,
      emailVerifiedCode: map['email_verified_code'] as int?,
      emailVerified: map['email_verified'] as bool?,
      authProvider: map['auth_provider'] as String?,
      profilePic: map['profile_pic'] as String?,
      phone: map['phone'] as String?,
      phoneVerifyCode: map['phone_verify_code'] as String?,
      phoneVerified: map['phone_verified'] as bool?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
