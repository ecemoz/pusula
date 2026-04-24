import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/app_state.dart';
import '../models/user_settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final settings = appState.settings;

    if (settings == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(LucideIcons.user, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              settings.studentName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Günlük Hedef (dk)'),
                    trailing: DropdownButton<int>(
                      value: settings.dailyGoalMinutes,
                      items: [5, 10, 15, 20, 30].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value dk'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          appState.updateSettings(UserSettings(
                            studentName: settings.studentName,
                            dailyGoalMinutes: val,
                            fontSize: settings.fontSize,
                            ttsEnabled: settings.ttsEnabled,
                            breakDurationMinutes: settings.breakDurationMinutes,
                          ));
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Yazı Boyutu'),
                    trailing: DropdownButton<String>(
                      value: settings.fontSize,
                      items: ['small', 'medium', 'large'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'small' ? 'Küçük' : value == 'medium' ? 'Orta' : 'Büyük'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          appState.updateSettings(UserSettings(
                            studentName: settings.studentName,
                            dailyGoalMinutes: settings.dailyGoalMinutes,
                            fontSize: val,
                            ttsEnabled: settings.ttsEnabled,
                            breakDurationMinutes: settings.breakDurationMinutes,
                          ));
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Sesli Okuma (TTS)'),
                    value: settings.ttsEnabled,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (val) {
                      appState.updateSettings(UserSettings(
                        studentName: settings.studentName,
                        dailyGoalMinutes: settings.dailyGoalMinutes,
                        fontSize: settings.fontSize,
                        ttsEnabled: val,
                        breakDurationMinutes: settings.breakDurationMinutes,
                      ));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Mola Süresi (dk)'),
                    trailing: DropdownButton<int>(
                      value: settings.breakDurationMinutes,
                      items: [3, 5, 10].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value dk'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          appState.updateSettings(UserSettings(
                            studentName: settings.studentName,
                            dailyGoalMinutes: settings.dailyGoalMinutes,
                            fontSize: settings.fontSize,
                            ttsEnabled: settings.ttsEnabled,
                            breakDurationMinutes: val,
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Veriler sıfırlandı! (Mock)')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Tüm Verileri Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}
