import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_assets.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/models/explore_item.dart';
import 'package:hear_me/pages/search_page.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/section_header.dart';
import 'package:hear_me/widgets/text_input.dart';

class ExplorePage extends StatelessWidget {
  static const String id = 'explore_page';
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Header(
            size: Size(size.width, size.height * 0.07),
            icon: Image.asset(AppAssets.musicNoteIcon,
                height: Dimensions.height30,
                width: Dimensions.width30,
                fit: BoxFit.contain,
                isAntiAlias: true),
            onTap: () {},
            title: 'Explore',
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: Dimensions.mediumHorizontalMargin - 5),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(AppAssets.moreIcon,
                        height: Dimensions.iconSize25)),
              )
            ]),
        SizedBox(height: Dimensions.height20),
        Focus(
          onFocusChange: (value) {
            if (value) {
              Navigator.pushNamed(context, SearchPage.id);
              value = false;
            }
          },
          child: TextInput(
              size: size,
              prefixIconAsset: AppAssets.magnifierIcon,
              hint: 'Artists, Songs, Podcasts, & More...',
              isVisible: true,
              controller: searchController),
        ),
        const SectionHeader(
          title: 'Browse All',
        ),
        SizedBox(height: Dimensions.mediumHorizontalMargin),
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.mediumHorizontalMargin),
              child: GridView.builder(
                  itemCount: ExploreItem.itemsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.583333333,
                  ),
                  itemBuilder: (_, index) {
                    return recommendItem(index);
                  })),
        )
      ],
    )));
  }

  ClipRRect recommendItem(int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: ExploreItem.itemsList[index].color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: Dimensions.mediumVerticalMargin,
              left: Dimensions.mediumHorizontalMargin),
          child: Text(ExploreItem.itemsList[index].name,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: Dimensions.fontSize15,
                  fontWeight: FontWeight.w600)),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(ExploreItem.itemsList[index].imageUrl,
                  height: Dimensions.height75,
                  width: Dimensions.height75,
                  fit: BoxFit.cover),
            ),
          ),
        )
      ]),
    );
  }
}
