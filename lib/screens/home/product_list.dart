// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../exports.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
 bool _loadProd = true;
  List<Product> products = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  getProducts() async {
    await databaseHelper.initDatabase();
    await databaseHelper.insertOrUpdateProducts(products);
products = await databaseHelper.getProducts();
  setState(() {
    _loadProd = false;
  });
  }

  SortOption sortOption = SortOption.HighToLow;
void _sortData() {
  setState(() {
    if (sortOption == SortOption.HighToLow) {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else {
      products.sort((a, b) => a.price.compareTo(b.price));
    }
  });
}
    @override
    void initState() {
      getProducts(); 
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){         
                 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SearchScreen()));
},icon: Icon(Icons.search, size: 30, color:  Colors.black87),),
          )
        ],
        title: Center(child: const Text('All Products   ' ,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)),
      ),
      body: Padding(
        
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        // implement GridView.builder
        child: _loadProd ? ShimmerWidget(hei: 30):  Column(
          children: [
            Row(
              children: [
                Text("Sort: ", style:AppTheme.of(context).subtitle2 ,),
                DropdownButton<SortOption>(
  value: sortOption,
  items: [
    DropdownMenuItem(
      value: SortOption.HighToLow,
      child: Text('Price: High to Low'),
    ),
    DropdownMenuItem(
      value: SortOption.LowToHigh,
      child: Text('Price: Low to High'),
    ),
  ],
  onChanged: (newValue) {
    setState(() {
      sortOption = newValue!;
      _sortData();
    });
  },
),
              ],
            ),
            SizedBox(height: 5,),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
        shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 4/5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: products.length,
                  itemBuilder: (BuildContext ctx, index) {
                    // return SizedBox(
                    //   height: 250,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         color: Colors.amber,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                             
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Image(image: CachedNetworkImageProvider(products[index].image[0]))
                    //       ),
                    //       Text(products[index].name),
                    //     ],
                    //   ),
                    // );
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetail(product: products[index])));
                      },
                      child: FadeInLeftBig(
                        child: Container(
                        //width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color(0x3600000F),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          // child: Image.network(
                          //   products[index].image,
                          //   width: 100,
                          //   height: 100,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image(image: CachedNetworkImageProvider(products[index].image[0]), height: 100, width: 100, fit: BoxFit.cover,),
                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                        Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(5, 8, 10, 0),
                                      child: Text(
                                        
                                        products[index].name,
                                        overflow: TextOverflow.clip,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                        style: AppTheme.of(context).bodyText1,
                                        softWrap: true,
                                        maxLines: 2,
                                      ),
                                    ),
                        ),
                                      ],
                                    ),
                                          ),
                                          
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            'Rs. ${products[index].price}',
                             overflow: TextOverflow.clip,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                        style: AppTheme.of(context).bodyText2,
                                        softWrap: true,
                                        maxLines: 2,
                          ),
                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                                          ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
