import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/pages/fill_profile_page.dart';
import 'package:hear_me/pages/sign_in_page.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/divider.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/text_input.dart';
import 'package:hear_me/widgets/two_elements_text.dart';

import '../services/validate.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const id = 'sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // form keys
  final formKey = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    context.read<SignInBloc>().add(const InitialSignInState());
    // BlocProvider.of<AuthBloc>(context).add(SignOut());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Sign up success')));

          Navigator.of(context).pushNamed(FillProfilePage.id);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
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
          return SafeArea(
            bottom: false,
            child: SizedBox(
              width: size.width,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
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
                        Text("Create Your Account",
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
                          controller: _emailController,
                        ),
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
                                context
                                    .read<SignInBloc>()
                                    .add(const ChangePasswordVisibleState());
                              },
                              validate: (value) => passwordValidate(value),
                              controller: _passwordController,
                            );
                          },
                        ),
                        BlocBuilder<SignInBloc, SignInState>(
                          builder: (context, state) {
                            return TextInput(
                              size: size,
                              hint: "Repeat Password",
                              prefixIconAsset: 'assets/icons/lock.png',
                              suffixIconAsset: state.isPasswordConfirmVisible
                                  ? 'assets/icons/visible.png'
                                  : 'assets/icons/invisible.png',
                              isVisible: state.isPasswordConfirmVisible,
                              onSuffixTap: () {
                                context.read<SignInBloc>().add(
                                    const ChangePasswordConfirmVisibleState());
                              },
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                } else if (value != _passwordController.text) {
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                              controller: _confirmPasswordController,
                            );
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
                            label: state is Loading ? "" : "Sign up",
                            onPressed: () {
                              // sign up account
                              if (formKey.currentState!.validate()) {
                                _signUp(context);

                                // Navigator.of(context)
                                //     .pushNamed(FillProfilePage.id);
                              }
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
                                height: size.width * 0.05,
                                width: size.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/icons/google.png',
                                height: size.width * 0.05,
                                width: size.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/icons/apple.png',
                                height: size.width * 0.05,
                                width: size.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        TwoElementsText(
                            leftText: "Already have an account",
                            buttonText: "Sign in",
                            onTap: () {
                              Navigator.of(context).pushNamed(SignInPage.id);
                            })
                      ]),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    ));
  }

  _signUp(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(SignUp(
        email: _emailController.text, password: _passwordController.text));
  }
}
