import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:api_implimentation/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Article>> getPosts() async {
    var client = http.Client();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2023-01-31&to=$formattedDate&sortBy=popularity&apiKey=ed0230ac26874f549b360d3528ad5878');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = await compute(postFromJson, response.body.toString());

      final List<Article> article = json.articles.toList();
      return article;
    }
    return [];
  }
}
