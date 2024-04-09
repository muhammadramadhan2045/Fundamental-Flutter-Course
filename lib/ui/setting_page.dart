import 'package:flutter/material.dart';
import 'package:news_app/provider/preferences_provider.dart';
import 'package:news_app/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (_, provider, __) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: provider.isDarkTheme,
                  onChanged: (value) => {provider.setDarkTheme(value)},
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Notification News'),
                trailing: Consumer<SchedullingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNewsEnabled,
                      onChanged: (value) {
                        scheduled.scheduledNews(value);
                        provider.setDailyNews(value);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
