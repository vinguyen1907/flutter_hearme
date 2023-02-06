// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final bool isPasswordVisible;
  final bool isPasswordConfirmVisible;
  final bool isRememberPassword;
  final String email;
  final String password;

  const SignInState(
      {this.isPasswordVisible = false,
      this.isPasswordConfirmVisible = false,
      this.isRememberPassword = false,
      this.email = '',
      this.password = ''});

  SignInState copyWith({
    bool? isPasswordVisible,
    bool? isPasswordConfirmVisible,
    bool? isRememberPassword,
    String? email,
    String? password,
  }) {
    return SignInState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isPasswordConfirmVisible:
          isPasswordConfirmVisible ?? this.isPasswordConfirmVisible,
      isRememberPassword: isRememberPassword ?? this.isRememberPassword,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        isPasswordVisible,
        isPasswordConfirmVisible,
        isRememberPassword,
        email,
        password,
      ];
}
