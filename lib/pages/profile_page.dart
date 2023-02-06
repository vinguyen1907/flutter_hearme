import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_assets.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/widgets/header.dart';

class ProfilePage extends StatelessWidget {
  static const String id = 'explore_page';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final ScrollController controller = ScrollController();

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Header(
          size: Size(size.width, size.height * 0.07),
          icon: Image.asset(AppAssets.musicNoteIcon,
              height: Dimensions.height30,
              width: Dimensions.width30,
              fit: BoxFit.contain,
              isAntiAlias: true),
          onTap: () {},
          title: 'Profile',
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: Dimensions.mediumHorizontalMargin - 5),
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppAssets.moreIcon,
                      height: Dimensions.iconSize25)),
            )
          ]),
      Expanded(
        child: Scrollbar(
          thickness: 3,
          trackVisibility: true,
          // controller: controller,
          radius: const Radius.circular(20),

          // scrollbarOrientation: ScrollbarOrientation.left,
          child: SingleChildScrollView(
              primary: false,
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(width: Dimensions.mediumHorizontalMargin),
                    const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage(AppAssets.emptyProfileImage)),
                    SizedBox(width: Dimensions.width16),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe',
                              style: GoogleFonts.poppins(
                                fontSize: Dimensions.fontSize18,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: Dimensions.height6),
                          Text(FirebaseAuth.instance.currentUser!.email!,
                              style: GoogleFonts.poppins(
                                fontSize: Dimensions.fontSize12,
                                fontWeight: FontWeight.w600,
                              )),
                        ])
                  ]),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.mediumHorizontalMargin,
                        left: Dimensions.mediumHorizontalMargin,
                        right: Dimensions.mediumHorizontalMargin),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(children: [
                        Container(
                          width: size.width -
                              2 * Dimensions.mediumHorizontalMargin,
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                            colors: [Color(0xFF4DEB85), AppColors.primaryColor],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.0, 1.0],
                          )),
                          padding: EdgeInsets.only(
                              top: Dimensions.mediumHorizontalMargin,
                              left: Dimensions.mediumHorizontalMargin,
                              bottom: Dimensions.defaultHorizontalMargin),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Enjoy All Benefits!',
                                    style: GoogleFonts.poppins(
                                      fontSize: Dimensions.fontSize24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: Dimensions.height10),
                                SizedBox(
                                  width: size.width * 0.53,
                                  child: Text(
                                    'Enjoy listening songs & podcasts with better audio quality without restrictions and without ads.',
                                    style: GoogleFonts.poppins(
                                      fontSize: Dimensions.fontSize12,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(height: Dimensions.height6),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: AppColors.primaryColor,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal:
                                            Dimensions.mediumHorizontalMargin),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Get Premium',
                                    style: GoogleFonts.poppins(
                                        fontSize: Dimensions.fontSize14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ]),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.asset('assets/images/onboarding_1.png',
                                width: size.width * 0.38, fit: BoxFit.contain))
                      ]),
                    ),
                  ),
                  Column(
                    children: [
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.profileIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Profile',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.notificationIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Notifications',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.audioIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Audio & Video',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.playIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Playback',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.checkIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Data Saver & Storage',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.securityIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Security',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.languageIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Language',
                          actions: [
                            Icon(Icons.chevron_right_rounded,
                                size: Dimensions.iconSize30),
                            Container(width: Dimensions.mediumHorizontalMargin),
                          ]),
                      _item(
                          size: Size(size.width, size.height * 0.065),
                          onTap: () {},
                          icon: Image.asset(AppAssets.outlinedVisibleIcon,
                              height: Dimensions.height24,
                              width: Dimensions.width24,
                              fit: BoxFit.contain),
                          title: 'Dark Mode',
                          actions: [
                            BlocBuilder<ThemeBloc, ThemeState>(
                              builder: (context, state) {
                                return Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                      value: state is DarkTheme ? true : false,
                                      onChanged: (value) {
                                        BlocProvider.of<ThemeBloc>(context)
                                            .add(const ChangeTheme());
                                      }),
                                );
                              },
                            ),
                            Container(
                                width: Dimensions.defaultHorizontalMargin),
                          ]),
                    ],
                  )
                ],
              )),
        ),
      )
    ])));
  }

  Widget _item({
    required Size size,
    required Widget icon,
    String? title,
    required Function onTap,
    required List<Widget> actions,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              child: icon,
            ),
            if (title != null)
              Text(title,
                  style: GoogleFonts.poppins(
                    color: AppColors.textColor,
                    fontSize: Dimensions.fontSize16,
                    fontWeight: FontWeight.w500,
                  )),
            const Spacer(),
            ...actions,
          ],
        ),
      ),
    );
  }
}
