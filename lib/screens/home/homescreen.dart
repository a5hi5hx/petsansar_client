// ignore_for_file: prefer_const_constructors
// Import package
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
   List<ScrollImg> images = [];
   List<Product> products =[];
   List<Categories> categ = [];
   bool _cateLoad = true;
   bool _isLoading = false;
   bool _prodLoad=true;
   int count = 0;
     int _current = 0;
bool _sliderLoad = true;
   CarouselController _controller = CarouselController();
//  List<Widget> imageSliders = [];

String? name, phone, address0,address1, email, image, id ,pincode;

getDetails() async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
  name = prefs.getString("name");
  phone = prefs.getString("phone");
  address0= 'Hemja';
  address1 = 'Pokhara';
  pincode = '33700';
  email = prefs.getString("email");
  image = prefs.getString("image")?? '';
  id = prefs.getString("id");
}
 //int count = 0;
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
Future<void> fetchPData() async {
  products = await getProducts();
  DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.initDatabase();
    await databaseHelper.insertOrUpdateProducts(products);
   
  setState(() {
 // product = prod;
  _prodLoad=false;
});
  // Use the fetched products data as needed
}
fetchcategories() async {
try{
    final apiUrl = '${Constants.adminuri}/viewcategories'; // Replace with your API URL
Dio dio = Dio();
  Response response = await dio.get(apiUrl);
  if (response.statusCode == 200) {
List<dynamic> jsonList = response.data; // No need for json.decode()
      List<Categories> cat = jsonList.map((json) => Categories.fromJson(json)).toList();
setState(() {
  categ = cat;
  _cateLoad=false;
});
  }
  else{
 setState(() {
  _cateLoad=true;
});
  }
}catch(e){
  setState(() {
  _cateLoad=true;
});
}
}

fetchImagesFromApi() async {

  try {
    final apiUrl = '${Constants.adminuri}/viewScroll'; // Replace with your API URL

    Dio dio = Dio();
    Response response = await dio.get(apiUrl);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data; // No need for json.decode()
      List<ScrollImg> image = jsonList.map((json) => ScrollImg.fromJson(json)).toList();
      
    setState(() {
      images = image;
      _sliderLoad = false;
// imageSliders = image
//     .map((item) => Container(
//           child: Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     Image.network(item.pictures, fit: BoxFit.cover, width: 1000.0),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(200, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0)
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: Text(
//                           'No. ${image.indexOf(item)} image',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();

    });
    } else {
      throw Exception('Failed to fetch images from API');
    }
  } catch (e) {
    throw Exception('Failed to fetch images from API: $e');
  }
}
//   String? name='', id='', image='', token='', phone='', email='';
//   getData() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
// name = prefs.getString('name');
// id = prefs.getString('id');
// image = prefs.getString('imgUser');
// token = prefs.getString('x-auth-token');
// phone = prefs.getString('phone');
// email = prefs.getString('email');
//   }
 Future<List<Product>>getProducts() async {
try{
    final apiUrl = '${Constants.adminuri}/availableP'; // Replace with your API URL
Dio dio = Dio();
  Response response = await dio.get(apiUrl);
  if (response.statusCode == 200) {
 List<dynamic> jsonList = response.data;
      List<Product> products = jsonList.map((json) => Product.fromJson(json)).toList();
    // 
     // Save products to the local database
    
 return products;
  }
  else{
 setState(() {
  _prodLoad=true;
});
return [];
  }
}catch(e){
  setState(() {
  _prodLoad=true;
});
return [];
}
 }

  
deletedb() async {
    CartDatabaseHelper cdb = CartDatabaseHelper();
  await cdb.initDatabase();
  List<CartItem> carti = await cdb.getCartItems();
   // print('123 $carti');

  cdb.dropCartDatabase();

}

