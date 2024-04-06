import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  final List<String> doneModuleList;
  const BookmarkPage({super.key, required this.doneModuleList});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Page'),
      ),
      body: widget.doneModuleList.isNotEmpty
          ? ListView.builder(
              itemCount: widget.doneModuleList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.doneModuleList[index]),
                );
              },
            )
          : const Center(
              child: Text('Belum ada modul yang selesai'),
            ),
    );
  }
}
