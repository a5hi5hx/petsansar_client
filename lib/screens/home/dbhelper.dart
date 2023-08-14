import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../exports.dart';

class DatabaseHelper {
  late Database _database;

  DatabaseHelper() {
    initDatabase();
  }

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  //factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  //late Database _database;
  

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'petsansar.db'),
      onCreate: (db, version) async {
        // Create tables here (if needed)
        await db.execute('''
          CREATE TABLE products(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            price INTEGER,
            category TEXT,
            brand TEXT,
            image TEXT,
            quantity INTEGER,
            discount INTEGER,
            keywords TEXT
          )
        ''');
        //  await db.execute('''
        //   CREATE TABLE search(
        //     query TEXT PRIMARY KEY
        //   )
        // ''');
      },
      version: 1,
    );
  }

   Future<void> insertOrUpdateProducts(List<Product> products) async {
    final batch = _database.batch();
    for (var product in products) {
      batch.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<List<Product>> getProducts() async {
    final List<Map<String, dynamic>> maps = await _database.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'products',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<List<Product>> searchProducts(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'products',
      where: 'name LIKE ? OR keywords LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // Future<void> insertSearchHistory(String query) async {
  //   await _database.insert(
  //     'search',
  //     {'query': query},
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<List<String>> getSearchHistory() async {
  //   final List<Map<String, dynamic>> maps = await _database.query('search');
  //   return List.generate(maps.length, (i) => maps[i]['query'] as String);
  // }
Future<List<Product>> fetchProductsFromDatabase(List<String> productIds) async {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();

  List<Product> products = await databaseHelper.getProducts();

  List<Product> fetchedProducts = [];

  for (String productId in productIds) {
    Product? product = products.firstWhere((p) => p.id == productId);
    if (product != null) {
      fetchedProducts.add(product);
    }
  }

  return fetchedProducts;
}

  
}


// class SearchDatabaseHelper {
//   static final SearchDatabaseHelper _instance = SearchDatabaseHelper._internal();

//   factory SearchDatabaseHelper() => _instance;

//   SearchDatabaseHelper._internal();

//   late Database _database;

//   Future<void> initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'search.db'),
//       onCreate: (db, version) async {
//         // Create tables here (if needed)
//          await db.execute('''
//           CREATE TABLE search(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             query TEXT
//           )
//         ''');
//       },
//       version: 1,
//     );
//   }

   

// //  Future<void> insertSearchHistory(String query) async {
// //     await _database.insert(
// //       'search', // <-- Use 'search_history' instead of 'search'
// //       {'query': query},
// //       conflictAlgorithm: ConflictAlgorithm.replace,
// //     );
// //   }

// //   Future<List<String>> getSearchHistory() async {
// //     final List<Map<String, dynamic>> maps = await _database.query('search');
// //     return List.generate(maps.length, (i) => maps[i]['query'] as String);
// //   }
// }


class CartDatabaseHelper {
  late Database _database;

  CartDatabaseHelper() {
    initDatabase();
  }



  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();
  //factory CartDatabaseHelper() => _instance;

  CartDatabaseHelper._internal();

  //late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'cartdatabase.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId TEXT NOT NULL,
            name TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            price INTEGER NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }


Future<void> decreaseCartItemQuantity(String productId) async {
  final updatedQuantity = 1; // Set the updated quantity here

  final cartItem = await _database.query('cart', where: 'productId = ?', whereArgs: [productId]);

  if (cartItem.isNotEmpty) {
    final int existingQuantity = cartItem[0]['quantity'] as int;
    
    if (existingQuantity > 1) {
      // If the quantity is more than 1, decrease it by one
      final int updatedQuantity = existingQuantity - 1;
      await _database.update(
        'cart',
        {'quantity': updatedQuantity},
        where: 'productId = ?',
        whereArgs: [productId],
      );
    } else {
      // If the quantity is 1, remove the item from the cart
      await _database.delete('cart', where: 'productId = ?', whereArgs: [productId]);
    }
  }
}
   Future<void> addToCart(String productId, String productName, int quantity, int price) async {
    final cartItem = await _database.query('cart', where: 'productId = ?', whereArgs: [productId]);

    if (cartItem.isNotEmpty) {
      // If the item is already in the cart, update the quantity
      final int existingQuantity = cartItem[0]['quantity'] as int;
      final int updatedQuantity = existingQuantity + quantity;
      await _database.update(
        'cart',
        {'quantity': updatedQuantity},
        where: 'productId = ?',
        whereArgs: [productId],
      );
    } else {
      // If the item is not in the cart, insert it as a new item
      await _database.insert(
        'cart',
        {
          'productId': productId,
          'name': productName,
          'quantity': quantity,
          'price': price,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final List<Map<String, dynamic>> cartData = await _database.query('cart');
    return cartData.map((itemData) {
      return CartItem(
        productId: itemData['productId'],
        name: (itemData['name'] != null) ? itemData['name'] : '',
        quantity: itemData['quantity'],
        price: itemData['price'],
      );
    }).toList();
  }

   Future<void> clearCart() async {
    //await _database.close();
    await _database.delete('cart');
  }

Future<int> cartCount() async {
final List<Map<String, dynamic>> cartData = await _database.query('cart');
return cartData.length;
}

  Future<void> dropCartDatabase() async {
  // Get the application documents directory
  final documentsDirectory = await getApplicationDocumentsDirectory();

  // Get the path of the cart database file
  final cartDatabasePath = join(documentsDirectory.path, 'cart.db');

  // Delete the cart database file
  await deleteDatabase(cartDatabasePath);
}
Future<void> increaseCartItemQuantity(String productId) async {
  final cartItem = await _database.query('cart', where: 'productId = ?', whereArgs: [productId]);

  if (cartItem.isNotEmpty) {
    final int existingQuantity = cartItem[0]['quantity'] as int;
    final int updatedQuantity = existingQuantity + 1;

    await _database.update(
      'cart',
      {'quantity': updatedQuantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }
}
Future<void> deleteCartItem(String productId) async {
  await _database.delete('cart', where: 'productId = ?', whereArgs: [productId]);
}



}