Future<void> onRefresh() async {
  setState(() {
      _isLoading = true;
    });
    getDetails();
    getCartCount();
  fetchImagesFromApi();
  fetchPData();
  fetchcategories();
  setState(() {
      _isLoading = false;
    });
}

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
void initState()   {
 //deletedb();
       //CartProvider cartProvider = context.read<CartProvider>();
// Add the new item to the cart
     //cartProvider.addToCart(newItem);
 
  //  await getData();
 onRefresh();
  // fetchImagesFromApi();
  // fetchPData();
  // fetchcategories();
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//   ));   
//    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  //  @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override void didChangeMetrics() {
  //    SystemChrome.restoreSystemUIOverlays();
  // }

  @override
  Widget build(BuildContext context) {
    //CartDatabaseHelper cdb = CartDatabaseHelper();
     final cartProvider = Provider.of<CartProvider>(context);
  //  final cartItems = cdb.cartCount();
   // loadCart(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    // final cartItems = cartProvider.cartItems;
    return Scaffold(
      
      extendBodyBehindAppBar: false,

bottomNavigationBar: BottomNavBar(count: count,),
backgroundColor: Colors.white,
  // backgroundColor: Color(0xffdedede),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: onRefresh,
        child: _isLoading ? ShimmerWidget(hei: 40):  SafeArea(
          child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           physics : BouncingScrollPhysics(),
           padding: EdgeInsets.all(6),
        
            child: Column(
           mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
            Container(
              height: 100,
             // decoration: BoxDecoration(color: Colors.amber),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(
        padding: const EdgeInsets.fromLTRB(15,15,10,5),
        child: Text('Location', style: TextStyle(fontSize: 20, color: Colors.black54),),
          ),
          Padding(
        padding: const EdgeInsets.fromLTRB(25,8,10,5),
        child: GestureDetector(
          onTap: () {
            print('hello');
          },
          child: FadeIn(
            child: Row(
              children: [
                Icon(Icons.location_on, color: Color.fromRGBO(88, 182, 148, 1)),
                Text(' $address0, $pincode', style: TextStyle(fontSize: 20, color: Colors.black54),),
              ],
            ),
          ),
        ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(35.0),
        child:   IconButton(onPressed: (){     
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
      
      },icon: Icon(Icons.search, size: 30, color:  Colors.black87),)
      ),
      
                ],
              )
            ),
      
      CarouselSlider(
              items: images.map((img)  {
                return Card(
                 child: _sliderLoad ? ShimmerWidget(hei: 30) : Image(image: CachedNetworkImageProvider(img.pictures), fit: BoxFit.cover, )
                  //child: Image.network(img.pictures, fit: BoxFit.cover,),
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  aspectRatio: 4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
             
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
      
      Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Categories', style: TextStyle(fontSize: 22),),
            TextButton(onPressed: () {}, child: Text('View All', style:TextStyle(color: Color.fromRGBO(88, 182, 148, 1), fontSize: 16)))
          ],
        ),
        SizedBox(height: 15,),
          Container(
                          height: 150,
                          child: _cateLoad ? ShimmerWidget(hei: 40): ListView.builder(
                            physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: categ.length,
                // list item builder
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoricalProducts(category: categ[index])));               },
                    child: FadeInDown(
                      child: Container(
                        key: ValueKey(categ[index]),
                        margin: const EdgeInsets.all(15),
                        color: Colors.transparent,
                        width: 100,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 75, child: Image(image: CachedNetworkImageProvider(categ[index].image), fit: BoxFit.cover,),),
                            Text(
                              categ[index].name,
                              style: AppTheme.of(context).bodyText1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                        ),
                        SizedBox(height: 5,),
                        
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Products', style: TextStyle(fontSize: 22),),
            TextButton(onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllProducts()));
      
            }, child: Text('View All', style:TextStyle(color: Color.fromRGBO(88, 182, 148, 1), fontSize: 16)))
          ],
        ),
        Container(
                          height: 150,
                          child: _cateLoad ? ShimmerWidget(hei: 40) :  ListView.builder(
                            shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categ.length+2,
                // list item builder
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      // print(products[index].id);
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetail(product: products[index])));
                    },
                    child: FadeInRight(
                      child: Container(
                        //key: ValueKey(categ[index]),
                        margin: const EdgeInsets.all(15),
                        color: Colors.transparent,
                        width: 150,
                        
                        alignment: Alignment.center,
                        
                        child: Column(
                          children: [
                            SizedBox(height: 57, child: Image(image: CachedNetworkImageProvider(products[index].image[0]), fit: BoxFit.contain,),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].name,
                                  style: AppTheme.of(context).bodyText1,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                          
                                ),
                                Text(
                                  'Rs. ${products[index].price}',
                                  style: AppTheme.of(context).bodyText2,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                        ),
      
          ],
        ),
      )
              ], 
            ),
          ),
        ),
        
      ),
    );
  }
  

 
}
