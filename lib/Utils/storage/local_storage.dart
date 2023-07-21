import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
/* get stored value */
  static  String ACCESS_TOKEN_KEY = 'accessToken';
  
/* get stored value */
  Future getFromDisk(String key) async{
    if (kDebugMode) {
      print(key);
    }
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(preferences.get(key));
    }
    return preferences.get(key);
  }

/* updated _saveToDisk function that handles all types */
  saveToDisk<T>(String key, T content) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(content is String) {
      preferences.setString(key, content);
    }
    if(content is bool) {
      preferences.setBool(key, content);
    }
    if(content is int) {
      preferences.setInt(key, content);
    }
    if(content is double) {
      preferences.setDouble(key, content);
    }
    if(content is List<String>) {
      preferences.setStringList(key, content);
    }
  }

  /* remove from disk */
  removeToDisk<T>(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
  clearDisk() async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.clear();
  }
}
