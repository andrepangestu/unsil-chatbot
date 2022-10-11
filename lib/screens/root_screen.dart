// import 'package:flutter/material.dart';
//
// class RootScreen extends StatefulWidget {
//   RootScreen({this.auth});
//   final BaseAuth auth;
//
//   @override
//   State<StatefulWidget> createState() => new _RootScreenState();
// }
//
// class _RootScreenState extends State<RootScreen> {
//
//   AuthStatus _authStatus = AuthStatus.notSignedIn;
//
//   @override
//   void initState(){
//     super.initState();
//     widget.auth.currentUser().then((userId) {
//       setState(() {
//         _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
//       });
//     });
//   }
//
//   void _signedIn() {
//     setState(() {
//       _authStatus = AuthStatus.signedIn;
//     });
//   }
//
//   void _signedOut(){
//     setState(() {
//       _authStatus = AuthStatus.notSignedIn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext contex) {
//     switch (_authStatus) {
//       case AuthStatus.notSignedIn:
//         return new LoginPage(
//           auth: widget.auth,
//           onSignedIn: _signedIn,
//         );
//       case AuthStatus.signedIn:
//         return new Home(
//           auth: widget.auth,
//           onSignOut: _signedOut,
//         );
//       default:
//     }
//   }
//
// }