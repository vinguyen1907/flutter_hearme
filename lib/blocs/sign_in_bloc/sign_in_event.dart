part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class InitialSignInState extends SignInEvent {
  const InitialSignInState();
}

class ChangePasswordVisibleState extends SignInEvent {
  const ChangePasswordVisibleState();
}

class ChangePasswordConfirmVisibleState extends SignInEvent {
  const ChangePasswordConfirmVisibleState();
}

class ChangeRememberPasswordState extends SignInEvent {
  const ChangeRememberPasswordState();
}

class SignIn extends SignInEvent {
  final String email;
  final String password;

  const SignIn({this.email = '', this.password = ''});

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogle extends SignInEvent {
  const SignInWithGoogle();
}
