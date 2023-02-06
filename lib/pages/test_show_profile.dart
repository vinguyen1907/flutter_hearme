import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hear_me/blocs/auth_bloc/auth_bloc.dart';
import 'package:hear_me/blocs/bloc_exports.dart';
import 'package:hear_me/pages/sign_in_page.dart';
import 'package:hear_me/services/auth_service.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // final user = FirebaseAuth.instance.currentUser;
            if (snapshot.hasData) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(FirebaseAuth.instance.currentUser!.email!),
                      Text(FirebaseAuth.instance.currentUser!.displayName!),
                      ElevatedButton(
                          onPressed: () {
                            _signOut();
                          },
                          child: const Text("Sign Out"))
                    ]),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return const SignInPage();
            }
          }),
    );
  }

  _signOut() {
    BlocProvider.of<AuthBloc>(context).add(SignOut());
  }
}
