import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In'),
      ),
      body: buildBody(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildBody() {
    return Container(
      child: Center(
        child: isLoggedIn ? buildUserInfo() : buildSignInButton(),
      ),
    );
  }

  Widget buildSignInButton() {
    return ElevatedButton(
        child: Text('Google Sign In'),
        onPressed: () {
          signIn();
        });
  }

  Widget buildUserInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(googleSignIn.currentUser.photoUrl),
        SizedBox(height: 10,),
        Text(googleSignIn.currentUser.displayName,style: TextStyle(fontSize: 20),),
        SizedBox(height: 10,),
        Text(googleSignIn.currentUser.email,style: TextStyle(fontSize: 16),),
        SizedBox(height: 10,),
        buildSignOutButton(),
      ],
    );
  }

  Widget buildSignOutButton() {
    return ElevatedButton(
        child: Text('Sign Out'),
        onPressed: () {
          signOut();
        });
  }

  Future<void> signIn() async {
    try {
      await googleSignIn.signIn();
      setState(() {
        isLoggedIn = true;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      setState(() {
        isLoggedIn = false;
      });
    } catch (error) {
      print(error);
    }
  }
}
