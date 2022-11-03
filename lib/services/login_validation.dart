import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, String>> credentials = [
  {"username": "nirmal", "password": "12345", "fullname": "Nirmal Yohannan"},
  {"username": "prameesh", "password": "1010", "fullname": "Prameesh P"}
];

loginStatus() async {
  print("Checking Login Status");
  final prefs = await SharedPreferences.getInstance();
  final bool? isLoggedIn = prefs.getBool("isLoggedIn");
  if (isLoggedIn == true) {
    print("Login Status: True");
    return true;
  } else {
    return false;
  }
}

setLoginStatusFalse() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isLoggedIn", false);
}

loginValidate({required String username, required String password}) async {
  for (int index = 0; index < credentials.length; index++) {
    if (credentials[index]["username"] == username) {
      if (credentials[index]["password"] == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString(
            "fullname", credentials[index]["fullname"]!); //used !

        return true;
      }
    }
  }
  return false;
}
