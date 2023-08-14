// ignore_for_file: prefer_const_constructors
// Import package
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoad = true;
 int count = 0; 
String? name, phone, address0,address1, email, image, id, pincode;

getDetails() async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
  name = prefs.getString("name");
  phone = prefs.getString("phone");
  address0= 'Hemja';
  address1 = 'Pokhara';
  email = prefs.getString("email");
  image = prefs.getString("image")?? '';
  id = prefs.getString("id");
  pincode = '33700';
  setState(() {
    _isLoad = false;
  });
}
  getCartCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
CartDatabaseHelper cdv = CartDatabaseHelper();
await cdv.initDatabase();
 int c = await cdv.cartCount();
  //print('asbsb $c');
 setState(() {
   count = c;
 });
prefs.setInt('cartCount', count);
}

@override
  void initState() {
    getDetails();
getCartCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomNavigationBar: BottomNavBar(count: count,),
extendBodyBehindAppBar: false,
appBar: AppBar(

  leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
         Navigator.of(context).pop();
        },),
  backgroundColor: Colors.transparent,
  title: Text('Profile', style: AppTheme.of(context).title1,),
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
              AuthService auth = AuthService();
    auth.signOutuser(context);
            },
            )..show();
    // AuthService auth = AuthService();
    // auth.signOutuser(context);
       
      }, icon: Icon(Icons.logout, color: Colors.black87,)),
    )
  ],
  elevation: 0,
),
backgroundColor: Color.fromRGBO(231, 254, 245, 1),
body: SafeArea(child: SingleChildScrollView(child: Column(
children: [
Container(height: 290,

child: Center(
  child: Padding(padding: EdgeInsets.all(10),
  
  child: Column(children: [
CircleAvatar(
  backgroundColor: Colors.transparent,
radius: 80,
child: GestureDetector(
  onTap: () {

  },
  child:   ClipRRect(
  
    borderRadius: BorderRadius.circular(50),
  
    clipBehavior: Clip.antiAlias,
  
    child: (image != '') ? Image(image: CachedNetworkImageProvider('$image')) : Container( height: 120, width: 90,color: Colors.white54,child: Icon(Icons.add_a_photo, size: 70, color: Color.fromRGBO(88, 182, 148, 1),)),
  
  ),
),
    ),
SizedBox(height: 10,),
Text('$name', style: AppTheme.of(context).title3,),
SizedBox(height: 10,),
Text('$email', style: AppTheme.of(context).bodyText1,)
 

  ],),
  ),
),
),
Container(
  height: 600,
  width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    color: Colors.white
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    
    children: [
      SizedBox(height: 20,),
GestureDetector(
  onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditProfile(image: image,name: name, phone: phone, email: email, address0: address0,address1: address1, id: id, pincode: pincode,)));

  },
  child:   Padding(padding: EdgeInsets.fromLTRB(30, 20, 20, 5),
  
  
  
  child: Expanded(
  
    child:   Row(children: [
  
    
  
      Icon(Icons.person, color: Color.fromRGBO(88, 182, 148, 1),),
  
    
  
      Padding(
  
    
  
        padding: const EdgeInsets.fromLTRB(10, 5, 190, 0),
  
    
  
        child: Text('My profile', style: AppTheme.of(context).bodyText1,),
  
    
  
      ),
  
    
  
     
  
    
  
      Icon(Icons.arrow_forward_ios)
  
    
  
    ],),
  
  ),
  
  
  
  
  
  ),
),
SizedBox(height: 20,),
GestureDetector(
   onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrderList()));

  },
  child:   Padding(padding: EdgeInsets.fromLTRB(30, 20, 20, 5),
  
  
  
  child: Expanded(
  
    child:   Row(children: [
  
    
  
      Icon(Icons.library_books, color: Color.fromRGBO(88, 182, 148, 1),),
  
    
  
      Padding(
  
    
  
        padding: const EdgeInsets.fromLTRB(10, 5, 190, 0),
  
    
  
        child: Text('My Orders', style: AppTheme.of(context).bodyText1,),
  
    
  
      ),
  
    
  
     
  
    
  
      Icon(Icons.arrow_forward_ios)
  
    
  
    ],),
  
  ),
  
  
  
  
  
  ),
),
SizedBox(height: 20,),
GestureDetector(
  child:   Padding(padding: EdgeInsets.fromLTRB(30, 20, 20, 5),
  
  
  
  child: Expanded(
  
    child:   Row(children: [
  
    
  
      Icon(Icons.place_rounded, color: Color.fromRGBO(88, 182, 148, 1),),
  
    
  
      Padding(
  
    
  
        padding: const EdgeInsets.fromLTRB(10, 5, 180, 0),
  
    
  
        child: Text('My Address', style: AppTheme.of(context).bodyText1,),
  
    
  
      ),
  
    
  
     
  
    
  
      Icon(Icons.arrow_forward_ios)
  
    
  
    ],),
  
  ),
  
  
  
  
  
  ),
),SizedBox(height: 20,),

GestureDetector(
  onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChangePassword()));


  },
  child:   Padding(padding: EdgeInsets.fromLTRB(30, 20, 20, 5),
  
  
  
  child: Expanded(
  
    child:   Row(children: [
  
    
  
      Icon(Icons.password, color: Color.fromRGBO(88, 182, 148, 1),),
  
    
  
      Padding(
  
    
  
        padding: const EdgeInsets.fromLTRB(10, 5, 135, 0),
  
    
  
        child: Text('Change Password', style: AppTheme.of(context).bodyText1,),
  
    
  
      ),
  
    
  
     
  
    
  
      Icon(Icons.arrow_forward_ios),
  
    
  
    ],),
  
  ),
  
  
  
  
  
  ),
)

    ],
  ),
)
],

),
),
),
    );
  }
}