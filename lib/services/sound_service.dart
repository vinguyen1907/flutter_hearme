import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hear_me/blocs/bloc_exports.dart';

class SoundService {
  static final AudioPlayer player = AudioPlayer();

  Future<void> setAudio(BuildContext context, String soundUrl) async {
    // if (soundUrl.isEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (context) =>
    //           const AlertDialog(title: Text('No sound to play')));
    //   return;
    // }

    await player.setSource(UrlSource(soundUrl));

    // await player.resume();

    //repeat song when completed
    player.setReleaseMode(ReleaseMode.loop);

    player.onPlayerStateChanged.listen((state) {
      BlocProvider.of<SoundBloc>(context).add(UpdateSoundState(
        isPlaying: (state == PlayerState.playing),
      ));
    });

    player.onDurationChanged.listen((newDuration) {
      BlocProvider.of<SoundBloc>(context).add(UpdateSoundState(
        duration: newDuration,
      ));
    });

    player.onPositionChanged.listen((newPosition) {
      BlocProvider.of<SoundBloc>(context)
          .add(UpdateSoundState(position: newPosition));
    });
  }

  void pause() async {
    await player.pause();
    print('pause');
  }

  void resume() async {
    await player.resume();
    print('resume');
  }

  void seekToPosition(BuildContext context) async {
    final position = BlocProvider.of<SoundBloc>(context).state.position;
    await player.seek(position);
  }

  void seek10SecondsForward(BuildContext context) async {
    final position = BlocProvider.of<SoundBloc>(context).state.position;
    await player.seek(position + const Duration(seconds: 10));
  }

  void seek10SecondsBackward(BuildContext context) async {
    final position = BlocProvider.of<SoundBloc>(context).state.position;
    await player.seek(position - const Duration(seconds: 10));
  }

  void dispose() {
    player.dispose();
  }
}
