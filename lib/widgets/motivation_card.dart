import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MotivationCard extends StatelessWidget {
  final int todayMinutes;
  final int goalMinutes;

  const MotivationCard({
    Key? key,
    required this.todayMinutes,
    required this.goalMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percent = (goalMinutes > 0) ? (todayMinutes / goalMinutes).clamp(0.0, 1.0) : 0.0;
    
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('📖', style: TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Bugün $goalMinutes dakika\nokuma yapalım',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 12.0,
                    percent: percent,
                    backgroundColor: Colors.grey[200],
                    progressColor: Theme.of(context).primaryColor,
                    barRadius: const Radius.circular(6),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$todayMinutes / $goalMinutes dk',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
