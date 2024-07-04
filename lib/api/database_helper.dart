import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance of DatabaseHelper
  static DatabaseHelper? _instance;
  static Database? _database;

  // Database info
  static const String _dbName = "login.db";
  static const int _dbVersion = 1;
  static const String _tableName = "users";

  // Column names
  static const String columnId = 'id';
  static const String columnEmail = 'username';
  static const String columnPassword = 'password';
  static const String columnProfilePicture = 'profilePicture';

  // Track logged-in user
  static String? loggedInUser;

  // Private constructor
  DatabaseHelper._privateConstructor();

  // Singleton instance getter
  static DatabaseHelper get instance {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  // Database getter
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT,
        $columnProfilePicture TEXT
      )
    ''');
  }

  // Insert user into database
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  // Save logged-in user
  Future<void> saveLoggedInUser(String username, String password) async {
    Database db = await instance.database;
    await db.delete(_tableName); // Delete existing user (single user mode)

    Map<String, dynamic> row = {
      columnEmail: username,
      columnPassword: password,
    };
    await db.insert(_tableName, row);

    loggedInUser = username;
  }

  // Get logged-in user
  Future<Map<String, dynamic>?> getLoggedInUser() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> rows = await db.query(_tableName, limit: 1);
    return rows.isNotEmpty ? rows.first : null;
  }

  // Clear logged-in user
  Future<void> clearLoggedInUser() async {
    Database db = await instance.database;
    await db.delete(_tableName);
    loggedInUser = null;
  }

  // Query user by username and password
  Future<Map<String, dynamic>?> queryUser(String username, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update user information
  Future<void> updateUser(Map<String, dynamic> updatedUser) async {
    Database db = await instance.database;
    await db.update(
      _tableName,
      updatedUser,
      where: '$columnId = ?',
      whereArgs: [updatedUser[columnId]],
    );
  }
}
