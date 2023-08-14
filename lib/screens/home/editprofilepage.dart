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

class EditProfile extends StatefulWidget {
String? name, phone, address0,address1, email, image, id , pincode; 
  EditProfile({super.key, required this.name,required this.phone,required this.address0,required this.address1,required this.email,required this.image, required this.id, required this.pincode });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;
   TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
    TextEditingController address0Controller = TextEditingController();
      TextEditingController address1Controller = TextEditingController();

      TextEditingController pinController = TextEditingController();


@override
void initState() {
  
  nameController.text = '${widget.name}';
  emailController.text = '${widget.email}';
  address0Controller.text = '${widget.address0}';
  address1Controller.text = '${widget.address1}';
  phoneController.text = '${widget.phone}';
  pinController.text = '${widget.pincode}';

  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    
    return Scaffold(
extendBodyBehindAppBar: false,
appBar: AppBar(

  leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
         Navigator.of(context).pop();
        },),
  backgroundColor: Colors.transparent,
  title: Text('My Profile', style: AppTheme.of(context).title1,),
  centerTitle: true,
  actions: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(onPressed: () async {


        AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
          //  animType: AnimType.rightSlide,,
            title: 'Confirm Logout',
            desc: 'This Action is Irreversible Once Commenced.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              // AuthService auth = AuthService();
    // auth.signOutuser(context);
            },
            )..show();
    // AuthService auth = AuthService();
    // auth.signOutuser(context);
       
      }, icon: Icon(Icons.logout, color: Colors.black87,)),
    )
  ],
  elevation: 0,
),
body: SafeArea(
  child: SingleChildScrollView(
  physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Center(
            child: CircleAvatar(
            backgroundColor: Colors.transparent,
          radius: 80,
          child: GestureDetector(
            onTap: () {},
            child:   ClipRRect(
            
              borderRadius: BorderRadius.circular(50),
            
              clipBehavior: Clip.antiAlias,
            
              child: (widget.image != '') ? Image(image: CachedNetworkImageProvider('${widget.image}')) : Container( height: 120, width: 90,color: Colors.white54,child: Icon(Icons.add_a_photo, size: 70, color: Color.fromRGBO(88, 182, 148, 1),)),
            
            ),
          ),
              ),
          ),
          SizedBox(height: 40,),
       Padding(
       padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
       child: TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration:  InputDecoration(
                        label: Text('Name', style: AppTheme.of(context).subtitle1,),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(88, 182, 148, 1),
                      ),
                    ),
                        prefixIcon: Icon(Icons.person,  color: Color.fromRGBO(88, 182, 148, 1),),
                        hintText: 'Name',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
       textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        } else if (value.length < 4) {
                          return 'at least enter 4 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                    Padding(
       padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
       child: TextFormField(
        readOnly: true,
                      style: kTextFormFieldStyle(),
                      decoration:  InputDecoration(
                        label: Text('Email', style: AppTheme.of(context).subtitle1,),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(88, 182, 148, 1),
                      ),
                    ),
                        prefixIcon: Icon(Icons.email,  color: Color.fromRGBO(88, 182, 148, 1),),
                        hintText: emailController.text,
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
       textCapitalization: TextCapitalization.words,
                      controller: emailController,
                      // The validator receives the text that the user has entered.
                     
                    ),
       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
                    child: TextFormField(
                    style: kTextFormFieldStyle(),
                     keyboardType: TextInputType.phone,
                    decoration:  InputDecoration(
                        label: Text('Phone', style: AppTheme.of(context).subtitle1,),
                       focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(88, 182, 148, 1),
                    ),
                                  ),
                                  
                      prefixIcon: Icon(Icons.phone,  color: Color.fromRGBO(88, 182, 148, 1),),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    controller: phoneController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      } else if (value.length < 10) {
                        return 'Phone number must be 10 digits long';
                      } else if (value.length > 10) {
                        return 'Phone number must be 10 digits long';
                      }else if(!value.isNumericOnly){
                      return 'Phone number must be numbers';
                      }                     
                      return null;
                    },
                                  ),
                  ),
                SizedBox(
                  height: size.height * 0.02,
                ),
  Padding(
       padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
       child: TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration:  InputDecoration(
                        label: Text('Address line 1', style: AppTheme.of(context).subtitle1,),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(88, 182, 148, 1),
                      ),
                    ),
                        prefixIcon: Icon(Icons.place,  color: Color.fromRGBO(88, 182, 148, 1),),
                        hintText: 'Address Line 1',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
       textCapitalization: TextCapitalization.words,
                      controller: address0Controller,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        } else if (value.length < 4) {
                          return 'at least enter 4 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),  Padding(
       padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
       child: TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration:  InputDecoration(
                        label: Text('Address line 2', style: AppTheme.of(context).subtitle1,),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(88, 182, 148, 1),
                      ),
                    ),
                        prefixIcon: Icon(Icons.place,  color: Color.fromRGBO(88, 182, 148, 1),),
                        hintText: 'Address Line 2',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
       textCapitalization: TextCapitalization.words,
                      controller: address1Controller,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        } else if (value.length < 4) {
                          return 'at least enter 4 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                    Padding(
       padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
       child: TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration:  InputDecoration(
                        label: Text('PinCode', style: AppTheme.of(context).subtitle1,),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(88, 182, 148, 1),
                      ),
                    ),
                        prefixIcon: Icon(Icons.pin_drop,  color: Color.fromRGBO(88, 182, 148, 1),),
                        hintText: 'PinCode',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
       textCapitalization: TextCapitalization.words,
                      controller: pinController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        } else if (value.length < 4) {
                          return 'at least enter 4 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                                  signUpButton(theme),

                 SizedBox(
                    height: size.height * 0.02,
                  ),
        ],
      ),
    ),
  ),
),
    );
  }
  Widget signUpButton(ThemeData theme) {
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
        child:_isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Update Details', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
    );
  }
}