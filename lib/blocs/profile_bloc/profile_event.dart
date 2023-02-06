// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateAvatar extends ProfileEvent {
  final File avatar;
  const UpdateAvatar({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class UpdateFullName extends ProfileEvent {
  final String fullName;
  const UpdateFullName({required this.fullName});

  @override
  List<Object> get props => [fullName];
}

class UpdateNickname extends ProfileEvent {
  final String nickname;
  const UpdateNickname({required this.nickname});

  @override
  List<Object> get props => [nickname];
}

class UpdateEmail extends ProfileEvent {
  final String email;
  const UpdateEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class UpdatePhoneNumber extends ProfileEvent {
  final String phoneNumber;
  const UpdatePhoneNumber({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class UpdateBirthday extends ProfileEvent {
  final DateTime birthday;
  const UpdateBirthday({required this.birthday});

  @override
  List<Object> get props => [birthday];
}

class UpdateCountry extends ProfileEvent {
  final String country;
  const UpdateCountry({required this.country});

  @override
  List<Object> get props => [country];
}

class UpdateProfile extends ProfileEvent {
  final String? fullName;
  final String? nickname;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthday;
  final String? country;
  UpdateProfile({
    this.fullName,
    this.nickname,
    this.email,
    this.phoneNumber,
    this.birthday,
    this.country,
  });

  @override
  List<Object> get props => [
        if (fullName != null) fullName!,
        if (nickname != null) nickname!,
        if (email != null) email!,
        if (phoneNumber != null) phoneNumber!,
        if (birthday != null) birthday!,
        if (country != null) country!,
      ];
}
