import 'package:flutter/material.dart';
import 'package:hear_me/pages/all_popular_artists_page.dart';
import 'package:hear_me/pages/all_top_charts_page.dart';
import 'package:hear_me/pages/all_trending_songs_page.dart';
import 'package:hear_me/pages/artist_information_page.dart';
import 'package:hear_me/pages/explore_page.dart';
import 'package:hear_me/pages/fill_profile_page.dart';
import 'package:hear_me/pages/follow_artists_page.dart';
import 'package:hear_me/pages/forgot_password_page.dart';
import 'package:hear_me/pages/home_page.dart';
import 'package:hear_me/pages/playing_page.dart';
import 'package:hear_me/pages/search_page.dart';
import 'package:hear_me/pages/sign_in_page.dart';
import 'package:hear_me/pages/sign_in_with_password_page.dart';
import 'package:hear_me/pages/sign_up_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (SignInPage.id):
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case (SignUpPage.id):
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case (SignInPasswordPage.id):
        return MaterialPageRoute(builder: (_) => const SignInPasswordPage());
      case (ForgotPasswordPage.id):
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case (FillProfilePage.id):
        return MaterialPageRoute(builder: (_) => const FillProfilePage());
      case (FollowArtistsPage.id):
        return MaterialPageRoute(builder: (_) => const FollowArtistsPage());
      case (HomePage.id):
        return MaterialPageRoute(builder: (_) => const HomePage());
      case (AllTrendingSongsPage.id):
        return MaterialPageRoute(builder: (_) => const AllTrendingSongsPage());
      case (AllTopChartsPage.id):
        return MaterialPageRoute(builder: (_) => const AllTopChartsPage());
      case (AllPopularArtistsPage.id):
        return MaterialPageRoute(builder: (_) => const AllPopularArtistsPage());
      case (ExplorePage.id):
        return MaterialPageRoute(builder: (_) => const ExplorePage());
      case (SearchPage.id):
        return MaterialPageRoute(builder: (_) => const SearchPage());

      case (PlayingPage.id):
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => PlayingPage(songId: args));
      case (ArtistInformationPage.id):
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ArtistInformationPage(artistId: args));
      default:
        return null;
    }
  }
}



// use: Navigator.of(context).pushNamed(OnboardingPage.id);