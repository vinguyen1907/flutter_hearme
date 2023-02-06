// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<UpdateAvatar>(_onUpdateAvatar);
    on<UpdateFullName>(_onUpdateFullName);
    on<UpdateNickname>(_onUpdateNickname);
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<UpdateBirthday>(_onUpdateBirthday);
    on<UpdateCountry>(_onUpdateCountry);
    on<UpdateProfile>(_onUpdateProfile);
  }

  _onUpdateAvatar(UpdateAvatar event, Emitter<ProfileState> emit) {
    emit(state.copyWith(avatar: event.avatar));
  }

  _onUpdateFullName(UpdateFullName event, Emitter<ProfileState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  _onUpdateNickname(UpdateNickname event, Emitter<ProfileState> emit) {
    emit(state.copyWith(nickname: event.nickname));
  }

  _onUpdateEmail(UpdateEmail event, Emitter<ProfileState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _onUpdatePhoneNumber(UpdatePhoneNumber event, Emitter<ProfileState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  _onUpdateBirthday(UpdateBirthday event, Emitter<ProfileState> emit) {
    emit(state.copyWith(birthday: event.birthday));
  }

  _onUpdateCountry(UpdateCountry event, Emitter<ProfileState> emit) {
    emit(state.copyWith(country: event.country));
  }

  _onUpdateProfile(event, emit) {
    emit(state.copyWith(
      fullName: event.fullName,
      nickname: event.nickname,
      email: event.email,
      phoneNumber: event.phoneNumber,
      birthday: event.birthday,
      country: event.country,
    ));
  }
}
