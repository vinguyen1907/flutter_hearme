import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/pages/home_page.dart';
import 'package:hear_me/widgets/artist_cart.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/header.dart';

class FollowArtistsPage extends StatelessWidget {
  const FollowArtistsPage({Key? key}) : super(key: key);

  static const id = 'follow_artists_page';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      children: [
        Header(
            size: Size(size.width, size.height * 0.07),
            title: "Follow Artists",
            onTap: () {
              Navigator.pop(context);
            }),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.mediumHorizontalMargin),
          child: Text(
            'Follow your favorite artists. Or you can skip it for now.',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: Artist.artistsList.length,
                    itemBuilder: (context, index) {
                      return ArtistCard(
                          size: size, item: Artist.artistsList[index]);
                    }),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorButton(
                  size: Size(
                      size.width / 2 - Dimensions.mediumHorizontalMargin / 2,
                      size.height),
                  backgroundColor: AppColors.secondaryButtonColor,
                  textColor: AppColors.primaryColor,
                  label: 'Skip',
                  onPressed: () {}),
              const SizedBox(width: 10),
              ColorButton(
                  size: Size(
                      size.width / 2 - Dimensions.mediumHorizontalMargin / 2,
                      size.height),
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.secondaryButtonColor,
                  label: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.id, (Route<dynamic> route) => false);
                  })
            ],
          ),
        )
      ],
    ));
  }
}
