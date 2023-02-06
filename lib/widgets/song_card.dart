import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/pages/playing_page.dart';
import 'package:hear_me/services/sound_service.dart';

class SongCard extends StatefulWidget {
  final Song item;

  const SongCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  bool firstTimePlay = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PlayingPage.id, arguments: widget.item.id);
      },
      child: Row(children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              widget.item.imageUrl,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  "assets/images/music.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  color: AppColors.primaryColor,
                );
              },
            )),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.item.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 5),
            Text(
                Artist.artistsList
                    .where((element) => element.id == widget.item.artistId)
                    .first
                    .name,
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w400))
          ]),
        ),
        // const Spacer(),
        BlocBuilder<SoundBloc, SoundState>(
          builder: (context, state) {
            return IconButton(
                splashRadius: 30,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  final playingSongId = state.playingSongId;

                  if (playingSongId != null &&
                      playingSongId != widget.item.id) {
                    BlocProvider.of<SoundBloc>(context)
                        .add(const InitSoundState());
                  }

                  BlocProvider.of<SoundBloc>(context)
                      .add(UpdateSoundState(playingSongId: widget.item.id));

                  if (firstTimePlay) {
                    SoundService().setAudio(
                        context,
                        Song.songsList
                            .where((song) => song.id == widget.item.id)
                            .first
                            .soundUrl);
                    SoundService().resume();
                    firstTimePlay = false;
                    BlocProvider.of<SoundBloc>(context)
                        .add(const UpdateSoundState(
                      isPlaying: true,
                    ));
                  } else {
                    BlocProvider.of<SoundBloc>(context).add(UpdateSoundState(
                      isPlaying: !state.isPlaying,
                    ));
                    if (state.isPlaying) {
                      SoundService().pause();
                    } else {
                      SoundService().resume();
                    }
                  }
                },
                icon: Image.asset(
                  state.isPlaying && state.playingSongId == widget.item.id
                      ? 'assets/icons/pause-color-button.png'
                      : 'assets/icons/play-color-button.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  color: AppColors.primaryColor,
                ));
          },
        ),
        IconButton(
            splashRadius: 30,
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            icon: Image.asset('assets/icons/more-vertical.png',
                height: 17, width: 17, fit: BoxFit.contain)),
      ]),
    );
  }
}
