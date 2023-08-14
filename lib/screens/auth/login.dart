// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../exports.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                'assets/signin.png',
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
                TextFormField(
                  
                  style: kTextFormFieldStyle(),
                  decoration:  InputDecoration(
                      focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(88, 182, 148, 1),
                  ),
                ),
                    prefixIcon: Icon(Icons.person, color: Color.fromRGBO(88, 182, 148, 1),),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  controller: emailController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!(RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value))) {
                      return 'Enter Valid E-Mail';
                    }
                    return null;
                  },
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
                      hintText: 'Password',
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
                
  /// Navigate To Login Screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text('Don\'t have an account?',
                    //   style: kHaveAnAccountStyle(size),),
GestureDetector(
  onTap:() {
                    
                  
                    emailController.clear();
                    passwordController.clear();
                    _formKey.currentState?.reset();
                    simpleUIController.isObscure.value = true;
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>  ChangePasswordEmail()));
                    
                  } ,
  child: Text(" Forgot Password?",
                          style: kLoginOrSignUpTextStyle(
                            size,
                          ),),
),
                  ],
                ),
              SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Logging in means you\'re okay with our Terms of Services and our Privacy Policy',
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
                    Text('Don\'t have an account?',
                      style: kHaveAnAccountStyle(size),),
GestureDetector(
  onTap:() {
                    
                  
                    emailController.clear();
                    passwordController.clear();
                    _formKey.currentState?.reset();
                    simpleUIController.isObscure.value = true;
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>  SignUpView()));
                    
                  } ,
  child: Text(" Sign up",
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
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
              setState(() {
              _isLoading = true;
            });
           AuthService auth =   AuthService();
auth.signinuser(context: context, email: emailController.text, userpassword: passwordController.text);
          }
        },
        child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
    );
  }
}