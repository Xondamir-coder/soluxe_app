class UserSummary {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String profileImgSrc;

  const UserSummary({
    required this.id,
    required this.name,
    required this.profileImgSrc,
    this.email,
    this.phoneNumber,
  });
}
