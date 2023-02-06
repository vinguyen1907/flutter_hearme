import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hear_me/models/user.dart';
import 'package:hear_me/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInWithEmailAndPassword>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<GoogleSignIn>(_onGoogleSignIn);
    on<SignOut>(_onSignOut);
  }

  void _onSignIn(event, emit) async {
    emit(Loading());
    try {
      await authRepository.signIn(email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onSignUp(event, emit) async {
    emit(Loading());
    try {
      print("Go to sign up");
      await authRepository.signUp(email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onGoogleSignIn(event, emit) async {
    emit(Loading());
    try {
      await authRepository.signInWithGoogle();
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onSignOut(event, emit) async {
    emit(Loading());
    await authRepository.signOut();
    emit(UnAuthenticated());
  }
}
