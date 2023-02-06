import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/auth_bloc/auth_bloc.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/services/auth_service.dart';
import 'package:hear_me/services/validate.dart';
import 'package:hear_me/pages/fill_profile_page.dart';
import 'package:hear_me/pages/forgot_password_page.dart';
import 'package:hear_me/pages/sign_up_page.dart';
import 'package:hear_me/pages/test_show_profile.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/divider.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/text_input.dart';
import 'package:hear_me/widgets/two_elements_text.dart';

class SignInPasswordPage extends StatefulWidget {
  const SignInPasswordPage({Key? key}) : super(key: key);

  static const id = 'sign_in_with_password_page';

  @override
  State<SignInPasswordPage> createState() => _SignInPasswordPageState();
}

class _SignInPasswordPageState extends State<SignInPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    context.read<SignInBloc>().add(const InitialSignInState());
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Sign in success')));

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ShowProfile()));

            // final bool isExisted =
            //     await _hasProfileInFirestore(_emailController.text);
            // if (isExisted) {
            //   // navigate to home page/follow artist page
            //   //this is test
            //   if (!mounted) return;
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const ShowProfile()));
            // } else {
            //   Navigator.of(context).pushNamed(FillProfilePage.id);
            // }
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300]!.withOpacity(0.2),
                ),
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // BlocProvider.of<AuthBloc>(context).add(SignOut());
            return SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Header(
                              size: Size(size.width, size.height * 0.07),
                              onTap: () => Navigator.pop(context)),
                          SizedBox(height: size.height * 0.03),
                          Image.asset(
                            'assets/images/music.png',
                            height: size.height * 0.17,
                            width: size.height * 0.17,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text("Login to Your Account",
                              style: GoogleFonts.poppins(
                                color: AppColors.textColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: size.height * 0.02),
                          TextInput(
                              size: size,
                              hint: "Email",
                              prefixIconAsset: 'assets/icons/email.png',
                              isVisible: true,
                              validate: (value) => emailValidate(value),
                              controller: _emailController),
                          SizedBox(height: size.height * 0.01),
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              return TextInput(
                                  size: size,
                                  hint: "Password",
                                  prefixIconAsset: 'assets/icons/lock.png',
                                  suffixIconAsset: state.isPasswordVisible
                                      ? 'assets/icons/visible.png'
                                      : 'assets/icons/invisible.png',
                                  isVisible: state.isPasswordVisible,
                                  onSuffixTap: () {
                                    context.read<SignInBloc>().add(
                                        const ChangePasswordVisibleState());
                                  },
                                  validate: (value) => passwordValidate(value),
                                  controller: _passwordController);
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              BlocBuilder<SignInBloc, SignInState>(
                                builder: (context, state) {
                                  return Checkbox(
                                    value: state.isRememberPassword,
                                    onChanged: (bool? newValue) {
                                      context.read<SignInBloc>().add(
                                          const ChangeRememberPasswordState());
                                    },
                                    activeColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    side: const BorderSide(
                                        width: 2.5,
                                        color: AppColors.primaryColor),
                                  );
                                },
                              ),
                              Text("Remember me",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          ColorButton(
                              size: size,
                              backgroundColor: AppColors.primaryColor,
                              textColor: Colors.white,
                              label: state is Loading ? "" : "Sign in",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  _authenticateWithEmailAndPassword(context);
                                }
                              }),
                          SizedBox(height: size.height * 0.03),
                          TwoElementsText(
                              buttonText: "Forgot password?",
                              onTap: () {
                                context.read<ProfileBloc>().add(
                                    UpdateEmail(email: _emailController.text));

                                Navigator.of(context).pushNamed(
                                  ForgotPasswordPage.id,
                                );
                              }),
                          SizedBox(height: size.height * 0.03),
                          MyDivider(size: size, label: 'or continue with'),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: () {},
                                child: Image.asset(
                                  'assets/icons/google.png',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: () {},
                                child: Image.asset(
                                  'assets/icons/apple.png',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          TwoElementsText(
                              leftText: "Don't have an account?",
                              buttonText: "Sign up",
                              onTap: () {
                                Navigator.of(context).pushNamed(SignUpPage.id);
                              }),
                          SizedBox(height: size.height * 0.03),
                        ]),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  _authenticateWithEmailAndPassword(context) {
    BlocProvider.of<AuthBloc>(context).add(SignInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text));
  }

  _hasProfileInFirestore(String docID) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('Users').doc(docID).get();
      return (doc.exists);
    } catch (error) {
      rethrow;
    }
  }
}
