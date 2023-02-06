part of 'sound_bloc.dart';

abstract class SoundEvent extends Equatable {
  const SoundEvent();

  @override
  List<Object?> get props => [];
}

class InitSoundState extends SoundEvent {
  const InitSoundState();
}

class UpdateSoundState extends SoundEvent {
  final bool? isPlaying;
  final String? playingSongId;
  final Duration? duration;
  final Duration? position;

  const UpdateSoundState({
    this.isPlaying,
    this.playingSongId,
    this.duration,
    this.position,
  });

  @override
  List<Object?> get props => [isPlaying, playingSongId, duration, position];
}
