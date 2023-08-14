// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Color color = Colors.red;
 bool _loadProd = true;
  List<Order> orders = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
 Future<List<Order>> fetchOrders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? uid = pref.getString('id');
  final dio = Dio();
  final response = await dio.get('${Constants.useruri}/viewOrder/$uid'); // Replace with your API endpoint
 List<Order> orderJsonList = [];
  if (response.statusCode == 200) {
    // orderJsonList = response.data;
      List<dynamic> jsonList = response.data; // No need for json.decode()
     // List<ScrollImg> image = jsonList.map((json) => ScrollImg.fromJson(json)).toList();
      orderJsonList = jsonList.map((json) => Order.fromJson(json)).toList();
    return orderJsonList;
  } else {
    return orderJsonList;
  }
}

  //SortOption sortOption = SortOption.HighToLow;
// void _sortData() {
//   setState(() {
//     if (sortOption == SortOption.HighToLow) {
//       products.sort((a, b) => b.price.compareTo(a.price));
//     } else {
//       products.sort((a, b) => a.price.compareTo(b.price));
//     }
//   });
// }
Future<void> fetchdata() async {
  setState(() {
    _loadProd = true;
  });
  orders = await fetchOrders();
  
  setState(() {
    _loadProd = false;
  });
}
    @override
    void initState() {
      fetchdata(); 
      super.initState();
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,

// bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(  
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: true,
        
        elevation: 0,
       centerTitle: true,
        title: const Text('My Orders' ,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
      ),
      body: RefreshIndicator(
        onRefresh: fetchdata,
        child: Padding(
          
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          // implement GridView.builder
          child: _loadProd ? ShimmerWidget(hei: 30):  Column(
            children: [
              SizedBox(height: 5,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
          shrinkWrap: true,
                    // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    //     maxCrossAxisExtent: 200,
                    //     childAspectRatio: 4/5,
                    //     crossAxisSpacing: 20,
                    //     mainAxisSpacing: 20),
                    itemCount: orders.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          print(orders[index].products[0].name);
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrderDetails(order: orders[index])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10,10,5),
                          child: FadeInLeftBig(
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                          title: Text('Order No: ${(orders[index].id).substring(18)}', style: AppTheme.of(context).bodyText1,),
                          subtitle: Row(
                            children: [
                              Text('Status: '
                              ),
                              // "Pending", "Processing", "Shipped", "Delivered"
                              Text((orders[index].status),style: TextStyle(
                                 color: orders[index].status == 'Pending' ? Colors.red : orders[index].status == 'Processing' ? Colors.orange : orders[index].status == 'Shipped' ? Colors.blue : Colors.green,
                                 
                                 ), )
                            ],
                          ),
                          leading: CircleAvatar(child: Text((index+1).toString()),),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
