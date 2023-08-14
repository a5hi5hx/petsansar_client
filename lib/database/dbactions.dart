// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// Future<Database> _openDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path1 = path.join(documentsDirectory.path, 'my_database.db');
//     return openDatabase(path1, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
//         CREATE TABLE categories (
//           id TEXT PRIMARY KEY,
//           name TEXT,
//           image TEXT,
//           description TEXT,
//           status TEXT
//         )
//       ''');
//     });
//   }
