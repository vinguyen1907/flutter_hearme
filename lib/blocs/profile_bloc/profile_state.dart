// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final File? avatar;
  final String fullName;
  final String nickname;
  final String email;
  final String phoneNumber;
  final DateTime? birthday;
  final String? country;

  static final time = DateTime.now();

  const ProfileState({
    this.avatar,
    this.fullName = '',
    this.nickname = '',
    this.email = '',
    this.phoneNumber = '',
    this.birthday,
    this.country,
  });

  @override
  List<Object> get props => [
        avatar ?? 'assets/images/profile/jpg',
        fullName,
        nickname,
        email,
        phoneNumber,
        birthday ?? time,
        country ?? '',
      ];

  ProfileState copyWith({
    File? avatar,
    String? fullName,
    String? nickname,
    String? email,
    String? phoneNumber,
    DateTime? birthday,
    String? country,
  }) {
    return ProfileState(
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      country: country ?? this.country,
    );
  }
}
