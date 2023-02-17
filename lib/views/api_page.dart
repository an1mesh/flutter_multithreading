import 'dart:isolate';

import 'package:api_implimentation/services/remoteservice.dart';
import 'package:flutter/material.dart';
import 'package:api_implimentation/models/post.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<Article>? posts;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = (await RemoteService().getPosts());
    isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taday\'s News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: RemoteService().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Visibility(
                      visible: isLoaded,
                      replacement: const CircularProgressIndicator(),
                      child: InkWell(
                        onTap: null,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child: Visibility(
                            visible: isLoaded,
                            replacement: const CircularProgressIndicator(),
                            child: Card(
                              child: Image.network(posts![index].urlToImage!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(posts![index].title),
                      subtitle: Text(posts![index].content),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('Please wait'));
          }
        },
      ),
     
    );
  }
}
