import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/section_header.dart';
import 'package:hear_me/widgets/song_card.dart';

class ArtistInformationPage extends StatelessWidget {
  static const id = 'artist_information_page';

  final String artistId;

  const ArtistInformationPage({Key? key, required this.artistId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final item =
        Artist.artistsList.where((artist) => artist.id == artistId).first;

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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              child: Image.network(item.imageUrl,
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                  fit: BoxFit.cover)),
        ),
        const SizedBox(height: 20),
        Text(item.name,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5)),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.mediumHorizontalMargin),
          child: Row(
            children: [
              ColorButton(
                  size: const Size(100, 35 / 0.06),
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  label: 'Follow',
                  onPressed: () {}),
              const SizedBox(width: 10),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/more-vertical.png',
                      height: 17, width: 17, fit: BoxFit.contain)),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  iconSize: 20,
                  icon: Image.asset('assets/icons/play-color-button.png',
                      color: AppColors.primaryColor)),
            ],
          ),
        ),
        Container(
            height: 1,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.mediumHorizontalMargin,
                vertical: Dimensions.defaultVerticalMargin + 5),
            color: Colors.grey[300]),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: SectionHeader(
            title: 'Songs',
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: Song.songsList
                  .where((song) => song.artistId == item.id)
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.mediumHorizontalMargin,
                      right: Dimensions.mediumHorizontalMargin,
                      bottom: Dimensions.defaultVerticalMargin),
                  child: SongCard(
                      item: Song.songsList
                          .where((song) => song.artistId == item.id)
                          .toList()[index]),
                );
              }),
        )
      ]),
    ));
  }
}
