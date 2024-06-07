import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _news = [];
  String _category = 'national';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _errorMessage = '';
    });

    final response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=$_category'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          List<dynamic> newsData = jsonResponse['data'];
          _news = newsData.map((news) {
            String imageUrl = news['imageUrl'] ?? '';
            return {
              'title': news['title'],
              'content': news['content'],
              'imageUrl': imageUrl,
            };
          }).toList();
        });
      } else {
        setState(() {
          _errorMessage = jsonResponse['error'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Failed to load news';
      });
    }
  }

  Future<void> _bookmarkNews(Map<String, dynamic> news) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.add(json.encode(news));
    await prefs.setStringList('bookmarks', bookmarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Quick News'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _category = result;
                _fetchNews();
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'all',
                child: Text('All'),
              ),
              const PopupMenuItem<String>(
                value: 'national',
                child: Text('National'),
              ),
              const PopupMenuItem<String>(
                value: 'business',
                child: Text('Business'),
              ),
              const PopupMenuItem<String>(
                value: 'sports',
                child: Text('Sports'),
              ),
              const PopupMenuItem<String>(
                value: 'world',
                child: Text('World'),
              ),
              const PopupMenuItem<String>(
                value: 'politics',
                child: Text('Politics'),
              ),
              const PopupMenuItem<String>(
                value: 'technology',
                child: Text('Technology'),
              ),
              const PopupMenuItem<String>(
                value: 'startup',
                child: Text('Startup'),
              ),
              const PopupMenuItem<String>(
                value: 'entertainment',
                child: Text('Entertainment'),
              ),
              const PopupMenuItem<String>(
                value: 'miscellaneous',
                child: Text('Miscellaneous'),
              ),
              const PopupMenuItem<String>(
                value: 'hatke',
                child: Text('Hatke'),
              ),
              const PopupMenuItem<String>(
                value: 'science',
                child: Text('Science'),
              ),
              const PopupMenuItem<String>(
                value: 'automobile',
                child: Text('Automobile'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(context, '/bookmarks');
            },
          ),
        ],
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        itemCount: _news.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_news[index]['imageUrl'] != null &&
                          _news[index]['imageUrl'].isNotEmpty)
                        Image.network(
                          _news[index]['imageUrl'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 10),
                      Text(
                        _news[index]['title'],
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(_news[index]['content']),
                      SizedBox(height: 50),
                      IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () => _bookmarkNews(_news[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
