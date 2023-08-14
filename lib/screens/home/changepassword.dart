// ignore_for_file: prefer_const_constructors
// Import package
import 'dart:convert';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.put(SimpleUIController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        
        appBar: AppBar(elevation: 0,   leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
         Navigator.of(context).pop();
        },), 
        backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            // if (constraints.maxWidth > 600) {
            //   return _buildLargeScreen(size, simpleUIController);
            // } else {
              return _buildSmallScreen(context, size, simpleUIController);
            // }
          },
        ),
      ),
    );
  }

  /// For large screens
  // Widget _buildLargeScreen(
  //   Size size,
  //   SimpleUIController simpleUIController,
  // ) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         flex: 4,
  //         child: RotatedBox(
  //           quarterTurns: 3,
  //           child: Lottie.asset(
  //             'assets/wave.json',
  //             height: size.height * 0.3,
  //             width: double.infinity,
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: size.width * 0.06),
  //       Expanded(
  //         flex: 5,
  //         child: _buildMainBody(
  //           size,
  //           simpleUIController,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /// For Small screens
  Widget _buildSmallScreen(
    BuildContext context,
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        context,
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    BuildContext context,
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
            Image.asset(
                'assets/passeordchange.png',
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
            'Enter your credentials',
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
           Obx(
                  () => TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: passwordController,
                    obscureText: simpleUIController.isObscure.value,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(88, 182, 148, 1),
                  ),
                ),
                      prefixIcon: const Icon(Icons.lock_open, color: Color.fromRGBO(88, 182, 148, 1),),
                      suffixIcon: IconButton(
                        icon: Icon(
                          simpleUIController.isObscure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                             color: Color.fromRGBO(88, 182, 148, 1),
                        ),
                        onPressed: () {
                          simpleUIController.isObscureActive();
                        },
                      ),
                      hintText: 'Old Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 7) {
                        return 'at least enter 6 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                // TextFormField(
                //   controller: emailController,
                //   decoration: const InputDecoration(
                //     prefixIcon: Icon(Icons.email_rounded),
                //     hintText: 'gmail',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(15)),
                //     ),
                //   ),
                //   // The validator receives the text that the user has entered.
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter gmail';
                //     } else if (!value.endsWith('@gmail.com')) {
                //       return 'please enter valid gmail';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// password
                Obx(
                  () => TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: passwordController,
                    obscureText: simpleUIController.isObscure.value,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(88, 182, 148, 1),
                  ),
                ),
                      prefixIcon: const Icon(Icons.lock_open, color: Color.fromRGBO(88, 182, 148, 1),),
                      suffixIcon: IconButton(
                        icon: Icon(
                          simpleUIController.isObscure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                             color: Color.fromRGBO(88, 182, 148, 1),
                        ),
                        onPressed: () {
                          simpleUIController.isObscureActive();
                        },
                      ),
                      hintText: 'New Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 7) {
                        return 'at least enter 6 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                
                SizedBox(
                  height: size.height * 0.02,
                ),
Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text('Don\'t have an account?',
                    //   style: kHaveAnAccountStyle(size),),
GestureDetector(
  onTap:() {
                    
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChangePasswordEmail()));    
                   
                    
                  } ,
  child: Text(" Use E-mail Instead?",
                          style: kLoginOrSignUpTextStyle(
                            size,
                          ),),
),
                  ],
                ),
              SizedBox(
                  height: size.height * 0.03,
                ),
                /// Login Button
                loginButton(),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen

              
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
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          
        },
        child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Request Change', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
    );
}

}