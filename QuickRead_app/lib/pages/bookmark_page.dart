import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Map<String, dynamic>> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    setState(() {
      _bookmarks = bookmarks
          .map((e) => Map<String, dynamic>.from(json.decode(e)))
          .toList();
    });
  }

  Future<void> _removeBookmark(Map<String, dynamic> bookmark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.remove(json.encode(bookmark));
    await prefs.setStringList('bookmarks', bookmarks);
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Bookmarks'),
      ),
      body: _bookmarks.isEmpty
          ? Center(child: Text('No bookmarks available'))
          : ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          return BookmarkTile(
            bookmark: _bookmarks[index],
            onRemove: () => _removeBookmark(_bookmarks[index]),
          );
        },
      ),
    );
  }
}

class BookmarkTile extends StatelessWidget {
  final Map<String, dynamic> bookmark;
  final VoidCallback onRemove;

  BookmarkTile({required this.bookmark, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bookmark['imageUrl'] != null && bookmark['imageUrl'].isNotEmpty)
              Image.network(
                bookmark['imageUrl'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Text(
              bookmark['title'] ?? 'No Title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(bookmark['content'] ?? 'No Content'),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.bookmark_remove_outlined),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
