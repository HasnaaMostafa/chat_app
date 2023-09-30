import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init()
  async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static dynamic getData({required key}){
    return sharedPreferences?.get(key);
  }


}