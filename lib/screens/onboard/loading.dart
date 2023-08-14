// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exports.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isSync = true;
  bool checkLogin = true;
  //bool _isDetailsDone = true;
  String? uEmail;
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    // _getUserName();
    Timer(
        Duration(seconds: 5),
        () => setState(() {
              _isSync = false;
            }));
  }

  // Future _getUserName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('name') == null) {
  //     setState(() {
  //       uEmail = prefs.getString('uEmail');
  //       _isDetailsDone = false;
  //     });
  //   }
  // }
// loadCart(BuildContext context) async {
//   CartDatabaseHelper cdb = CartDatabaseHelper();
//   await cdb.initDatabase();
//   List<CartItem> carti = await cdb.getCartItems();
//   print('123 $carti');
//   if(carti.isEmpty){
//     return;
//   }
//   CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
//   for (CartItem cartItem in carti) {
//     cartProvider.addToCart(cartItem);
//   }
// }
  @override
  Widget build(BuildContext context) {
     checkLogin = Provider.of<UserProvider>(context).user.token!.isEmpty;
    //loadCart(context);
    // if (checkLogin || !checkLogin) {
    //   setState(() {
    //     _isSync = false;
    //   });
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        body: _isSync
            ? Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 75.0,
                  width: 75.0,
                  fit: BoxFit.scaleDown,
                ),
              )
            : checkLogin
                ? LoginView()
                : HomeScreen());
  }
}
