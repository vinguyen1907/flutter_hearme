// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<InitialSignInState>(_onResetSignInState);
    on<ChangePasswordVisibleState>(_onChangePasswordVisibleState);
    on<ChangePasswordConfirmVisibleState>(_onChangePasswordConfirmVisibleState);
    on<ChangeRememberPasswordState>(_onChangeRememberPasswordState);
    on<SignIn>(_onSignIn);
  }

  _onResetSignInState(InitialSignInState event, Emitter<SignInState> emit) {
    emit(const SignInState());
  }

  _onChangePasswordVisibleState(
      ChangePasswordVisibleState event, Emitter<SignInState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _onChangePasswordConfirmVisibleState(
      ChangePasswordConfirmVisibleState event, Emitter<SignInState> emit) {
    emit(state.copyWith(
        isPasswordConfirmVisible: !state.isPasswordConfirmVisible));
  }

  _onChangeRememberPasswordState(
      ChangeRememberPasswordState event, Emitter<SignInState> emit) {
    emit(state.copyWith(isRememberPassword: !state.isRememberPassword));
  }

  _onSignIn(SignIn event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email, password: event.password));
  }
}
