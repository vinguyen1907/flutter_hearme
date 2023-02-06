import 'package:flutter/material.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/trending_song_card.dart';

class AllTrendingSongsPage extends StatelessWidget {
  static const id = 'all_trending_songs_page';
  const AllTrendingSongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Header(
            size: Size(size.width, size.height * 0.07),
            title: 'Trending Now',
            onTap: () {
              Navigator.pop(context);
            },
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavBarBloc>(context)
                          .add(const UpdateCurrentIndex(newIndex: 1));
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/icons/magnifying-glass.png')),
              ),
            ]),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                // shrinkWrap: true,
                itemCount: Song.songsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  return TrendingSongCard(
                    songId: Song.songsList[index].id,
                    size: Size(size.width * 0.45, size.width * 0.45 + 50),
                  );
                }),
          ),
        )
      ]),
    )));
  }
}
