import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/app_styles.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/constants/dimensions.dart';
import 'package:hear_me/pages/sign_in_page.dart';
import 'package:hear_me/widgets/color_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static const id = 'onboarding_page';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  final StreamController<int> _pageStreamController =
      StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  @override
  void dispose() {
    _pageStreamController.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      color: Colors.grey[200],
      child: SafeArea(
        bottom: false,
        child: Stack(children: [
          // ** This setting to scroll on windows app
          // ScrollConfiguration(
          //     behavior: ScrollConfiguration.of(context).copyWith(
          //       dragDevices: {
          //         PointerDeviceKind.touch,
          //         PointerDeviceKind.mouse,
          //       },
          //     ),
          // child:
          PageView.builder(
            itemCount: onboardingTitleList.length,
            itemBuilder: (context, index) {
              return onboardItem(size, index);
            },
            controller: _pageController,
          ),
          // ),
          Positioned(
              bottom: Dimensions.largeVerticalMargin,
              child: Column(
                children: [
                  Row(children: [
                    ...List.generate(3, (index) => dotIndicator(index)),
                  ]),
                  SizedBox(height: size.height / 15),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: StreamBuilder<int>(
                        stream: _pageStreamController.stream,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return ColorButton(
                              size: size,
                              backgroundColor: AppColors.primaryColor,
                              textColor: Colors.white,
                              label: snapshot.data ==
                                      (onboardingTitleList.length - 1)
                                  ? "Get Started"
                                  : "Next",
                              onPressed: () async {
                                if (snapshot.data !=
                                    onboardingTitleList.length - 1) {
                                  await _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                } else {
                                  Navigator.of(context)
                                      .pushNamed(SignInPage.id);
                                }
                              });
                        }),
                  )
                ],
              ))
        ]),
      ),
    ));
  }

  dotIndicator(int index) {
    return StreamBuilder<int>(
        stream: _pageStreamController.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Container(
            height: Dimensions.height7,
            width: index == snapshot.data
                ? Dimensions.height20
                : Dimensions.height7,
            margin:
                EdgeInsets.only(right: Dimensions.defaultHorizontalMargin / 2),
            decoration: BoxDecoration(
                color: index == snapshot.data
                    ? AppColors.primaryColor
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(100)),
          );
        });
  }

  Column onboardItem(Size size, int index) {
    return Column(children: [
      Image.asset('assets/images/onboarding_${index + 1}.png',
          height: size.height * 1 / 2, width: size.width, fit: BoxFit.cover),
      Expanded(
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  left: Dimensions.mediumHorizontalMargin,
                  right: Dimensions.mediumHorizontalMargin,
                  top: Dimensions.largeVerticalMargin - 5,
                  bottom: Dimensions.mediumVerticalMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumHorizontalMargin),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: onboardingTitleList[index]['title_1'],
                            style: AppStyles.onboardingTitle,
                            children: [
                              TextSpan(
                                text: onboardingTitleList[index]['title_2'],
                                style: AppStyles.onboardingTitle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              TextSpan(
                                  text: onboardingTitleList[index]['title_3'])
                            ],
                          )),
                    )
                  ])))
    ]);
  }
}
