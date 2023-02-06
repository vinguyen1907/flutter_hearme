import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/app_styles.dart';
import 'package:hear_me/constants/phone_country_list.dart';
import 'package:hear_me/pages/follow_artists_page.dart';
import 'package:hear_me/services/validate.dart';
// import 'package:hear_me/pages/follow_artists_page.dart';
import 'package:hear_me/pages/test_show_profile.dart';
import 'package:hear_me/widgets/color_button.dart';
import 'package:hear_me/widgets/header.dart';
import 'package:hear_me/widgets/text_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({Key? key}) : super(key: key);

  static const id = 'fill_profile_page';

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? profileImageUrl;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.9,
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(children: [
                Header(
                    size: Size(size.width, size.height * 0.07),
                    onTap: () => Navigator.pop(context),
                    title: 'Fill Your Profile'),
                Stack(children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: state.avatar != null
                              ? Image.file(state.avatar!,
                                  height: size.height * 0.17,
                                  width: size.height * 0.17,
                                  fit: BoxFit.cover)
                              : Image.asset('assets/images/profile.jpg',
                                  height: size.height * 0.17));
                    },
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return _alertDialog(size, context);
                              });
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.primaryColor),
                            child: const Icon(Icons.create_sharp,
                                color: Colors.white)),
                      ))
                ]),
                SizedBox(height: size.height * 0.03),
                TextInput(
                    size: size,
                    hint: "Full name",
                    isVisible: true,
                    controller: _fullNameController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    }),
                SizedBox(height: size.height * 0.03),
                TextInput(
                    size: size,
                    hint: "Nickname",
                    isVisible: true,
                    controller: _nickNameController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your nickname';
                      }
                      return null;
                    }),
                SizedBox(height: size.height * 0.03),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return InkWell(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: state.birthday ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030));

                          if (!mounted) return;
                          if (selectedDate != null) {
                            context
                                .read<ProfileBloc>()
                                .add(UpdateBirthday(birthday: selectedDate));
                          }
                        },
                        child: Container(
                            width: size.width * 0.9,
                            height: 55,
                            padding: const EdgeInsets.only(left: 12, right: 13),
                            decoration: BoxDecoration(
                              color: const Color(0XFFFAFAFA),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                      return Text(
                                          state.birthday == null
                                              ? "Date of birth"
                                              : DateFormat.yMMMMd()
                                                  .format(state.birthday!)
                                                  .toString(),
                                          style: state.birthday == null
                                              ? AppStyles.hintText
                                                  .copyWith(height: 1)
                                              : AppStyles.inputText);
                                    },
                                  ),
                                  Icon(Icons.calendar_month_rounded,
                                      color: Colors.grey[500], size: 20),
                                ])));
                  },
                ),
                SizedBox(height: size.height * 0.03),
                TextInput(
                  size: size,
                  hint: "Email",
                  isVisible: true,
                  controller: _emailController,
                  suffixIconAsset: 'assets/icons/email_outline.png',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    } else if (FirebaseAuth.instance.currentUser!.email !=
                            null &&
                        _emailController.text !=
                            FirebaseAuth.instance.currentUser!.email) {
                      return 'Please enter your current email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: size.width * 0.9,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0XFFFAFAFA),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return DropdownButton<String>(
                              underline: Container(), // no underline
                              hint: Text("Choose country",
                                  style: AppStyles.hintText),
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey[500], size: 22),
                              value: state.country,
                              items: phoneCountryList
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item["name"],
                                      child: Row(
                                        children: [
                                          Image.asset(item["flagAsset"],
                                              height: 25,
                                              width: 25,
                                              fit: BoxFit.contain),
                                          const SizedBox(width: 10),
                                          Text(item["name"],
                                              style: TextStyle(
                                                  color: Colors.grey[500])),
                                        ],
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(UpdateCountry(country: value));
                                }
                              });
                        },
                      ),
                      TextInput(
                          size: Size(size.width / 2 - 21, size.height),
                          hint: "Phone",
                          isVisible: true,
                          controller: _phoneController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          })
                    ],
                  ),
                ),
              ]),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ColorButton(
                        size: Size(size.width - 1, size.height),
                        backgroundColor: AppColors.primaryColor,
                        textColor: const Color(0XFFE6F9ED),
                        label: "Continue",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await _addUserToFb(state);
                            if (!mounted) return;
                            Navigator.of(context)
                                .pushNamed(FollowArtistsPage.id);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const ShowProfile()));
                          }
                        });
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    ));
  }

  _addUserToFb(ProfileState state) async {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(_emailController.text);
    final json = {
      'fullName': _fullNameController.text,
      'nickname': _nickNameController.text,
      'birthday': state.birthday,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'country': state.country,
    };
    await docUser.set(json);
  }

  _uploadImage(BuildContext context, ProfileState state) async {
    final firebaseStorage = FirebaseStorage.instance;
    const email = 'nguyentienvi1902003@gmail.com';
    var ref = firebaseStorage.ref().child('$email.jpg');
    if (state.avatar != null) {
      await ref.putFile(state.avatar!);

      // ref.getDownloadURL().then((value) {
      //   setState(() {
      //     profileImageUrl = value;
      //   });
      // });
      // print(profileImageUrl);
    }
  }

  AlertDialog _alertDialog(Size size, BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Select profile photo',
          textAlign: TextAlign.center, style: AppStyles.headerText),
      // actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      buttonPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      content: SizedBox(
        height: 150,
        child: Column(children: [
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return TextButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/camera.png',
                                height: 20, color: AppColors.primaryColor),
                            const SizedBox(width: 10),
                            Text('Take a photo',
                                style: AppStyles.dialogItemText)
                          ]),
                      onPressed: () async {
                        await getProfileImage(context, ImageSource.camera);

                        if (!mounted) return;
                        _uploadImage(context, state);
                        Navigator.pop(context);
                      });
                },
              );
            },
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return TextButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/gallery.png',
                                height: 20, color: AppColors.primaryColor),
                            const SizedBox(width: 10),
                            Text('Choose from gallery',
                                style: AppStyles.dialogItemText)
                          ]),
                      onPressed: () async {
                        await getProfileImage(context, ImageSource.gallery);

                        if (!mounted) return;
                        _uploadImage(context, state);
                        Navigator.pop(context);
                      });
                },
              );
            },
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          TextButton(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(width: 10),
                Text('Cancel',
                    style: AppStyles.dialogItemText
                        .copyWith(color: AppColors.primaryColor))
              ]),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
  }

  getProfileImage(BuildContext context, ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      final temporaryImage = File(image.path);

      if (!mounted) return;
      context.read<ProfileBloc>().add(UpdateAvatar(avatar: temporaryImage));
    }
  }
}
