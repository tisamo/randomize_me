import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:randomize_me/shared/layout/simple_layout.dart';
import 'dart:convert';

import '../models/album.dart';

Future<Album> _getTodos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleLayout(layout: FutureBuilder<Album>(
        future: _getTodos(),
        builder: (BuildContext context, AsyncSnapshot<Album> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(child: Text(snapshot.data!.title));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),title: 'Test',
    );
  }
}

