import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String displayNameKey = "DISPLAYNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEKEY";
  static String userProfilePasswordkey = "USERPROFILEPASSWORDKEY";

  //Save Data to Shared Preferences
  Future<bool> saveUserId(String getUserId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }
  Future<bool> saveUserName(String getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getUserDisplayName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserProfile(String getUserProfile) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfile);
  }
  Future<bool> saveUserPassword(String getUserPassword) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePasswordkey, getUserPassword);
  }




  //Get Data to Shared Preferences
  Future<String> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getUserDisplayName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String> getUserEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUserProfilePic()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }
  Future<String> getUserProfilePassword()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePasswordkey);
  }

  Future clearDataFromSharedPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
