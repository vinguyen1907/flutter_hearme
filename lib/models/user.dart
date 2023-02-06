import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfile {
  String fullName;
  String nickname;
  String email;
  String birthday;
  String phoneNumber;
  String country;
  UserProfile({
    required this.fullName,
    required this.nickname,
    required this.email,
    required this.birthday,
    required this.phoneNumber,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'nickname': nickname,
      'email': email,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'country': country,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['fullName'] as String,
      nickname: map['nickname'] as String,
      email: map['email'] as String,
      birthday: map['birthday'].toString(),
      phoneNumber: map['phone'] ?? '',
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
