
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:task1/apimanager/repo_apimananger.dart';
import 'package:task1/common/database_helper.dart';
import 'package:task1/models/item.dart';
import 'package:task1/models/items.dart';

class Repositories extends ChangeNotifier{

  ItemObj _itemObj = ItemObj();

  bool loading = false;

  RepoApiManager manager = RepoApiManager();

  var databaseHelper = DatabaseHelper();


  String date = "2022-04-29";


  Repositories(){
    _itemObj = ItemObj();
    notifyListeners();
  }

  ItemObj get itemObj => _itemObj;

  String getDateyyyyMMdd(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  DateTime getDateTime(String date){
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(date);
    return dateTime;
  }


  getRepositoriesFromServer(String date)async{
    loading = true;
    _itemObj = await manager.getRepositories(date);
    loading = false;
    notifyListeners();
    insertRepositoriesAndOwnerToLocalDb(date);
  }

  getRepositoriesFromLocal(String date)async{
    var items = await databaseHelper.getRepositories(date);
    _itemObj = ItemObj(items: items);
    notifyListeners();
  }


  insertRepositoriesAndOwnerToLocalDb(String date)async{
    if(itemObj.items!=null&&itemObj.items!.isNotEmpty){
      await Future.forEach(itemObj.items!, (Item item) async {
        return insertItem(item,date);
      });
    }
  }


  insertItem(Item item,String date)async{

    await databaseHelper.updateRepositoriesItem(item.toMap(date));
    if(item.owner!=null&&item.id!=null){
      await databaseHelper.updateOwner(item.owner!.toMap(item.id!));
    }

    // await compute(databaseHelper.insertRepositoriesItem,item.toMap(date));
    // if(item.owner!=null&&item.id!=null){
    //   await compute(databaseHelper.insertOwner,item.owner!.toMap(item.id!));
    // }
  }

}