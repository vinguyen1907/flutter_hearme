import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/pages/fill_profile_page.dart';
import 'package:hear_me/pages/sign_in_with_password_page.dart';
import 'package:hear_me/pages/sign_up_page.dart';
import 'package:hear_me/pages/test_show_profile.dart';
import 'package:hear_me/services/auth_service.dart';
import 'package:hear_me/services/check_if_email_exists.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/divider.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/two_elements_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const id = 'sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    // AuthService().signOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Header(
            size: Size(size.width, size.height * 0.07),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: size.height * 0.02),
          Image.asset('assets/images/log_in.png',
              height: size.height / 4, width: size.width, fit: BoxFit.contain),
          SizedBox(height: size.height * 0.02),
          Text("Let's you in",
              style: GoogleFonts.inter(
                  color: AppColors.textColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6)),
          SizedBox(height: size.height * 0.02),
          signInOutlinedButton(
            size: size,
            icon: Image.asset('assets/icons/facebook.png',
                height: size.height * 0.03,
                width: size.height * 0.03,
                fit: BoxFit.contain),
            label: "Continue with Facebook",
          ),
          SizedBox(height: size.height * 0.02),
          StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot snapshot) {
                return signInOutlinedButton(
                    size: size,
                    icon: Image.asset('assets/icons/google.png',
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                        fit: BoxFit.contain),
                    label: "Continue with Google",
                    onPressed: () {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData) {
                        AuthService().signInWithGoogle(context);
                      } else if (snapshot.hasData) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title:
                                      const Text("You are already signed in"),
                                  content: const Text(
                                      "You can't sign in with two different accounts"),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text("Sign Out"),
                                      onPressed: () {
                                        AuthService().signOut();
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                      } else if (snapshot.hasError) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const AlertDialog(title: Text("Error")));
                      } else {
                        return const SignInPage();
                      }
                    });
              }),
          SizedBox(height: size.height * 0.02),
          signInOutlinedButton(
            size: size,
            icon: Image.asset('assets/icons/apple.png',
                height: size.height * 0.03,
                width: size.height * 0.03,
                fit: BoxFit.contain),
            label: "Continue with Apple",
          ),
          SizedBox(height: size.height * 0.05),
          MyDivider(size: size, label: "or"),
          SizedBox(height: size.height * 0.05),
          ColorButton(
              size: size,
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              label: "Sign in with password",
              onPressed: () {
                Navigator.of(context).pushNamed(SignInPasswordPage.id);
              }),
          SizedBox(height: size.height * 0.03),
          TwoElementsText(
              leftText: "Don't have an account?",
              buttonText: "Sign up",
              onTap: () {
                Navigator.of(context).pushNamed(SignUpPage.id);
              }),
        ]),
      ),
    );
  }

  OutlinedButton signInOutlinedButton(
      {required Size size,
      Widget? icon,
      required String label,
      Function? onPressed}) {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(size.width * 0.9, size.height * 0.06),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        icon: icon!,
        label: Text(label,
            style: GoogleFonts.inter(
              color: AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )));
  }
}
