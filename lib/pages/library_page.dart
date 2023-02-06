import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/section_header.dart';

class LibraryPage extends StatelessWidget {
  static const String id = 'explore_page';
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Header(
            size: Size(size.width, size.height * 0.07),
            icon: Image.asset('assets/icons/music-note.png',
                height: 30, width: 30, fit: BoxFit.contain, isAntiAlias: true),
            onTap: () {},
            title: 'Explore',
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/magnifying-glass.png',
                      height: 35)),
              Padding(
                padding: EdgeInsets.only(
                    right: Dimensions.mediumHorizontalMargin - 5),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/icons/more.png', height: 25)),
              )
            ]),
        // const SizedBox(height: 20),
        SectionHeader(
          title: 'Your History',
          actions: [
            TextButton(
                onPressed: () {
                  // navigate to all history page
                },
                child: Text('See All',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600)))
          ],
        ),
        Container(
            width: size.width - Dimensions.mediumHorizontalMargin * 3,
            height: 1,
            color: Colors.grey[300]),
        SingleChildScrollView(
            child: Column(children: [
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/playlist.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Playlists',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/download.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Downloads',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/podcast.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Podcasts',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/play.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Albums',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/music-note-black.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Songs',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
          Header(
              size: Size(size.width, size.height * 0.07),
              icon: Image.asset('assets/icons/artists.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  isAntiAlias: true),
              onTap: () {},
              title: 'Artists',
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.mediumHorizontalMargin - 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                )
              ]),
        ]))
      ])),
    );
  }
}
