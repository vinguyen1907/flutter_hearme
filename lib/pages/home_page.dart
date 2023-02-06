import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:hear_me/constants/app_assets.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/models/top_chart.dart';
import 'package:hear_me/models/user.dart';
import 'package:hear_me/pages/all_popular_artists_page.dart';
import 'package:hear_me/pages/all_top_charts_page.dart';
import 'package:hear_me/pages/all_trending_songs_page.dart';
import 'package:hear_me/pages/explore_page.dart';
import 'package:hear_me/pages/library_page.dart';
import 'package:hear_me/pages/profile_page.dart';
import 'package:hear_me/widgets/bottom_nav_bar.dart';
import 'package:hear_me/widgets/popular_artist_card.dart';
import 'package:hear_me/widgets/section_header.dart';
import 'package:hear_me/widgets/top_chart_card.dart';
import 'package:hear_me/widgets/trending_song_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              maintainBottomViewPadding: true,
              child: IndexedStack(index: state.currentIndex, children: [
                Column(
                  children: [
                    // Header
                    _header(),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          SectionHeader(
                            title: 'Trending Now',
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AllTrendingSongsPage.id);
                                  },
                                  child: Text('See All',
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600)))
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: size.width * 0.36 + 50,
                            padding: EdgeInsets.only(
                                left: Dimensions.mediumHorizontalMargin),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: Song.songsList.length,
                                itemBuilder: (context, index) {
                                  if (Song.songsList[index].isTrending) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: TrendingSongCard(
                                        songId: Song.songsList[index].id,
                                        size: Size(size.width * 0.36,
                                            size.width * 0.36 + 50),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                          SectionHeader(
                            title: 'Popular Artists',
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AllPopularArtistsPage.id);
                                  },
                                  child: Text('See All',
                                      style: GoogleFonts.poppins(
                                          fontSize: Dimensions.fontSize15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600)))
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: Dimensions.height180,
                            padding: EdgeInsets.only(
                                left: Dimensions.mediumHorizontalMargin),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: Artist.artistsList.length,
                                itemBuilder: (context, index) {
                                  if (Artist.artistsList[index].isPopular) {
                                    return PopularArtistCard(
                                      artistId: Artist.artistsList[index].id,
                                      size: Size(size.width * 0.36,
                                          size.width * 0.36 + 50),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                          SectionHeader(
                            title: 'Top Charts',
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AllTopChartsPage.id);
                                  },
                                  child: Text('See All',
                                      style: GoogleFonts.poppins(
                                          fontSize: Dimensions.fontSize15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600)))
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: Dimensions.height140,
                            padding: EdgeInsets.only(
                                left: Dimensions.mediumHorizontalMargin),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: TopChart.topChartsList.length,
                                itemBuilder: (context, index) {
                                  // if (TopChart.topChartsList[index].is) {
                                  return TopChartCard(index: index);
                                  // } else {
                                  //   return Container();
                                  // }
                                }),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                const ExplorePage(),
                const LibraryPage(),
                // Container(),
                const ProfilePage(),
              ])),
          bottomNavigationBar: const CustomBottomBar(),
        );
      },
    );
  }

  _header() {
    return Padding(
      padding: EdgeInsets.all(Dimensions.mediumHorizontalMargin),
      child: Row(children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://apsec.iafor.org/wp-content/uploads/sites/37/2017/02/IAFOR-Blank-Avatar-Image.jpg'),
        ),
        SizedBox(width: Dimensions.width10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning 👋', style: GoogleFonts.poppins(fontSize: 14)),
            FutureBuilder<UserProfile?>(
                future: _getUserFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    final user = snapshot.data;
                    return user == null
                        ? const Center(child: Text("No user"))
                        : Text(user.fullName,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600));
                  } else {
                    return Center(
                        child: SizedBox(
                      height: Dimensions.height15,
                      width: Dimensions.width15,
                      child: const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 3,
                      ),
                    ));
                  }
                }),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            BlocProvider.of<BottomNavBarBloc>(context)
                .add(const UpdateCurrentIndex(newIndex: 1));
          },
          icon:
              Image.asset(AppAssets.magnifierIcon, height: Dimensions.height30),
        ),
        IconButton(
            onPressed: () {},
            icon: Image.asset(AppAssets.notificationIcon,
                height: Dimensions.height24)),
      ]),
    );
  }

  Future<UserProfile?> _getUserFromFirestore() async {
    final document = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.email!);
    final snapshot = await document.get();
    if (snapshot.exists) {
      return UserProfile.fromMap(snapshot.data()!);
    } else {
      print("Don't have this user");
    }
  }
}
