import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_assets.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/services/sound_service.dart';
import 'package:hear_me/widgets/header.dart';

class PlayingPage extends StatefulWidget {
  static const id = 'playing_page';

  final String songId;

  const PlayingPage({Key? key, required this.songId}) : super(key: key);

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  @override
  void initState() {
    super.initState();

    final playingSongId =
        BlocProvider.of<SoundBloc>(context).state.playingSongId;

    if (playingSongId != null && playingSongId != widget.songId) {
      BlocProvider.of<SoundBloc>(context).add(const InitSoundState());
    }

    BlocProvider.of<SoundBloc>(context)
        .add(UpdateSoundState(playingSongId: widget.songId));

    SoundService().setAudio(
        context,
        Song.songsList
            .where((song) => song.id == widget.songId)
            .first
            .soundUrl);
    SoundService().resume();
  }

  @override
  void dispose() {
    super.dispose();
    // don't dispose, scale small to the bottom
    // SoundService.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final playingSong =
        Song.songsList.where((song) => song.id == widget.songId).first;

    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Header(
          size: Size(size.width, size.height * 0.07),
          onTap: () {
            Navigator.pop(context);
          },
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: Dimensions.mediumHorizontalMargin - 5),
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/more.png', height: 25)),
            )
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.network(playingSong.imageUrl,
                  width: size.width - Dimensions.mediumHorizontalMargin * 2,
                  height: size.width - Dimensions.mediumHorizontalMargin * 2,
                  fit: BoxFit.cover)),
        ),
        SizedBox(height: Dimensions.height20),
        Text(playingSong.name,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Dimensions.fontSize28,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5)),
        Text(
            Artist.artistsList
                .where((artist) => artist.id == playingSong.artistId)
                .toList()[0]
                .name,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Dimensions.fontSize16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5)),
        Container(
            height: Dimensions.dividerHeight,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.mediumHorizontalMargin,
                vertical: Dimensions.defaultVerticalMargin),
            color: Colors.grey[200]),
        BlocBuilder<SoundBloc, SoundState>(
          builder: (context, state) {
            return Slider(
              value: state.position.inSeconds.toDouble(),
              min: 0,
              max: state.duration.inSeconds.toDouble(),
              onChanged: (value) async {
                Duration position = Duration(seconds: value.toInt());

                if (value == state.duration.inSeconds || value < 0) {
                  position = const Duration(seconds: 0);
                }

                context
                    .read<SoundBloc>()
                    .add(UpdateSoundState(position: position));

                SoundService().seekToPosition(context);
              },
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryColor.withOpacity(0.5),
            );
          },
        ),
        BlocBuilder<SoundBloc, SoundState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatTime(state.position)),
                    Text(_formatTime(state.duration))
                  ]),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                iconSize: Dimensions.iconSize20,
                icon: Image.asset('assets/icons/back-button.png',
                    height: Dimensions.height25)),
            BlocBuilder<SoundBloc, SoundState>(
              builder: (context, state) {
                return IconButton(
                    iconSize: Dimensions.iconSize30,
                    onPressed: () {
                      SoundService().seek10SecondsBackward(context);
                      context.read<SoundBloc>().add(UpdateSoundState(
                          position:
                              state.position - const Duration(seconds: 10)));
                    },
                    icon: Image.asset('assets/icons/fast-backward.png',
                        height: Dimensions.height25));
              },
            ),
            BlocBuilder<SoundBloc, SoundState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () async {
                      context
                          .read<SoundBloc>()
                          .add(UpdateSoundState(isPlaying: !state.isPlaying));
                      if (state.isPlaying) {
                        SoundService().pause();
                      } else {
                        SoundService().resume();
                      }
                    },
                    iconSize: 60,
                    icon: Image.asset(
                        state.isPlaying
                            ? 'assets/icons/pause-color-button.png'
                            : 'assets/icons/play-color-button.png',
                        color: AppColors.primaryColor));
              },
            ),
            BlocBuilder<SoundBloc, SoundState>(
              builder: (context, state) {
                return IconButton(
                    iconSize: Dimensions.iconSize30,
                    onPressed: () {
                      SoundService().seek10SecondsForward(context);
                      context.read<SoundBloc>().add(UpdateSoundState(
                          position:
                              state.position + const Duration(seconds: 10)));
                    },
                    icon: Image.asset('assets/icons/fast-forward.png',
                        height: Dimensions.height25));
              },
            ),
            IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Image.asset('assets/icons/next-button.png', height: 25)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(AppAssets.speedClockIcon,
                    height: Dimensions.height25,
                    width: Dimensions.width25,
                    fit: BoxFit.contain)),
            IconButton(
                onPressed: () {},
                icon: Image.asset(AppAssets.stopwatchIcon,
                    height: Dimensions.height25,
                    width: Dimensions.width25,
                    fit: BoxFit.contain)),
            IconButton(
                onPressed: () {},
                icon: Image.asset(AppAssets.castingIcon,
                    height: Dimensions.height25,
                    width: Dimensions.width25,
                    fit: BoxFit.contain)),
            IconButton(
                onPressed: () {},
                icon: Image.asset(AppAssets.verticalMoreIcon,
                    height: Dimensions.height20,
                    width: Dimensions.width20,
                    fit: BoxFit.contain)),
          ],
        )
      ]),
    ));
  }

  String _formatTime(Duration duration) {
    final hours = (duration.inHours);
    final minutes = (duration.inMinutes.remainder(60));
    final seconds = (duration.inSeconds.remainder(60));

    return [if (hours > 0) hours, minutes, seconds].map((item) {
      return item.toString().padLeft(2, '0');
    }).join(':');
  }
}
