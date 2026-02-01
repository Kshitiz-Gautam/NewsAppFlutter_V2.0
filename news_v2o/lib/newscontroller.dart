import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  RxList newsList = [].obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    GetNews();
  }

  Future<void> GetNews() async {
    const api =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=dbbcb4fd06a0451d90114b78fe95a649";

    try {
      final response = await _dio.get(api);
      if (response.statusCode == 200) {
        newsList.value = response.data['articles'];
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}
