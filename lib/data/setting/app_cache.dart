import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kSplash = 'splash';

  Future<void> completeSplash() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kSplash, true);
  }
Future<bool>didCompleteSplash() async{
final prefs=await SharedPreferences.getInstance();
return prefs.getBool(kSplash)??false;
}
}
