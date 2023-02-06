import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/services/validate.dart';
import 'package:hear_me/widgets/text_input.dart';
import 'package:pinput/pinput.dart';

import '../constants/constants.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/app_styles.dart';
import 'package:hear_me/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:hear_me/blocs/profile_bloc/profile_bloc.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/header.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static const id = 'forgot_password_page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? phoneNumber;

  final _emailController = TextEditingController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<ForgotPasswordBloc>().add(const MoveToFirstPage());
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: size.height * 0.09),
              SvgPicture.asset('assets/images/forgot_password_1.svg',
                  width: size.width * 0.7),
              Form(
                key: _formKey,
                child: SizedBox(
                  height: size.height * 0.47,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) async {
                      context
                          .read<ForgotPasswordBloc>()
                          .add(UpdateCurrentPageIndex(newIndex: index));
                    },
                    children: [
                      // Page 1: Enter email
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: size.height * 0.06,
                                child: Text(
                                    "Enter your email address to reset your password",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.textColor,
                                      fontSize: 16,
                                    )),
                              ),
                              SizedBox(height: size.height * 0.02),
                              const SizedBox(height: 50),
                              TextInput(
                                  size: size,
                                  hint: "Enter your email",
                                  isVisible: true,
                                  controller: _emailController,
                                  validate: (value) {
                                    return emailValidate(value);
                                  }),
                            ],
                          );
                        },
                      ),
                      // Page 2: Select send OTP method
                      if (_emailController.text.isNotEmpty)
                        FutureBuilder<void>(
                            future: getUserFromFirebase(_emailController.text),
                            builder: (context, snapshot) {
                              return BlocBuilder<ForgotPasswordBloc,
                                      ForgotPasswordState>(
                                  builder: (context, state) {
                                if (phoneNumber != null) {
                                  return SingleChildScrollView(
                                      child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: size.height * 0.06,
                                      child: Text(
                                          "Select with contact detail should we use to reset password",
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textColor,
                                            fontSize: 16,
                                          )),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    forgotMethod(
                                        size: size,
                                        onTap: () {
                                          //use BloC
                                          context
                                              .read<ForgotPasswordBloc>()
                                              .add(const SetMethod(
                                                  method: ForgotPasswordMethod
                                                      .messageMethod));
                                        },
                                        title: 'via SMS',
                                        content:
                                            obscurePhoneNumber(phoneNumber!),
                                        hasBorder: state.method ==
                                            ForgotPasswordMethod.messageMethod),
                                    forgotMethod(
                                        size: size,
                                        onTap: () {
                                          context
                                              .read<ForgotPasswordBloc>()
                                              .add(const SetMethod(
                                                  method: ForgotPasswordMethod
                                                      .emailMethod));
                                        },
                                        title: 'via Email',
                                        content:
                                            obscureEmail(_emailController.text),
                                        hasBorder: state.method ==
                                            ForgotPasswordMethod.emailMethod),
                                  ]));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                            }),
                      // Page 3: Enter OTP
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: size.height * 0.06,
                            child: Text(
                                "Enter the verification code we have sent to your phone.",
                                style: GoogleFonts.poppins(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                )),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Pinput(
                            length: 6,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: ColorButton(
                        size: Size(size.width - 40, size.height),
                        backgroundColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        label: 'Continue',
                        onPressed: () async {
                          print(state.currentPageIndex);
                          if (state.currentPageIndex == 0 &&
                              _formKey.currentState!.validate()) {
                            bool existing = await _checkIfEmailExists(
                                _emailController.text);

                            if (existing) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email not found'),
                                ),
                              );
                            }
                          } else if (state.currentPageIndex == 1 &&
                              state.method ==
                                  ForgotPasswordMethod.emailMethod) {
                            await _sendResetEmail(_emailController.text);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: const Text("Email sent"),
                                        content: const Text(
                                            "We have sent you a reset email, please check it!"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ]));
                          } else if (state.currentPageIndex == 1 &&
                              state.method ==
                                  ForgotPasswordMethod.messageMethod) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                            await _sendOTP(phoneNumber!);
                          }
                        }),
                  );
                },
              ),
            ]),
          ),
          Header(
              size: Size(size.width, size.height * 0.07),
              title: "Forgot Password",
              onTap: () {
                Navigator.pop(context);
              }),
        ]),
      )),
    );
  }

  Future _sendOTP(String phoneNumber) async {
    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      // timeout: const Duration(seconds: 60),
    );
  }

  Future _sendResetEmail(String email) async {
    try {
      print(email);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  _checkIfEmailExists(String docID) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('Users').doc(docID).get();
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getUserFromFirebase(String id) async {
    final docUsers = FirebaseFirestore.instance.collection('Users').doc(id);
    final snapshot = await docUsers.get();
    if (snapshot.exists) {
      // get phone number from FB by the email we have know
      phoneNumber = snapshot.data()!['phone'] ?? 'null';
    }
  }

  forgotMethod({
    required Size size,
    required Function onTap,
    required title,
    required content,
    required hasBorder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: hasBorder ? AppColors.primaryColor : Colors.grey[300]!,
                  width: 2),
            ),
            child: Row(children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBFAF1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset('assets/icons/message.png',
                      color: AppColors.primaryColor, height: 25)),
              SizedBox(width: size.width * 0.04),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppStyles.hintText),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        content,
                        style: AppStyles.inputText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
              )
            ])),
      ),
    );
  }

  obscureEmail(String email) {
    // String replaceItems = '';
    // for (int i = 0; i < email.indexOf('@') - 4; i++) {
    //   replaceItems += '*';
    // }
    return email.replaceRange(3, email.indexOf('@') - 3, "*****");
  }

  obscurePhoneNumber(String phoneNumber) {
    return phoneNumber.replaceRange(3, phoneNumber.length - 3, "*****");
  }
}
