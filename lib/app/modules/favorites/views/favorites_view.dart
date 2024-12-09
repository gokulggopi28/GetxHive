import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet!'));
        }
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final country = controller.favorites[index];
            return ListTile(
              leading:Text(country['flag'] ?? ''),
              title:Text(country['name']['common'] ?? ''),
              subtitle: Text('Capital: ${country['capital']}\nRegion: ${country['region']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeFavorite(country['name']['common']);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
