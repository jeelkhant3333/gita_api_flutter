import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: ApiData(),
      ),
    ),
  );
}

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  Map<String, dynamic> apiData = {};

  Future<void> fetchData(String chapter) async {
    try {
      String url =
          "https://bhagavad-gita3.p.rapidapi.com/v2/chapters/$chapter/";
      Response response = await http.get(Uri.parse(url), headers: {
        'X-RapidAPI-Key': '4acd7b145amsh16b6d200f4c9f96p17045fjsnd007a69fd5e3',
        'X-RapidAPI-Host': 'bhagavad-gita3.p.rapidapi.com'
      });
      if (response.statusCode == 200) {
        setState(() {
          apiData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData("3");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: apiData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(apiData['id'].toString()),
                  Text(apiData['name']),
                  Text(apiData['slug']),
                  Text(apiData['name_transliterated']),
                  Text(apiData['name_translated']),
                  Text(apiData['verses_count'].toString()),
                  Text(apiData['chapter_number'].toString()),
                  Text(apiData['name_meaning']),
                  Text(apiData['chapter_summary']),
                ],
              ),
          ),
    );
  }
}
