import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../providers/app_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final settings = appState.settings;
    
    if (settings == null) return const Center(child: CircularProgressIndicator());

    final todayMinutes = appState.todayReadingMinutes;
    final goalMinutes = settings.dailyGoalMinutes;
    final percent = (goalMinutes > 0) ? (todayMinutes / goalMinutes).clamp(0.0, 1.0) : 0.0;
    
    final totalSessions = appState.sessions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('İlerleme'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 15.0,
                percent: percent,
                center: Text(
                  '%${(percent * 100).toInt()}',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                progressColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey[200]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(height: 30),
            _buildStatCard('Bugünkü Süre', '$todayMinutes dk'),
            _buildStatCard('Hedef', '$goalMinutes dk'),
            _buildStatCard('Toplam Oturum', '$totalSessions'),
            _buildStatCard('Tekrar Okuma', '3 kez'),
            _buildStatCard('İşaretlenen Yer', '2'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
