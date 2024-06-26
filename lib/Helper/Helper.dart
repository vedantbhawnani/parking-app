import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const String databaseName = "ReportsPage.db";
  static const String tableName = 'cars';
  late final Database database;
  static bool isInitialized = false;

  Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, databaseName);
    database = await openDatabase(
      dbPath,
      version: 16,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            VehicleNumber TEXT,
            VehicleOwnerName TEXT,
            MobileNumber TEXT,
            Gate TEXT,
            VehicleType TEXT,
            TimeIn TEXT,
            User Text,
            fourNumber TEXT,
            DriverName TEXT,
            DriverPhone TEXT            
          )
        ''');
      },
    );
    isInitialized = true;
    return database;
  }

  Future<int> insert(Map<String, dynamic> data) async {
    final db = database;
    // print('Inserting data ${data}');
    final id = await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<void> saveToDatabase(List<Map<String, dynamic>> cars) async {
    for (var user in cars) {
      final data = Map<String, dynamic>.from(user);
      data.removeWhere((key, value) => value == null);
      // print(data);
      await database.insert(
        'cars',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> resetTable() async {
    if (DatabaseHelper.isInitialized) {
      final db = database;
      await db.delete(tableName);
      // print('table deleted');
    }
  }

  Future<void> resetFirebaseValues() async {
    final firestore = FirebaseFirestore.instance;
    // final today = DateTime.now();

    final querySnapshot = await firestore
        .collection('cars')
        // .where('TimeIn',
        //     isGreaterThanOrEqualTo:
        //         DateTime(today.year, today.month, today.day))
        // .where('TimeIn',
        //     isLessThanOrEqualTo:
        //         DateTime(today.year, today.month, today.day, 23, 59, 59))
        .get();

    final batch = firestore.batch();
    for (var doc in querySnapshot.docs) {
      batch.update(doc.reference, {
        'TimeIn': FieldValue.delete(),
        'TimeOut': FieldValue.delete(),
        'MarkColor': FieldValue.delete(),
        'Gate': FieldValue.delete(),
        'User': FieldValue.delete()
      });
    }
    await batch.commit();
    // print('firebase reseted');
  }

  Future<void> resetGateCounts() async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      // Get references to the gate count documents
      final gate1Ref =
          FirebaseFirestore.instance.collection('gateCounts').doc('Gate 1');
      final gate2Ref =
          FirebaseFirestore.instance.collection('gateCounts').doc('Gate 2');
      final gate3Ref =
          FirebaseFirestore.instance.collection('gateCounts').doc('Gate 3');

      // Set the count to 0 for each document
      batch.update(gate1Ref, {'count': 0});
      batch.update(gate2Ref, {'count': 0});
      batch.update(gate3Ref, {'count': 0});

      // Commit the batch write
      await batch.commit();
    } catch (e) {
      // Handle errors
      print('Error resetting gate counts: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchVehicles(String number) async {
    final collection = FirebaseFirestore.instance.collection('cars');

    final querySnapshot =
        await collection.where('fourNumber', isEqualTo: number).get();
    final List<Map<String, dynamic>> vehiclesWithDocIds = [];
    for (final doc in querySnapshot.docs) {
      final vehicleData = doc.data();
      final docId = doc.reference.id;
      vehiclesWithDocIds.add({
        ...vehicleData, // Spread existing vehicle data
        'docId': docId, // Add document ID to the map
      });
    }
    // print(vehiclesWithDocIds);
    return vehiclesWithDocIds;
  }
}
