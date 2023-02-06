// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:meta/meta.dart';

import '../../constants/constants.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<SetMethod>(_onSetMethod);
    on<UpdateLoadingMethod>(_onUpdateLoadingMethod);
    on<UpdateCurrentPageIndex>(_onUpdateCurrentPageIndex);
    on<MoveToFirstPage>(_onMoveToFirstPage);
    on<UpdateEmailExistence>(_onUpdateEmailExistence);
  }

  void _onSetMethod(SetMethod event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(method: event.method));
  }

  void _onUpdateLoadingMethod(
      UpdateLoadingMethod event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(isLoadingMethod: !state.isLoadingMethod));
  }

  void _onUpdateCurrentPageIndex(
      UpdateCurrentPageIndex event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(currentPageIndex: event.newIndex));
  }

  void _onMoveToFirstPage(
      MoveToFirstPage event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(currentPageIndex: 0));
  }

  void _onUpdateEmailExistence(
      UpdateEmailExistence event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(isExistedEmail: event.isExistedEmail));
  }
}
