// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../exports.dart';

class VerifyView extends StatefulWidget {
  final String email;
   VerifyView({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
    final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
Future sendEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isLoading = true;
    });
    try {
      
            Dio dio = Dio();

      Response response =
          await dio.post("${Constants.useruri}/verifyEmails", data: {'email': widget.email});
          
      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
      } else {
       showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text('Trying to resend. CLose this window'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => VerifyView(
                                    email: widget.email,
                                  )));
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text('Error Occured. Trying to resend. CLose this window'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) =>
                                  VerifyView(email: widget.email)));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text("${e}trying to resend. CLose this window"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => VerifyView(
                                    email: widget.email,
                                  )));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }
  @override
  void dispose() {
    _fieldFour.dispose();
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    super.dispose();
  }

 @override
  void initState() {
    // TODO: implement initState
    sendEmail();
    super.initState();
  }
    @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.put(SimpleUIController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            // if (constraints.maxWidth > 600) {
            //   return _buildLargeScreen(size, simpleUIController);
            // } else {
              return _buildSmallScreen(size, simpleUIController);
            // }
          },
        ),
      ),
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
            Image.asset(
                'assets/verify.png',
                //height: 300,
                width: size.width,
                fit: BoxFit.fill,
              ),
        SizedBox(
          height: size.height * 0.03,
        ),
       
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Enter OTP received in Email',
            style: kLoginSubtitleStyle(size),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// username or Gmail
  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne, true), // auto focus
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false)
            ],
          ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Verifying OTP is a necessary step in confirming your identity to us. Helps us to remove spam upto a certain bit.',
                  style: kLoginTermsAndPrivacyStyle(size),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// Login Button
                loginButton(),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Didn\'t receive the code?',
                      style: kHaveAnAccountStyle(size),),
GestureDetector(
  onTap:() {
                    _formKey.currentState?.reset();
                    //  Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (ctx) =>  SignUpView()));
                    sendEmail();
                  } ,
  child: Text(" Resend",
                          style: kLoginOrSignUpTextStyle(
                            size,
                          ),),
),
                  ],
                )
              
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(88, 182, 148, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ), 
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final data = {'email': widget.email, 'otp':_otp};
       Response response =
          await dio.post("${Constants.useruri}/verifyUser", data: data);
if(response.statusCode == 200)
{

        var userProvider = Provider.of<UserProvider>(context, listen: false);

   userProvider.setUser(response.toString());
showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Success"),
                    content: Text('Successfully verified'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));

}
else{
showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text("Trying to resend. CLose this window and Verify again"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => VerifyView(
                                    email: widget.email,
                                  )));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
}          }
        },
        child: _isLoading ? const CircularProgressIndicator(color: Colors.white,): Text('Verify', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
    );
  }

   
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
  
}