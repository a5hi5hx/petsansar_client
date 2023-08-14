import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:lottie/lottie.dart';

class CategoricalProducts extends StatefulWidget {
  final Categories category;
  const CategoricalProducts({super.key, required this.category});

  @override
  State<CategoricalProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<CategoricalProducts> {
 bool _loadProd = true;
 bool _isEmpty = true;
ScrollController _controller = ScrollController();
  List<Product> products = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  getProducts() async {
    await databaseHelper.initDatabase();
    await databaseHelper.insertOrUpdateProducts(products);
products = await databaseHelper.getProductsByCategory(widget.category.id);
if(products.isEmpty){
setState(() {
  _isEmpty=true;
});
}
else{
  setState(() {
    _isEmpty=false;
  });
}
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
            child: IconButton(onPressed: (){print('hello');},icon: Icon(Icons.search, size: 30, color:  Colors.black87),),
          )
        ],
        title: Center(child:  Text(widget.category.name ,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
                                    Padding(padding:  const EdgeInsets.fromLTRB(10, 20, 10, 10), child: Text(widget.category.description, style:AppTheme.of(context).bodyText2 ,),),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              // implement GridView.builder
              child: _loadProd ? ShimmerWidget(hei: 30)  : _isEmpty ?  Lottie.network(
                  "https://assets10.lottiefiles.com/packages/lf20_mxuufmel.json",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ) : Expanded(
                  
                  child: GridView.builder(
                    controller: _controller,
                       scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
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
                        child: FadeInLeft(
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
            ),
          ],
        ),
      ),
    );
  }
}
