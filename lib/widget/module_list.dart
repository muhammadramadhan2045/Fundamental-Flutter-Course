import 'package:flutter/material.dart';
import 'package:latihan_state_management/provider/bookmark_module_provider.dart';
import 'package:latihan_state_management/widget/module_tile.dart';
import 'package:provider/provider.dart';

class ModuleList extends StatefulWidget {
  const ModuleList({
    super.key,
  });

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> _moduleList = [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Program Dart Pertamamu',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _moduleList.length,
      itemBuilder: (context, index) {
        return Consumer<BookmarkModuleProvider>(
            builder: (context, BookmarkModuleProvider provider, child) {
          return ModuleTile(
            moduleName: _moduleList[index],
            isDone: provider.doneModuleList.contains(_moduleList[index]),
            onClick: () {
              provider.doneModuleList.contains(_moduleList[index])
                  ? provider.removeDoneModule(_moduleList[index])
                  : provider.addDoneModule(_moduleList[index]);
            },
          );
        });
      },
    );
  }
}
