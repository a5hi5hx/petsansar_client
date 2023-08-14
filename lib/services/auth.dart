
// ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements, prefer_const_constructors

import 'package:flutter/material.dart';
import '../screens/auth/verify.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exports.dart';
import 'package:dio/dio.dart';

class AuthService {
  void signupUser({
     required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber
  }) async {
try{

 SharedPreferences prefs = await SharedPreferences.getInstance();

      // User user = User(
      //   id: '',
      //   name: name,
      //   email: email,
      //   token: '',
      //   password: password,
      //   isVerified: '',
      //   phoneNumber: phoneNumber
      // );
   Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(
        '${Constants.useruri}/signup',
        data: {
  "name": name,
  "phoneNumber":phoneNumber,
  "email":email,
  "password":password
}
      );

        await prefs.setString('x-auth-token', response.data['token']);
        await prefs.setString('id', response.data['_id']);
        await  prefs.setString('email', response.data['email']);
        await   prefs.setString('name', response.data['name']);
          //prefs.setString('address', response.data['address']);
        await  prefs.setString('phone', response.data['phoneNumber']);
        await  prefs.setString('imgUser', response.data['image']);
      String uEmail = response.data['email'];
      //prefs.setString('id', response.data['id']);
       //await prefs.setString('x-auth-token', response.data['token']);
        //await  prefs.setString('email', response.data['email']);
        //await   prefs.setString('name', response.data['name']);
          //prefs.setString('address', response.data['address']);
        //await  prefs.setString('phone', response.data['phoneNumber']);
        //await  prefs.setString('image', response.data['image']);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => VerifyView(email: uEmail,)));

}on DioException catch (e) {
switch (e.response?.statusCode) {
        case 400:
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text(e.response?.data["message"]),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
          //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                     builder: (context) => SignUpView()));
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
           AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.response?.data["message"],
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginView()));
            },
            )..show();
          break;
        case 500:
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text('error'),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
          //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                     builder: (context) => SignUpView()));
          //                 // Navigator.of(context).pop();
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
            AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text('Error',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpView()));
            },
            )..show();
          break;
        default:
        
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text(e.toString()),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) => SignUpView()));
          //                 // Navigator.of(context).pop();
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
            
                   AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.toString(),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpView()));
            },
            )..show();
      }


}
  }

void signinuser({
required BuildContext context,
    required String email,
    required String userpassword,
}) async {
try{
        final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
        Dio dio = Dio();
 SharedPreferences prefs = await SharedPreferences.getInstance();
  dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(
        '${Constants.useruri}/login',
        data: {'email': email, 'userpassword': userpassword},
      );
//                 await prefs.setString('x-auth-token', response.data['token']);
// await prefs.setString('id', response.data['_id']);
//         await  prefs.setString('email', response.data['email']);
//         await   prefs.setString('name', response.data['name']);
//           //prefs.setString('address', response.data['address']);
//         await  prefs.setString('phone', response.data['phoneNumber']);
//         await  prefs.setString('imgUser', response.data['image']);
if(response.data['isVerified'] == 'true'){
   SharedPreferences prefs = await SharedPreferences.getInstance();
  //         "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0Y2NkMzUxOTZkMmFiY2JhODQ3NjZkNSIsImlhdCI6MTY5MTQyMDUxNX0.SIgy-GV9WJ-XQVOwOoYB9QgPVhFg8WxIaZT-qzwPREY",
  // "_id": "64ccd35196d2abcba84766d5",
  // "email": "ashishpaudel54@gmail.com",
  // "isVerified": true,
  // "name": "Ashish Paudel",
  // "phoneNumber": "9846880362",
  // "image": "https://res.cloudinary.com/djq37xptm/image/upload/v1677953696/i02sxwh0mn1biz6ivgiu.jpg",
          await prefs.setString('id', response.data['_id']);
        await  prefs.setString('email', response.data['email']);
         await prefs.setString('name', response.data['name']);
        await  prefs.setString('email', response.data['email']);
        await  prefs.setString('phone', response.data['phoneNumber']);
         await prefs.setString('image', response.data['image']);
          userProvider.setUser(response.toString());
          await prefs.setString('x-auth-token', response.data['token']);
          // navigator.pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (context) => HomeScreen(),
          //   ),
          //   (route) => false,
          // );
          navigator.pushReplacement(  MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
}
else{
      await prefs.setString('id', response.data['_id']);
      await    prefs.setString('email', response.data['email']);
      await    prefs.setString('name', response.data['name']);
      await    prefs.setString('email', response.data['email']);
      await   prefs.setString('phone', response.data['phoneNumber']);
      await   prefs.setString('image', response.data['image']);
      await prefs.setString('x-auth-token', response.data['token']);
   String uEmail = response.data['email'];
   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => VerifyView(
                        email: uEmail,
                      )));
}




}on DioException catch(e){

switch (e.response?.statusCode) {
        case 400:
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text(e.response?.data["message"]),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
                          
          //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                     builder: (context) => LoginView()));
                         
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
                   AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.response?.data["message"],
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginView()));
            },
            )..show();
          break;
        case 500:
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text(e.response?.data["message"]),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
                          
          //                  Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                     builder: (context) => LoginView()));
                         
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
           AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.toString(),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginView()));
            },
            )..show();
          break;
        default:
         AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.response?.data["message"],
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {
              Navigator.of(context).pop();
                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginView()));
            },
            )..show();
          // showDialog(
          //     context: context,
          //     builder: (ctx) => AlertDialog(
          //           title: const Text("Error"),
          //           content: Text(e.toString()),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(ctx).pop();
                          
          //                  Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                     builder: (context) => LoginView()));
                         
          //               },
          //               child: Container(
          //                 color: Colors.blue,
          //                 padding: const EdgeInsets.all(14),
          //                 child: const Text(
          //                   "OK",
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ));
      }
}
}
void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['x-auth-token'] = token!;
      var tokenRes = await dio.get(
        '${Constants.useruri}/tokenValid',
      );
      var response = tokenRes.data['msg'];
      if (response == 'true') {
        //Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['x-auth-token'] = token;
        Response userRes = await dio.get(
          '${Constants.useruri}/user',
        );
        userProvider.setUser(userRes.toString());
      }
    } catch (e) {
      AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(child: Text(e.toString(),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),),
            title: 'Error',
            desc:   'Some Error Occured',
            btnOkOnPress: () {},
            )..show();
// showSnackBar(BuildContext context, String text) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         child: AlertDialog(
//           title: const Text('Message'),
//           content: Text(e.toString()),
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }   
 }
  }

  void signOutuser(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginView()),
        (route) => false);
  }
}