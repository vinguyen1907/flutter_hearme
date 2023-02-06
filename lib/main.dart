import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_themes.dart';
import 'package:hear_me/pages/home_page.dart';
import 'package:hear_me/repositories/auth_repository.dart';
import 'package:hear_me/services/page_router.dart';
import 'package:hear_me/pages/onboarding_page.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack); // hide status bar on Android devices

  //use this code bloc to test app with multi devices
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ForgotPasswordBloc()),
          BlocProvider(create: (context) => OnboardingBloc()),
          BlocProvider(create: (context) => SignInBloc()),
          BlocProvider(create: (context) => ProfileBloc()),
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider(create: (context) => BottomNavBarBloc()),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => SoundBloc()),
          BlocProvider(create: (context) => SearchBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              // useInheritedMediaQuery: true,
              // locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: state is LightTheme ? ThemeMode.light : ThemeMode.dark,
              home: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // has been signed in
                      return const HomePage();
                      // const HomePage();
                    }
                    // Otherwise, they're not signed in. Show the sign in page.
                    return const OnboardingPage();
                  }),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
