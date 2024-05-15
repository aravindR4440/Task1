import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/common/db_constants.dart';
import 'package:task1/models/item.dart';
import 'package:task1/models/owner.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseHelper;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DbConstants.databaseName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: DbConstants.databaseVersion,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${DbConstants.repositoriesTableName}(${DbConstants.id} INTEGER PRIMARY KEY,
          ${DbConstants.name} TEXT, ${DbConstants.fullName} TEXT, ${DbConstants.description} TEXT,
           ${DbConstants.date} TEXT,
          ${DbConstants.visibility} TEXT, ${DbConstants.language} TEXT, ${DbConstants.forksCount} INTEGER,
          ${DbConstants.htmlUrl} TEXT, ${DbConstants.url} TEXT, ${DbConstants.forksUrl} TEXT, ${DbConstants.keysUrl} TEXT,
          ${DbConstants.collaboratorsUrl} TEXT, ${DbConstants.teamsUrl} TEXT, ${DbConstants.hooksUrl} TEXT)
          ''');

    await db.execute(
      '''
      CREATE TABLE ${DbConstants.ownerTableName}(${DbConstants.ownerId} INTEGER PRIMARY KEY,
           ${DbConstants.repositoriesId} INTEGER,
           ${DbConstants.login} TEXT, ${DbConstants.avatarUrl} TEXT)''',
    );
  }

  Future<int> insertRepositoriesItem(Map<String, dynamic> map) async {
    final dbClient = await database;
    int res =
        await dbClient.insert(DbConstants.repositoriesTableName, map);
    return res;
  }

  Future<int> updateRepositoriesItem(Map<String, dynamic> map) async {
    final dbClient = await database;

    int res = await dbClient.update(DbConstants.repositoriesTableName,map,
        where: "${DbConstants.id} = ?",
        whereArgs:[map["id"]]
    );

    if (res > 0) {
      //do nothing
    } else {
      var int = insertRepositoriesItem(map);
    }
    return res;
  }

  Future<int> clearRepositoriesTable() async {
    final dbClient = await database;
    return await dbClient.rawDelete("DELETE FROM ${DbConstants.repositoriesTableName}");
  }

  Future<int> clearOwnerTable() async {
    final dbClient = await database;
    return await dbClient.rawDelete("DELETE FROM ${DbConstants.ownerTableName}");
  }

  Future<List<Item>> getRepositories(String date) async {
    final dbClient = await database;
    // List<Map> list = await dbClient
    //     .rawQuery('SELECT * FROM ${DbConstants.repositoriesTableName}');

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${DbConstants.repositoriesTableName} WHERE'
            ' ${DbConstants.date}=?',
        [date]);

    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(list.toString())
        .forEach((match) => debugPrint('database_repo_list:${match.group(0)}'));

    List<Item> items = [];
    for (int i = 0; i < list.length; i++) {
      var owner = await getOwner(list[i][DbConstants.id]);
      items.add(Item.fromLocalJson(list[i],owner));
    }
    return items;
  }

  Future<int> updateOwner(Map<String, dynamic> map) async {
    final dbClient = await database;

    int res = await dbClient.update(DbConstants.ownerTableName,map,
        where: "${DbConstants.ownerId} = ?",
        whereArgs:[map[DbConstants.ownerId]]
    );

    if (res > 0) {
      //do nothing
    } else {
      var int = insertOwner(map);
    }
    return res;
  }


  Future<int> insertOwner(Map<String, dynamic> map) async {
    final dbClient = await database;
    int res = await dbClient.insert(DbConstants.ownerTableName, map);
    return res;
  }



  Future<Owner?> getOwner(int repositoriesId) async {
    final dbClient = await database;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${DbConstants.ownerTableName} WHERE ${DbConstants.repositoriesId} = ?',[repositoriesId]);
    List<Owner> owners = [];
    for (int i = 0; i < list.length; i++) {
      owners.add(Owner.fromLocalJson(list[i]));
    }
    return owners.isNotEmpty?owners[0]:null;

  }
}
