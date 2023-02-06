import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/models/song.dart';
import 'package:hear_me/widgets/artist_cart.dart';
import 'package:hear_me/widgets/outline_button.dart';
import 'package:hear_me/widgets/section_header.dart';
import 'package:hear_me/widgets/song_card.dart';
import 'package:hear_me/widgets/text_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const id = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> recentSearches = [
    {'id': 1, 'content': 'Ariana Grande'},
    {'id': 2, 'content': 'Morgan Wallen'},
    {'id': 3, 'content': 'Đen Vâu'},
    {'id': 4, 'content': 'Alan Walker'},
  ];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(UpdateToSearchingState());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                Dimensions.mediumHorizontalMargin,
                Dimensions.defaultVerticalMargin * 2,
                Dimensions.mediumHorizontalMargin,
                0),
            child: Focus(
              onFocusChange: (value) {
                if (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(UpdateToSearchingState());
                } else {
                  BlocProvider.of<SearchBloc>(context).add(
                      const UpdateToSearchedState(filterBy: FilterList.all));
                }
              },
              child: TextInput(
                  size: size,
                  prefixIconAsset: 'assets/icons/magnifying-glass.png',
                  hint: 'Artists, Songs, Podcasts, & More...',
                  isVisible: true,
                  autofocus: true,
                  onSubmitted: () {
                    if (searchController.text.isNotEmpty) {
                      BlocProvider.of<SearchBloc>(context).add(
                          const UpdateToSearchedState(
                              filterBy: FilterList.all));
                    }
                  },
                  controller: searchController),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Expanded(
                child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      state is Searching
                          ? SearchingPage(
                              recentSearches: recentSearches,
                              searchController: searchController)
                          : state is Searched
                              ? ShowResultsPage(
                                  searchController: searchController)
                              : const Center(
                                  child: Text('Something went wrong'))
                    ]),
              );
            },
          ),
        ]),
      )),
    );
  }
}

class ShowResultsPage extends StatefulWidget {
  const ShowResultsPage({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  State<ShowResultsPage> createState() => _ShowResultsPageState();
}

class _ShowResultsPageState extends State<ShowResultsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        width: size.width,
        height: 31,
        margin: EdgeInsets.only(
            top: Dimensions.defaultVerticalMargin * 2,
            left: Dimensions.mediumHorizontalMargin),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: FilterList.values.length,
            itemBuilder: (context, index) {
              String label =
                  FilterList.values[index].toString().split('.').last;
              label = label[0].toUpperCase() + label.substring(1);

              return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: BlocConsumer<SearchBloc, SearchState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is Searched) {
                        return MyOutlinedButton(
                          size: const Size(100, 30),
                          backgroundColor:
                              state.filterBy == FilterList.values[index]
                                  ? AppColors.primaryColor
                                  : Colors.white,
                          textColor: state.filterBy == FilterList.values[index]
                              ? Colors.white
                              : AppColors.primaryColor,
                          label: label,
                          onPressed: () {
                            BlocProvider.of<SearchBloc>(context).add(
                                UpdateToSearchedState(
                                    filterBy: FilterList.values[index]));
                          },
                        );
                      }
                      return const Center(child: Text('State is not Searched'));
                    },
                  ));
            }),
      ),
      BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is Searched && state.filterBy == FilterList.all) {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    searchSongs(widget.searchController.text).isNotEmpty
                        ? const SectionHeader(title: 'Songs')
                        : Container(),
                    searchSongs(widget.searchController.text).isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchSongs(widget.searchController.text)
                                        .length >
                                    5
                                ? 5
                                : searchSongs(widget.searchController.text)
                                    .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: Dimensions.defaultVerticalMargin,
                                    left: Dimensions.mediumHorizontalMargin),
                                child: SongCard(
                                    item: searchSongs(
                                        widget.searchController.text)[index]),
                              );
                            })
                        : Container(),
                    searchArtists(widget.searchController.text).isNotEmpty
                        ? const SectionHeader(title: 'Artists')
                        : Container(),
                    searchArtists(widget.searchController.text).isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchArtists(
                                            widget.searchController.text)
                                        .length >
                                    5
                                ? 5
                                : searchArtists(widget.searchController.text)
                                    .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: Dimensions.defaultVerticalMargin,
                                    left: Dimensions.mediumHorizontalMargin,
                                    right: Dimensions.mediumHorizontalMargin),
                                child: ArtistCard(
                                    size: size,
                                    item: searchArtists(
                                        widget.searchController.text)[index]),
                              );
                            })
                        : Container(),
                  ],
                ),
              ),
            );
          } else if (state is Searched && state.filterBy == FilterList.songs) {
            if (searchSongs(widget.searchController.text).isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                    itemCount: searchSongs(widget.searchController.text).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.defaultVerticalMargin,
                            left: Dimensions.mediumHorizontalMargin),
                        child: SongCard(
                            item: searchSongs(
                                widget.searchController.text)[index]),
                      );
                    }),
              );
            } else {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/not-found.png',
                          width: size.width * 0.8, fit: BoxFit.contain),
                      const SizedBox(height: 30),
                      Text('Not Found',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.mediumHorizontalMargin),
                        child: Text(
                            'Sorry, the keyword you  entered cannot be found, please check again or search with another keyword.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            }
          } else if (state is Searched &&
              state.filterBy == FilterList.artists) {
            if (searchArtists(widget.searchController.text).isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                    itemCount:
                        searchArtists(widget.searchController.text).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.defaultVerticalMargin,
                            left: Dimensions.mediumHorizontalMargin,
                            right: Dimensions.mediumHorizontalMargin),
                        child: ArtistCard(
                            size: size,
                            item: searchArtists(
                                widget.searchController.text)[index]),
                      );
                    }),
              );
            } else {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/not-found.png',
                          width: size.width * 0.8, fit: BoxFit.contain),
                      const SizedBox(height: 30),
                      Text('Not Found',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.mediumHorizontalMargin),
                        child: Text(
                            'Sorry, the keyword you  entered cannot be found, please check again or search with another keyword.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    ]);
  }

  List<Song> searchSongs(String searchKey) {
    searchKey = searchKey.toLowerCase().trim();
    List<Song> suggestions = Song.songsList
        .where((song) => song.name.toLowerCase().contains(searchKey))
        .toList();
    return suggestions;
  }

  List<Artist> searchArtists(String searchKey) {
    searchKey = searchKey.toLowerCase().trim();
    List<Artist> suggestions = Artist.artistsList
        .where((artist) => artist.name.toLowerCase().contains(searchKey))
        .toList();
    return suggestions;
  }
}

class SearchingPage extends StatelessWidget {
  const SearchingPage({
    Key? key,
    required this.recentSearches,
    required this.searchController,
  }) : super(key: key);

  final List<Map<String, dynamic>> recentSearches;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'Recent Searches',
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Clear All',
                style: GoogleFonts.poppins(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ))
        ],
      ),
      Container(
        color: Colors.grey[300],
        height: 1,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.mediumHorizontalMargin,
            vertical: Dimensions.defaultVerticalMargin),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  searchController.text = recentSearches[index]['content'];
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.mediumHorizontalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(recentSearches[index]['content'],
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.grey[500])),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/close-outline.png',
                            height: 12, width: 12, color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
              );
            }),
      )
    ]);
  }
}
