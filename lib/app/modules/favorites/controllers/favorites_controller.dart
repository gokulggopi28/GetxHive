import 'package:get/get.dart';
import 'package:hive/hive.dart';


class FavoritesController extends GetxController {
  var favorites = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    final box = Hive.box('favorites');
    favorites.value = box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  void removeFavorite(String name) {
    final box = Hive.box('favorites');  
    box.delete(name);
    loadFavorites();
  }
}
