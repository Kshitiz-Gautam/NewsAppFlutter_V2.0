import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_v2o/newscontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsApp'),
        leading: IconButton(
          onPressed: () {
            newsController.GetNews();
          },
          icon: Icon(Icons.refresh),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() {
          if (newsController.newsList.isEmpty) {
            return Center(child: Text('No news available. Tap refresh to load.'));
          }
          return ListView.builder(
            itemCount: newsController.newsList.length,
            itemBuilder: (context, index) {
              var article = newsController.newsList[index];
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 10),
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            article['urlToImage'] ?? "https://via.placeholder.com/250",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 250),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        article['title'] ?? 'No Title',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              article['description'] ?? 'No Description',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
