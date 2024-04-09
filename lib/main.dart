import 'package:flutter/material.dart';
import 'package:local_db/provider/db_provider.dart';
import 'package:local_db/ui/note_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbProvider>(
      create: (context) => DbProvider(),
      child: MaterialApp(
        title: 'Local DB SQLite',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const NoteListPage(),
      ),
    );
  }
}
