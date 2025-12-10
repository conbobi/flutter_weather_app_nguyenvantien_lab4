// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dùng context.watch để UI tự cập nhật khi switch thay đổi
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0,
        backgroundColor: Colors.transparent, // Để ăn theo theme
      ),
      body: ListView(
        children: [
          // 1. Đơn vị nhiệt độ
          SwitchListTile(
            title: Text("Temperature Unit"),
            subtitle: Text(settings.isCelsius ? "Celsius (°C)" : "Fahrenheit (°F)"),
            value: settings.isCelsius,
            activeColor: Colors.blue,
            onChanged: (val) => context.read<SettingsProvider>().toggleTemperature(val),
          ),
          Divider(),

          // 2. Đơn vị gió
          SwitchListTile(
            title: Text("Wind Speed Unit"),
            subtitle: Text(settings.isMsSpeed ? "Meters per second (m/s)" : "Kilometers per hour (km/h)"),
            value: settings.isMsSpeed,
            activeColor: Colors.blue,
            onChanged: (val) => context.read<SettingsProvider>().toggleWindSpeed(val),
          ),
          Divider(),

          // 3. Định dạng giờ
          SwitchListTile(
            title: Text("Time Format"),
            subtitle: Text(settings.is24HourFormat ? "24 Hour (13:00)" : "12 Hour (1:00 PM)"),
            value: settings.is24HourFormat,
            activeColor: Colors.blue,
            onChanged: (val) => context.read<SettingsProvider>().toggleTimeFormat(val),
          ),
          Divider(),

          // 4. Dark Mode
          SwitchListTile(
            title: Text("Dark Theme"),
            subtitle: Text(settings.isDarkTheme ? "Enabled" : "Disabled"),
            value: settings.isDarkTheme,
            activeColor: Colors.blue,
            onChanged: (val) => context.read<SettingsProvider>().toggleTheme(val),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            subtitle: Text("Weather App v1.0 - Flutter Assignment"),
          ),
        ],
      ),
    );
  }
}