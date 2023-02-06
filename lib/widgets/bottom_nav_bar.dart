import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/pages/playing_page.dart';
import 'package:hear_me/services/sound_service.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MiniPlayer(size: size),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
              builder: (context, state) {
                return BottomNavigationBar(
                    // backgroundColor: Colors.blue,
                    elevation: 0,
                    selectedItemColor: AppColors.primaryColor,
                    unselectedItemColor: Colors.grey[500],
                    selectedLabelStyle: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    showUnselectedLabels: true,
                    currentIndex: state.currentIndex,
                    onTap: (newIndex) {
                      context
                          .read<BottomNavBarBloc>()
                          .add(UpdateCurrentIndex(newIndex: newIndex));
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/icons/home.png',
                              height: 20, color: Colors.grey[500]),
                          activeIcon: Image.asset('assets/icons/home-fill.png',
                              height: 20, color: AppColors.primaryColor),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/icons/explore.png',
                              height: 22, color: Colors.grey[500]),
                          activeIcon: Image.asset(
                              'assets/icons/explore-fill.png',
                              height: 22,
                              color: AppColors.primaryColor),
                          label: 'Explore'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/icons/library.png',
                              height: 20, color: Colors.grey[500]),
                          activeIcon: Image.asset('assets/icons/library.png',
                              height: 20, color: AppColors.primaryColor),
                          label: 'Library'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/icons/profile.png',
                              height: 20, color: Colors.grey[500]),
                          activeIcon: Image.asset(
                              'assets/icons/profile-fill.png',
                              height: 20,
                              color: AppColors.primaryColor),
                          label: 'Profile')
                    ]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundState>(
      builder: (context, state) {
        if (state.playingSongId != null) {
          final playingSong = Song.songsList
              .where((song) => song.id == state.playingSongId)
              .first;

          return InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PlayingPage.id, arguments: state.playingSongId);
            },
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.network(playingSong.imageUrl,
                            height: 40, width: 40, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playingSong.name,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            Artist.artistsList
                                .where((artist) =>
                                    artist.id == playingSong.artistId)
                                .toList()[0]
                                .name,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<SoundBloc>(context)
                                .add(UpdateSoundState(
                              isPlaying: !state.isPlaying,
                            ));

                            if (state.isPlaying) {
                              SoundService().pause();
                            } else {
                              SoundService().resume();
                            }
                          },
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/next-button.png',
                            height: 16,
                          )),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primaryColor,
                      inactiveTrackColor:
                          AppColors.primaryColor.withOpacity(0.4),
                      trackHeight: 2,
                      valueIndicatorColor: Colors.transparent,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 0,
                      ),
                      trackShape: const RectangularSliderTrackShape(),
                      // remove default padding of slider
                      overlayShape: SliderComponentShape.noThumb),
                  child: Slider(
                      value: state.position.inSeconds.toDouble(),
                      min: 0,
                      max: state.duration.inSeconds.toDouble(),
                      onChanged: (value) {}),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
