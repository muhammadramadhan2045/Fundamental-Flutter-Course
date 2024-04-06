import 'package:flutter/material.dart';
import 'package:latihan_state_management/provider/bookmark_module_provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final doneModuleList =
        Provider.of<BookmarkModuleProvider>(context).doneModuleList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Page'),
      ),
      body: doneModuleList.isNotEmpty
          ? ListView.builder(
              itemCount: doneModuleList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(doneModuleList[index]),
                );
              },
            )
          : const Center(
              child: Text('Belum ada modul yang selesai'),
            ),
    );
  }
}
