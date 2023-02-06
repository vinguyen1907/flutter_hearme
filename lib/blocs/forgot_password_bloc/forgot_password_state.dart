// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

@immutable
class ForgotPasswordState extends Equatable {
  final String method;
  final bool isLoadingMethod;
  final int currentPageIndex;
  final bool isExistedEmail;

  const ForgotPasswordState({
    this.isLoadingMethod = false,
    this.method = ForgotPasswordMethod.messageMethod,
    this.currentPageIndex = 0,
    this.isExistedEmail = false,
  });

  @override
  List<Object> get props => [method, isLoadingMethod, currentPageIndex];

  ForgotPasswordState copyWith({
    String? method,
    bool? isLoadingMethod,
    int? currentPageIndex,
    bool? isExistedEmail,
  }) {
    return ForgotPasswordState(
      method: method ?? this.method,
      isLoadingMethod: isLoadingMethod ?? this.isLoadingMethod,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isExistedEmail: isExistedEmail ?? this.isExistedEmail,
    );
  }
}
