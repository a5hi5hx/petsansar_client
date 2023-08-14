// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:badges/badges.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  int count;
   BottomNavBar({super.key, required this.count});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}


class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
 
@override
void initState() {
  _selectedIndex = 0;
  super.initState();
}

void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
       setState(() {
      _selectedIndex = 0;
    });
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
        break;
        case 1:
         setState(() {
      _selectedIndex = 1;
    });
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllProducts()));
break;
 case 2:
  setState(() {
      _selectedIndex = 2;
    });
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
break;
 case 3:
  setState(() {
      _selectedIndex = 3;
    });
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CheckoutWidget()));
break;
 case 4:
  setState(() {
      _selectedIndex = 4;
    });
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfilePage()));
break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    return Container(
  height: 70,
  width: MediaQuery.of(context).size.width,
  child: ClipRRect(
  borderRadius: const BorderRadius.only(
    topRight: Radius.circular(30),
    topLeft: Radius.circular(30),
  ),
  child: BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    //add background color
    backgroundColor:Colors.white,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 30,),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(FlutterIcons.package_variant_mco, size: 30,),
        label: 'Products',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search, size: 30,),
        label: 'Search',
      ),
 BottomNavigationBarItem(
        label: 'Cart',
        icon: Stack(
          children: <Widget>[
            Icon(Icons.shopping_cart, size: 30,),
            Positioned(  // draw a red marble
              top: 9.0,
              right: 0.0,
              child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Color.fromRGBO(88, 182, 148, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: BoxConstraints(
            minWidth: 12,
            minHeight: 12,
          ),
          child: Text(
            '${widget.count}' ,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
            )
          ]
        ),
      ),
       BottomNavigationBarItem(
        icon: Icon(FontAwesome.user, size: 30,),
        label: 'Profile',
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Color.fromRGBO(88, 182, 148, 1),
    unselectedItemColor: Colors.black45,
    onTap: _onItemTapped,
  ),
),
);
  }
}