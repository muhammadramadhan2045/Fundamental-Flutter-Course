import 'package:flutter/material.dart';

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;
  const ModuleTile({
    super.key,
    required this.moduleName,
    required this.isDone,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: ElevatedButton(
        onPressed: () => onClick(),
        child: isDone ? const Text('Selesai') : const Text('Belum Selesai'),
      ),
    );
  }
}
