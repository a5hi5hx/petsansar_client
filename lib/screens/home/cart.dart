// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({super.key});

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
bool _load = true;
bool _empty = true;
bool _loadP = true;
int? fPrice = 0;
int? del = 0;
int? fquant = 0;
  List<CartItem> cartI = [];
  List<Product> products = [];
  List<String> ProductIDs = [];
    List<String> quatttt = [];

  Future<void> getCartProducts() async {
 CartDatabaseHelper cdb = CartDatabaseHelper();
 await cdb.initDatabase();
     //final cartProvider = Provider.of<CartProvider>(context);
    cartI = await cdb.getCartItems();
if(cartI.isNotEmpty){
  DatabaseHelper dvh = DatabaseHelper();
  await dvh.initDatabase();
List<String> quantitiees = cartI.map((item) => item.quantity.toString()).toList();
List<String> productIds = cartI.map((item) => item.productId).toList();
    // Fetch related products from the Products table using productIds
    products = await dvh.fetchProductsFromDatabase(productIds);
setState(() {
  quatttt = quantitiees;
  ProductIDs = productIds;
  _load = false;
  _empty = false;
});
}
else{
  setState(() {
  _load = false;
  _empty = true;
});
}

}
  @override
  void initState() {
    getCartProducts();
    getDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // CartDatabaseHelper cdb = CartDatabaseHelper();
   // cdb.initDatabase();
   //  final cartProvider = Provider.of<CartProvider>(context);
    //final cartItems = cdb.cartCount();
    return Scaffold(
      appBar: AppBar(
         leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.of(context).secondaryText,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.of(context).secondaryBackground,
title: Center(
      child: Padding(
      
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
      
        child: Text('My Cart', style: AppTheme.of(context).title1,),
      
      ),
    ),

      ),
body: SafeArea(child: SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:   Column(
  
  mainAxisAlignment: MainAxisAlignment.start,
  
  crossAxisAlignment: CrossAxisAlignment.start,
  
  children: [
  
  
    SizedBox(height: 5,),
  
   _load ? ShimmerWidget(hei: 30) : _empty ? Lottie.network(
  
                    "https://assets10.lottiefiles.com/packages/lf20_mxuufmel.json",
  
                    height: 200,
  
                    width: 200,
  
                    fit: BoxFit.contain,
  
                    repeat: true,
  
                    animate: true,
  
                  ) : ListView.builder(
  
      padding: EdgeInsets.zero,
  
      primary: false,
  
      shrinkWrap: true,
  
      scrollDirection: Axis.vertical,
  
      itemCount: cartI.length,
  
      itemBuilder: (BuildContext context, int index) {
  
        return Padding(
  
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
  
          child: Container(
  
            width: double.infinity,
  
            height: 150,
  
            decoration: BoxDecoration(
  
              color: AppTheme.of(context).secondaryBackground,
  
              boxShadow: [
  
                BoxShadow(
  
                  blurRadius: 4,
  
                  color: Color(0x320E151B),
  
                  offset: Offset(0, 1),
  
                )
  
              ],
  
              borderRadius: BorderRadius.circular(12),
  
            ),
  
            child: Padding(
  
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
  
              child: Row(
  
                mainAxisSize: MainAxisSize.max,
  
                mainAxisAlignment: MainAxisAlignment.start,
  
                children: [
  
                  Hero(
  
                    tag: 'ControrImage',
  
                    transitionOnUserGestures: true,
  
                    child: ClipRRect(
  
                      borderRadius: BorderRadius.circular(12),
  
                      child: Image.network(
  
                        products[index].image[0],
  
                        width: 50,
  
                        height: 50,
  
                        fit: BoxFit.contain,
  
                      ),
  
                    ),
  
                  ),
  
                  Padding(
  
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  
                    child: Container(
  
                      height: 140, 
  
                      width:210,
  
                      child: Column(
  
                        mainAxisSize: MainAxisSize.max,
  
                        mainAxisAlignment: MainAxisAlignment.center,
  
                        crossAxisAlignment: CrossAxisAlignment.start,
  
                        children: [
  
                          GestureDetector(
  
                            onTap:  () {
  
                              //Navigator.of(context).pop();
  
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetail(product: products[index])));
  
                            },
  
                            child: Padding(
  
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
  
                              child: Text(
  
                                cartI[index].name,
  
                                overflow: TextOverflow.clip,
  
                                maxLines: 2,
  
                                style: AppTheme.of(context).subtitle2.override(
  
                                      fontFamily: 'Poppins',
  
                                      color: AppTheme.of(context).primaryText,
  
                                    ),
  
                              ),
  
                            ),
  
                          ),
  
                          Text(
  
                            '\Rs. ${products[index].price}',
  
                            style: AppTheme.of(context).bodyText2,
  
                          ),
  
                          Padding(
  
                            padding: EdgeInsetsDirectional.all(4),
  
                            child: Flex(
  
                              direction: Axis.horizontal,
  
                              children: 
  
                                [Row(
  
                                  
  
                                  children: [
  
                                   TextButton(onPressed: () {
  
                                    increaseItem(cartI[index].productId);
  
                                   }, child: Icon(Icons.add, color: Color.fromRGBO(88, 182, 148, 1),)),
  
                                    Text(
  
                                      'Quanity: ${cartI[index].quantity}',
  
                                      style: AppTheme.of(context).bodyText2,
  
                                    ),
  
                                     TextButton(onPressed: () {
  
                                    increaseItem(cartI[index].productId);
  
                                   }, child: Icon(Icons.minimize, color: Color.fromRGBO(88, 182, 148, 1),)),
  
                                  ],
  
                                ),
  
                              ],
  
                            ),
  
                          ),
  
                        ],
  
                      ),
  
                    ),
  
                  ),
  
                  SizedBox(
  
                    height: 20,
  
                    width: 20,
  
                    child: IconButton(
  
                      icon: Icon(
  
                        Icons.delete_outline_rounded,
  
                        color: Color(0xFFE86969),
  
                        size: 20,
  
                      ),
  
                      onPressed: () {
  
                  deleteItem(cartI[index].productId);
  
                      // Remove item
  
                      },
  
                    ),
  
                  ),
  
                ],
  
              ),
  
            ),
  
          ),
  
        );
  
      }),
  
  SizedBox(height: 30,),    _loadP ? ShimmerWidget(hei: 30) : _empty ? Lottie.network(
  
                    "https://assets10.lottiefiles.com/packages/lf20_mxuufmel.json",
  
                    height: 200,
  
                    width: 200,
  
                    fit: BoxFit.contain,
  
                    repeat: true,
  
                    animate: true,
  
                  ): Column(
  
         children: [
  
           Padding(
  
                            padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
  
                            child: Row(
  
                              mainAxisSize: MainAxisSize.max,
  
                              children: [
  
                                Text(
  
                                  'Price Breakdown',
  
                                  style: AppTheme.of(context).bodyText2,
  
                                ),
  
                              ],
  
                            ),
  
                          ),
  
                            Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Base Price',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            Text(
  
                              'Rs. $fPrice',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ),
  
                          ],
  
                        ),
  
                      ),
  
                        Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Total Quantity',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            Text(
  
                              '$fquant',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ),
  
                          ],
  
                        ),
  
                      ),
  
                      Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Delivery Price',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            (fquant! <= 2) ?
  
                             Text(
  
                              'Rs. 300',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ) : (fquant! <= 6) ? 
  
                            Text(
  
                              'Rs. 500',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ) : Text(
  
                              'Rs. 800',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ),
  
                          ],
  
                        ),
  
                      ),
  
                      Divider(),
  
                      Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Total Amount',
  
                              style: AppTheme.of(context).title3,
  
                            ),
  
                            Text(
  
                              'Rs. ${fPrice! + del!}',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ),
  
                          ],
  
                        ),
  
                      ),
   Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Payment Type:',
  
                              style: AppTheme.of(context).title3,
  
                            ),
                            DropdownButton(
      value: selectedValue,
      dropdownColor: Colors.green,
      onChanged: (String? newValue){
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: dropdownItems
      ),
  
                          ],
  
                        ),
  
                      ),
  ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(88, 182, 148, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: _empty ? () {}: () {
          setState(() {
            _isLoading = true;
          });
          // Validate returns true if the form is valid, or false otherwise.
          placeOrder();
        },
        child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
  
         ],
  
       ),
  
                    
  
  ],
  
  
  
  
  
  
  
  ),
)),


    );
  }
  bool _isLoading = false;
  String selectedValue = "Cash on Delivery";
