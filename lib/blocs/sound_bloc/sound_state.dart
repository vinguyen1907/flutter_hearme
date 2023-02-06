// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sound_bloc.dart';

class SoundState extends Equatable {
  final bool isPlaying;
  final String? playingSongId;
  final Duration duration;
  final Duration position;

  const SoundState({
    this.isPlaying = true,
    this.playingSongId,
    this.duration = const Duration(seconds: 0),
    this.position = const Duration(seconds: 0),
  });

  @override
  List<Object?> get props => [isPlaying, playingSongId, duration, position];

  SoundState copyWith({
    bool? isPlaying,
    String? playingSongId,
    Duration? duration,
    Duration? position,
  }) {
    return SoundState(
      isPlaying: isPlaying ?? this.isPlaying,
      playingSongId: playingSongId ?? this.playingSongId,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }
}
