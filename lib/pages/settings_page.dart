import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

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
                  activeColor: secondaryColor,
                  value: provider.isDarkTheme,
                  onChanged: (value) => {
                    provider.setDarkTheme(value),
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Notification News'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      activeColor: secondaryColor,
                      onChanged: (value) {
                        scheduled.scheduledRestaurant(value);
                        provider.setDailyRestaurant(value);
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
