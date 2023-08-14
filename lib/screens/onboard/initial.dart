import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../exports.dart';

class LogoInitial extends StatefulWidget {
  const LogoInitial({super.key});

  @override
  State<LogoInitial> createState() => _LogoInitialState();
}

class _LogoInitialState extends State<LogoInitial> {
final String assetName = 'assets/logo.svg';
  bool checkLogin = true;
  bool _isSync = true;

 final AuthService authService = AuthService();

@override
void initState() {

    super.initState();
    //initPlatform();
    authService.getUserData(context);
    Timer(
        Duration(seconds: 5),
        () => setState(() {
              _isSync = false;
            }));
  }


  @override
  Widget build(BuildContext context) {
        bool checkLogin = Provider.of<UserProvider>(context).user.token!.isEmpty;
    return Scaffold(
      backgroundColor:const Color.fromRGBO(88, 182, 148, 1),
      //body: Center(child: SvgPicture.asset(assetName, semanticsLabel: 'PetSansar Logo') ,
      body: _isSync
            ? Center(child: SvgPicture.asset(assetName, semanticsLabel: 'PetSansar Logo'))
            : checkLogin
                ? HomeScreen()
                : LoginView()
                );
     
  }
}