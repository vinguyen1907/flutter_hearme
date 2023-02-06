part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();

  List<Object> get props => [];
}

class SetMethod extends ForgotPasswordEvent {
  final String method;

  const SetMethod({
    required this.method,
  });

  @override
  List<Object> get props => [method];
}

class UpdateLoadingMethod extends ForgotPasswordEvent {
  const UpdateLoadingMethod();
}

class UpdateCurrentPageIndex extends ForgotPasswordEvent {
  final int newIndex;
  const UpdateCurrentPageIndex({
    required this.newIndex,
  });
}

class MoveToFirstPage extends ForgotPasswordEvent {
  const MoveToFirstPage();
}

class UpdateEmailExistence extends ForgotPasswordEvent {
  final bool isExistedEmail;
  const UpdateEmailExistence({
    required this.isExistedEmail,
  });
}
