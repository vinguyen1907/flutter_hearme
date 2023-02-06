import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/pages/artist_information_page.dart';

class PopularArtistCard extends StatelessWidget {
  final String artistId;
  final Size size;
  const PopularArtistCard({
    Key? key,
    required this.artistId,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Artist artist =
        Artist.artistsList.where((artist) => artist.id == artistId).first;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ArtistInformationPage.id,
            arguments: artist);
      },
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.width10),
        child: Column(children: [
          CircleAvatar(
              radius: size.width / 2,
              backgroundImage: NetworkImage(artist.imageUrl)),
          SizedBox(height: Dimensions.height6),
          Text(artist.name,
              style: GoogleFonts.poppins(
                  fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600))
        ]),
      ),
    );
  }
}
