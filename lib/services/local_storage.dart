import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}


// en esta clase se podrian utilizar otros metodos como getToken(), el userTheme()

// 1- importar paquete shared_preferences
// 2- crear la esta clase LocalStorage
// 3- inyectar en el main LocalStorage.configurePrefs()
// 4- guardar el token en el archivo auth provider : LocalStorage.prefs.setString("key","value")
