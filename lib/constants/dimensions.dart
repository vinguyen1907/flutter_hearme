import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.height;
  // MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static const exampleScreenHeight = 829.0909090909091;

  // default margin
  static double defaultHorizontalMargin =
      screenHeight / (exampleScreenHeight / 10);
  static double mediumHorizontalMargin =
      screenHeight / (exampleScreenHeight / 20);
  static double defaultVerticalMargin =
      screenHeight / (exampleScreenHeight / 10);
  static double mediumVerticalMargin =
      screenHeight / (exampleScreenHeight / 20);
  static double largeVerticalMargin = screenHeight / (exampleScreenHeight / 40);

  // height
  static double height6 = screenHeight / (exampleScreenHeight / 6);
  static double height7 = screenHeight / (exampleScreenHeight / 7);
  static double height10 = screenHeight / (exampleScreenHeight / 10);
  static double height15 = screenHeight / (exampleScreenHeight / 15);
  static double height20 = screenHeight / (exampleScreenHeight / 20);
  static double height24 = screenHeight / (exampleScreenHeight / 24);
  static double height25 = screenHeight / (exampleScreenHeight / 25);
  static double height30 = screenHeight / (exampleScreenHeight / 30);
  static double height50 = screenHeight / (exampleScreenHeight / 50);
  static double height75 = screenHeight / (exampleScreenHeight / 75);
  static double height140 = screenHeight / (exampleScreenHeight / 140);
  static double height180 = screenHeight / (exampleScreenHeight / 180);

  //width
  static double width5 = screenHeight / (exampleScreenHeight / 5);
  static double width10 = screenHeight / (exampleScreenHeight / 10);
  static double width15 = screenHeight / (exampleScreenHeight / 15);
  static double width16 = screenHeight / (exampleScreenHeight / 16);
  static double width20 = screenHeight / (exampleScreenHeight / 20);
  static double width24 = screenHeight / (exampleScreenHeight / 24);
  static double width25 = screenHeight / (exampleScreenHeight / 25);
  static double width30 = screenHeight / (exampleScreenHeight / 30);
  static double width75 = screenHeight / (exampleScreenHeight / 75);

  // font size
  static double fontSize12 = screenHeight / (exampleScreenHeight / 12);
  static double fontSize14 = screenHeight / (exampleScreenHeight / 14);
  static double fontSize15 = screenHeight / (exampleScreenHeight / 15);
  static double fontSize16 = screenHeight / (exampleScreenHeight / 16);
  static double fontSize18 = screenHeight / (exampleScreenHeight / 18);
  static double fontSize20 = screenHeight / (exampleScreenHeight / 20);
  static double fontSize24 = screenHeight / (exampleScreenHeight / 24);
  static double fontSize26 = screenHeight / (exampleScreenHeight / 26);
  static double fontSize28 = screenHeight / (exampleScreenHeight / 28);

  // icon size
  static final double iconSize20 = screenHeight / (exampleScreenHeight / 20);
  static double iconSize25 = screenHeight / (exampleScreenHeight / 25);
  static double iconSize30 = screenHeight / (exampleScreenHeight / 30);

  // divider height
  static double dividerHeight = 1;
}


// height of example device is exampleScreenHeight