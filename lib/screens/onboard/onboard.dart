import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../../exports.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});
   _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }
 @override
  Widget build(BuildContext context) {
 return Scaffold(
   body: OnBoardingSlider(
        finishButtonText: 'Register',
      onFinish: () {
_storeOnboardInfo();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpView(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: const Color.fromRGBO(88, 182, 148, 1),
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: const Color.fromRGBO(88, 182, 148, 1),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: const Color.fromRGBO(88, 182, 148, 1),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      },
      controllerColor: const Color.fromRGBO(88, 182, 148, 1),
      totalPage: 4,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'assets/img3.png',
          height: 400,
           width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/img4.png',
          height: 400,
           width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/img.png',
          height: 400,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/img2.png',
          height: 400,
           width: MediaQuery.of(context).size.width,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Discover Pet Happiness',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(88, 182, 148, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Shop Essential Pet Supplies with Ease"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'For Every Furry Friend',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(88, 182, 148, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Quality Products for Dogs, Cats, and More',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Shop Pet Essentials',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(88, 182, 148, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Easy Ordering for Happy Pets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Connect with Fellow Pet Owners',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(88, 182, 148, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Be Part of the Pet Sansar Family',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
 );
}
}