List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Cash on Delivery"),value: "Cash on Delivery"),
    DropdownMenuItem(child: Text("Online Payment"),value: "Online Payment"),
    
  ];
  return menuItems;
}
  Future<void> decreaseItem(String id) async {
CartDatabaseHelper cdb = CartDatabaseHelper();
 await cdb.initDatabase();
 setState(() {
   _load = true;
 });
 await cdb.decreaseCartItemQuantity(id);
  setState(() {
    getCartProducts();
   _load = false;
 });
  }
   Future<void> increaseItem(String id) async {
CartDatabaseHelper cdb = CartDatabaseHelper();
 await cdb.initDatabase();
 setState(() {
   _load = true;
 });
 await cdb.increaseCartItemQuantity(id);
  setState(() {
    getCartProducts();
   _load = false;
 });
  }
     Future<void> deleteItem(String id) async {
CartDatabaseHelper cdb = CartDatabaseHelper();
 await cdb.initDatabase();
 setState(() {
   _load = true;
 });
 await cdb.deleteCartItem(id);
  setState(() {
    getCartProducts();
   _load = false;
 });
  }


  getDetails() async {
    setState(() {
  
  _loadP = false;
 
});
    CartDatabaseHelper cdb = CartDatabaseHelper();
 await cdb.initDatabase();
  DatabaseHelper dvh = DatabaseHelper();
  await dvh.initDatabase();

  List<CartItem> cartdI = [];
  List<Product> productss = [];

      cartdI = await cdb.getCartItems();
if(cartI.isNotEmpty){
  DatabaseHelper dvh = DatabaseHelper();
  await dvh.initDatabase();

List<String> productIds = cartdI.map((item) => item.productId).toList();
    // Fetch related products from the Products table using productIds
    productss = await dvh.fetchProductsFromDatabase(productIds);
    int p = 0;
int q = 0;
    for(int i=0;i<productIds.length; i++){
    //  print(cartdI[i].quantity); 
    //       print(productss[i].price); 

      fPrice = fPrice! + cartdI[i].quantity * productss[i].price;
fquant = fquant! + cartdI[i].quantity;

setState(() {
  fPrice;
  fquant;
  (fquant! <=2) ? del = 300: (fquant! <=6) ? del = 500: del = 800;
 
});
    }
setState(() {
  _loadP = false;
});


  }
  else{
    setState(() {
  _loadP = false;
  _empty=true;
});
  }
}



