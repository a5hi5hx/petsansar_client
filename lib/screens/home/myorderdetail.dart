// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';


class OrderDetails extends StatefulWidget {
  final Order order;
   const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
 late Order orders;
 bool _load = true;
  @override
  void initState() {
orders = widget.order;
_load = false;
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
         Navigator.of(context).pop();
        },),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.of(context).secondaryBackground,
title: Center(
      child: Padding(
      
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
      
        child: Text('My Orders  ', style: AppTheme.of(context).title1,),
      
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
  
   _load ? ShimmerWidget(hei: 30) :  ListView.builder(
  
      padding: EdgeInsets.zero,
  
      primary: false,
  
      shrinkWrap: true,
  
      scrollDirection: Axis.vertical,
  
      itemCount: orders.products.length,
  
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
  
                    tag: 'CrImage',
  
                    transitionOnUserGestures: true,
  
                    child: ClipRRect(
  
                      borderRadius: BorderRadius.circular(12),
  
                      child: Image.network(
  
                       orders.products[index].image[0],
  
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
  
                      width:250,
  
                      child: Column(
  
                        mainAxisSize: MainAxisSize.max,
  
                        mainAxisAlignment: MainAxisAlignment.center,
  
                        crossAxisAlignment: CrossAxisAlignment.start,
  
                        children: [
  
                          GestureDetector(
  
                            onTap:  () {
  
                              //Navigator.of(context).pop();
  
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetail(product: orders.products[index])));
  
                            },
  
                            child: Padding(
  
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
  
                              child: Text(
  
                                orders.products[index].name,
  
                                overflow: TextOverflow.clip,
  
                                maxLines: 2,
  
                                style: AppTheme.of(context).subtitle2.override(
  
                                      fontFamily: 'Poppins',
  
                                      color: AppTheme.of(context).primaryText,
  
                                    ),
  
                              ),
  
                            ),
  
                          ),
  
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
  
                                'Rs. ${orders.products[index].price}',
  
                                style: AppTheme.of(context).bodyText1,
  
                              ),
                               Text(
  
                                ' Quantity: ${orders.quantity[index]}',
  
                                style: AppTheme.of(context).bodyText2,
  
                              ),
                              
                            ],
                          ),
  
                          Padding(
  
                            padding: EdgeInsetsDirectional.all(4),
  
                            child: Flex(
  mainAxisAlignment: MainAxisAlignment.end,
                              direction: Axis.horizontal,
  
                              children: 
  
                                [
                                  Row(
  
                                  
  
                                  children: [
  
                                      Text(
  
                                      'Total Price: Rs. ',
  
                                      style: AppTheme.of(context).bodyText2,
  
                                    ),
                                    Text(
  
                                      '${orders.products[index].price * orders.quantity[index]}',
  
                                      style: AppTheme.of(context).bodyText1,
  
                                    ),
  
                                  ],
  
                                ),
  
                              ],
  
                            ),
  
                          ),
  
                        ],
  
                      ),
  
                    ),
  
                  ),
  
              
  
                ],
  
              ),
  
            ),
  
          ),
  
        );
  
      }),
  
  SizedBox(height: 30,),   
   _load ? ShimmerWidget(hei: 30) : Column(
  
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
  
                              'Rs. ${(orders.totalPrice- orders.deliveryFee)}',
  
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
  
                              'Delivery Fee',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            Text(
  
                              'Rs. ${orders.deliveryFee}',
  
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
  
                              'Payment Type: ',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                           
  
                             Text(
  
                              orders.paymentType,
  
                              style: AppTheme.of(context).subtitle1,
  
                            )
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
  
                              'Rs. ${orders.totalPrice}',
  
                              style: AppTheme.of(context).subtitle1,
  
                            ),
  
                          ],
  
                        ),
  
                      ),
SizedBox(height: 10,),
                      (orders.status == 'Delivered' || orders.status== 'Shipped') ? Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Courier Partner: ',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            Text(
  
                              'NP-Aramex',
  
                              style: AppTheme.of(context).bodyText1,
  
                            ),
  
                          ],
  
                        ),
  
                      ) : Row(),
                       (orders.status == 'Delivered' || orders.status== 'Shipped') ? Padding(
  
                        padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
  
                        child: Row(
  
                          mainAxisSize: MainAxisSize.max,
  
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                          children: [
  
                            Text(
  
                              'Tracking Number: ',
  
                              style: AppTheme.of(context).subtitle2,
  
                            ),
  
                            GestureDetector(
                              onTap: _launchUrl,
                              child: Text(
                              
                                '45415009135',
                              
                                style: AppTheme.of(context).subtitle1,
                              
                              ),
                            ),
  
                          ],
  
                        ),
  
                      ) : Row(),
   SizedBox(height: 40,),
  ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(88, 182, 148, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed:  (orders.status != 'Shipped' || orders.status != 'Delivered') ? () {
          
          // Cancel order Here
          //placeOrder();
        } : () {},
        child: (orders.status == 'Shipped') ?  const Text('Can\'t Process Order Here Now', style: TextStyle(color: Colors.white, fontSize: 27)) : orders.status == 'Delivered' ? const Text('Delivered', style: TextStyle(color: Colors.white, fontSize: 27),) :const Text('Cancel Order', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
         ],
       ),
  ],
  
  
  
  
  
  
  
  ),
)),


    );
  }
final Uri _url = Uri.parse('https://tracker.lel.asia/tracker?trackingNumber=45415009135&lang=en-US');

  Future<void> _launchUrl() async {
    await launchUrl(_url);
 
  }
}