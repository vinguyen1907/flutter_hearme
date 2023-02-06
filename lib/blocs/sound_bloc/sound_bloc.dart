import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  SoundBloc() : super(const SoundState()) {
    on<InitSoundState>(_onInitSoundState);
    on<UpdateSoundState>(_onUpdateSoundState);
  }

  _onInitSoundState(event, emit) {
    emit(state.copyWith(
      isPlaying: true,
      playingSongId: null,
      duration: Duration.zero,
      position: Duration.zero,
    ));
  }

  _onUpdateSoundState(event, emit) {
    emit(state.copyWith(
      isPlaying: event.isPlaying,
      playingSongId: event.playingSongId,
      duration: event.duration,
      position: event.position,
    ));
  }
}
