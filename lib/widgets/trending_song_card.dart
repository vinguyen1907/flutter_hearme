import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/pages/playing_page.dart';

class TrendingSongCard extends StatelessWidget {
  final String songId;
  final Size size;
  const TrendingSongCard({
    Key? key,
    required this.songId,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Song song = Song.songsList.where((song) => song.id == songId).first;

    return InkWell(
      onTap: () {
        // navigate to song playing page
        Navigator.of(context).pushNamed(PlayingPage.id, arguments: song.id);
      },
      child: Container(
        alignment: Alignment.center,
        height: size.width * 0.4 + 200,
        width: size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: Image.network(
                song.imageUrl,
                height: size.width,
                width: size.width,
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
          const SizedBox(height: 6),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(song.name,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(
                Artist.artistsList
                    .where((artist) => artist.id == song.artistId)
                    .first
                    .name,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ]),
      ),
    );
  }
}
