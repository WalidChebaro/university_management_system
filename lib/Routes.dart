import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'TestPage.dart';
import 'User.dart';
import 'StaffRoutes.dart';

class Routes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RoutesState();
}

enum AuthStatus { notDetermined, notSignedIn, signedIn }

class _RoutesState extends State<Routes> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return new LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new FutureBuilder(
            future: User().userType(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == 'Student') {
                  return new TestPage(onSignedOut: _signedOut);
                } else {
                  return new StaffRoutes(onSignedOut: _signedOut);
                }
              } else {
                return CircularProgressIndicator();
              }
            });
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