Future<void> placeOrder() async {
  final dio = Dio(); // Create a Dio instance
  final apiUrl = '${Constants.useruri}/placeorders'; // Replace with your actual API URL
SharedPreferences prefs = await SharedPreferences.getInstance();
String? uid = prefs.getString('id');

 String? devices = prefs.getString('playerId');

  try {
    // Prepare request data
    final requestData = {
      'userId': uid,
      'products': ProductIDs, // Replace with actual product IDs
      'quantity': quatttt, // Replace with corresponding quantities
      'addressId': uid, // Replace with actual address ID
      'paymentType': selectedValue,
      'devices': devices, // Replace with payment type
    };

    // Make the POST request
    final response = await dio.post(apiUrl, data: requestData);

    if (response.statusCode == 200) {
      showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
  title: Text("Success"),
  titleTextStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,fontSize: 20),
    actionsOverflowButtonSpacing: 20,
    actions: [
      ElevatedButton(onPressed: () async {
         setState(() {
            _isLoading = false;
          });
          CartDatabaseHelper cdb = CartDatabaseHelper();
          await cdb.initDatabase();
          await cdb.clearCart();
           print('Order placed successfully: ${response.data}');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
      }, child: Text("Back")),
     
    ],
    content: Text(response.data['message']),
);
    });
     
     
    } else {
      showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
  title: Text("Failed"),
  
  titleTextStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,fontSize: 20),
    actionsOverflowButtonSpacing: 20,
    actions: [
      ElevatedButton(onPressed: (){
         setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
      }, child: Text("Back")),
     
    ],
    content: Text(response.data['error']),
);
    });
      print('Failed to place order: ${response.statusCode}');
      setState(() {
            _isLoading = false;
          });
    }
  } catch (error) {
    
    print('An error occurred: $error');
      showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
  title: Text("Failed"),
  
  titleTextStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,fontSize: 20),
    actionsOverflowButtonSpacing: 20,
    actions: [
      ElevatedButton(onPressed: (){
         setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
      }, child: Text("Back")),
     
    ],
    content: Text(error.toString()),
);
    });
setState(() {
            _isLoading = false;
          });
  }
}

}
