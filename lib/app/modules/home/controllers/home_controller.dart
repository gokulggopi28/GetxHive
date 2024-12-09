import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
   var country = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  final Dio dio = Dio();
 

  @override
  void onInit() {
    super.onInit();
    fetchCountry();
  }

  void fetchCountry() async{
    try {
      isLoading(true);
      final response = await dio.get('https://restcountries.com/v3.1/all');

      if(response.statusCode == 200){
        final data = response.data as List;
        country.value = List<Map<String, dynamic>>.from(data);

      }
      else{
        throw Exception('failed to load data');
      }

      
    } catch (e) {
      print('Error: $e');
      
    }
    finally{
      isLoading(false);
    }

  }

  

 


}