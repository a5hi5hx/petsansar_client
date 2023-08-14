import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';
import 'dart:math';
class ProductDetail extends StatefulWidget {
  Product product; 
   ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
   final scaffoldKey = GlobalKey<ScaffoldState>();
  int? countControllerValue;
   CarouselController _controller = CarouselController();

  @override
  void initState() {
     
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Random rnd = Random();
   
    return Scaffold(
      key: scaffoldKey,
appBar: AppBar(
        backgroundColor: AppTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
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
        title: Text(
         '',
          style: AppTheme.of(context).subtitle2.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF151B1E),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
        ),
        // actions: [
        //   BlocBuilder<CartBloc, CartState>(builder: (_, cartState) {
        //     List<Product> cartItem = cartState.cartItem;
        //     return Padding(
        //       padding: EdgeInsetsDirectional.fromSTEB(0, 8, 24, 0),
        //       child: Badge(
        //         badgeContent: Text(
        //           '${cartItem.length}',
        //           style: AppTheme.of(context).bodyText1.override(
        //                 fontFamily: 'Poppins',
        //                 color: Colors.white,
        //               ),
        //         ),
        //         showBadge: true,
        //         shape: BadgeShape.circle,
        //         badgeColor: AppTheme.of(context).primaryColor,
        //         elevation: 4,
        //         padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        //         position: BadgePosition.topEnd(),
        //         animationType: BadgeAnimationType.scale,
        //         toAnimate: true,
        //         child: IconButton(
        //           icon: Icon(
        //             Icons.shopping_cart_outlined,
        //             color: AppTheme.of(context).secondaryText,
        //             size: 30,
        //           ),
        //           onPressed: () {
        //             // Navigator.push(
        //             //   context,
        //             //   MaterialPageRoute(
        //             //     builder: (context) => CheckoutWidget(),
        //             //   ),
        //             // );
        //           },
        //         ),
        //       ),
        //     );
        //   }),
        // ],
        centerTitle: true,
        elevation: 0,
      ),
backgroundColor: AppTheme.of(context).secondaryBackground,
body: Column(
  mainAxisSize: MainAxisSize.max,
  children: [
Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: Container(
                      height: 300,
                      child: CarouselSlider(
                                items: widget.product.image.map((img)  {
                                  return  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image(image: CachedNetworkImageProvider(img), fit: BoxFit.cover,),
                                  );
                                }).toList(),
                                carouselController: _controller,
                                options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: false,
                                    aspectRatio: 16/9,
                                    ),
                              ),
                    ),
                      ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Text(
                      widget.product.name,
                      style: AppTheme.of(context).title1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          '\Rs. ${widget.product.price}',
                          textAlign: TextAlign.start,
                          style: AppTheme.of(context).subtitle1,
                        ),
                        const Text(' '),
                        RichText(text: TextSpan( text: '\Rs. ${widget.product.price + (0.15 * widget.product.price)}', // Replace with your actual price
                  style: AppTheme.of(context).offer,))
                       
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: Text(
                      widget.product.description,
                      style: AppTheme.of(context).bodyText2,
                    ),
                  ),
                                          SizedBox(height: 15,),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Specifications',
                          style: AppTheme.of(context).title3,
                        ),
                                                SizedBox(height: 10,),

                        Row(
                          children: [
                             Text(
                          'Brand: ',
                          style: AppTheme.of(context).bodyText1,
                        ),
                         Text(
                          widget.product.brand,
                          style: AppTheme.of(context).bodyText2,
                        ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                             Text(
                          'Availability: ',
                          style: AppTheme.of(context).bodyText1,
                        ),
                        widget.product.quantity > 10 ? Text(
                           'In Stock' ,
                          style: AppTheme.of(context).bodyText2,
                        ) : Text(
                           'Low Stock' ,
                          style: AppTheme.of(context).offer2,
                        ) ,
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                             Text(
                          'SKU: ',
                          style: AppTheme.of(context).bodyText1,
                        ),
                         Text(
                          widget.product.id,
                          style: AppTheme.of(context).bodyText2,
                        ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: addtocartButton()
                  ),
                ],
              ),
            ),
          ),
  ],
),
    );
  }

   Widget addtocartButton() {
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
        onPressed:(widget.product.quantity == 0) ? null: () async {
          CartProvider cartProvider = context.read<CartProvider>();
CartItem newItem = CartItem(
              productId: widget.product.id,
              name: widget.product.name,
              quantity: 1,
              price: widget.product.price,
            );
// Add the new item to the cart
     cartProvider.addToCart(newItem);
          // Validate returns true if the form is valid, or false otherwise.
         final cartDb = CartDatabaseHelper();
          await cartDb.initDatabase();
          try{


              await cartDb.addToCart(widget.product.id, widget.product.name, 1, widget.product.price);
              //final cartProvider = Provider.of<CartProvider>(context);
              
         




//print(cartDb.getCartItems());
_showS(context, 'Added To Cart');
Dio dio = Dio();
SharedPreferences prefs = await SharedPreferences.getInstance();
String? id =  prefs.getString('id');
dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(
        '${Constants.useruri}/cart/add-to-cart',
        data: {
  "userId": id, "productId":widget.product.id, "quantity": 1
}
      );              //_show(context, 'Added To Cart');
           if(response.statusCode == 200 || response.statusCode == 201)   {              print("added");
 }
                }catch(e){
                  //print(e);
                }        },
        child: (widget.product.quantity == 0) ? Text('Out Of Stock', style: TextStyle(color: Colors.white, fontSize: 27),) : Text('Add To Cart', style: TextStyle(color: Colors.white, fontSize: 27),),
      ),
    );
  }

  void _show(BuildContext ctx , String text) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Color.fromRGBO(88, 182, 148, 1),
        context: ctx,
        builder: (ctx) => Container(
              width: MediaQuery.of(ctx).size.width,
              height: 30,
              color: Colors.white54,
              alignment: Alignment.center,
              child:  Text(text),
            ));
  }
  void _showS(BuildContext ctx , String text) {
   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                      content:  Text(text, style: AppTheme.of(context).bodyText1,),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Color.fromRGBO(88, 182, 148, 1),
                      action: SnackBarAction(
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        label: 'Dismiss',
                        onPressed: () {
                          // Hide the snackbar before its duration ends
                          // ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                          ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                        },
                      ),
                    ));
  }
}