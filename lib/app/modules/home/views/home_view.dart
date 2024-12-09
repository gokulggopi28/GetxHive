import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.country.length,
          itemBuilder: (context, index) {

            final country = controller.country[index];
            final flagUrl = country['flags']['png'];
            return ListTile(
              leading: flagUrl != null
                  ? Image.network(
                      flagUrl, 
                      width: 100, 
                      height: 60,
                      fit: BoxFit.cover, 
                    )
                  : const Icon(Icons.flag), 
              title: Text(country['name']['common'] ?? ''),
              subtitle: Text('Capital: ${country['capital']}\nRegion: ${country['region']}'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  try {
                     final box = Hive.box('favorites');
                     box.put(country['name'], country);

                     Get.snackbar(
                      'Added', 
                      '${country['name']} added to favorites',
                      snackPosition: SnackPosition.BOTTOM
                    );
                    
                  } catch (e) {
                    Get.snackbar(
                      'Error', 
                      'Failed to add to favorites',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white
                    );
                    
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }
}
