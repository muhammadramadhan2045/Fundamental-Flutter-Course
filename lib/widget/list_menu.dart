import 'package:flutter/material.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({
    super.key,
    required this.allMenu,
  });

  final List allMenu;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allMenu.length,
      itemBuilder: (context, index) {
        return Center(
          child: ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(allMenu[index].name ?? ''),
            subtitle: const Text(
              'Rp 15.000',
            ),
          ),
        );
      },
    );
  }
}
