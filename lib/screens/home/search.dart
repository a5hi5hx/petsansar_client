import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:lottie/lottie.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
enum SortOption {
  HighToLow,
  LowToHigh,
}
class _SearchScreenState extends State<SearchScreen> {
   ScrollController _controller = ScrollController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  String searchQuery = 'Search Desired Products';
  List<Product> products = [];
 bool _isEmpty = false;
 bool _loadProd = false;

  void _onSearchButtonPressed() async {
     setState(() {
    _loadProd = true;
  });
  await databaseHelper.initDatabase();
    List<Product> results = await databaseHelper.searchProducts(searchQuery);
    setState(() {
      products = results;
    });
    if(results.isEmpty){
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
    super.initState();
    //_loadSearchHistory(); // Load the search history when the screen initializes
  }
  List<String> searchHistory = []; // To store the search history

  // Future<void> _loadSearchHistory() async {
  //    await sdbHelper.initDatabase();
  //   List<String> history = await sdbHelper.getSearchHistory();
  //   setState(() {
  //     searchHistory = history;
  //   });
  // }
  //  Future<void> _saveSearchHistory() async {
  //    await sdbHelper.initDatabase();
  //   if (searchQuery.isNotEmpty) {
  //     await sdbHelper.insertSearchHistory(searchQuery);
  //    // _loadSearchHistory();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//  bottomNavigationBar: searchHistory.isNotEmpty
//           ? BottomAppBar(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DropdownButton<String>(
//                   hint: Text('Search history'),
//                   value: searchQuery.isNotEmpty ? 'search' : searchHistory[0],
//                   items: searchHistory
//                       .map((query) => DropdownMenuItem(
//                             value: query,
//                             child: Text(query),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value ?? '';
//                     });
//                   },
//                 ),
//               ),
//             )
//           : null,

      backgroundColor: Colors.white,
           extendBodyBehindAppBar: false,

// bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(child:  Text('Search: $searchQuery' ,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,)),
      ),

     body: SingleChildScrollView(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding:  const EdgeInsets.fromLTRB(20, 20, 10, 10), child: Column(
              children: [
                Text("Search", style:AppTheme.of(context).title3 ,),
               const SizedBox(height: 5,),
               TextField(
               
      onChanged: (value) => setState(() {
searchQuery = value;
_onSearchButtonPressed();
      } ),
                decoration:  InputDecoration(
                   focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(88, 182, 148, 1),
                  ),
                ),
                    labelText: 'Search', suffixIcon: IconButton(onPressed: () {
                _onSearchButtonPressed();
                //_saveSearchHistory(); // Save the search history when the search button is pressed
              }, icon: Icon(Icons.search)) ),
              ),
              const SizedBox(
                height: 20,
              ),
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
     
                //search Field
              ],
            ),),
     
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: _loadProd ? ShimmerWidget(hei: 30)  : _isEmpty ?  Lottie.network(
                  "https://assets10.lottiefiles.com/packages/lf20_mxuufmel.json",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ) : Expanded(
                  child: GridView.builder(
                       scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _controller,
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
                        child: FadeIn(
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