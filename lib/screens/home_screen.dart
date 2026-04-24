import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme.dart';
import '../providers/app_state.dart';
import '../providers/reading_provider.dart';
import '../widgets/motivation_card.dart';
import '../widgets/action_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  
  const HomeScreen({Key? key, required this.onNavigate}) : super(key: key);

  void _showSummaryModal(BuildContext context, ReadingProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kısa Özet'),
        content: Text(provider.content.summary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tamam'),
          )
        ],
      ),
    );
  }

  void _showBreakModal(BuildContext context, int breakMinutes) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mola Zamanı ☕'),
        content: Text('Şimdi $breakMinutes dakikalık kısa bir mola verme zamanı. Gözlerini dinlendir ve derin nefes al.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Molayı Bitir'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final readingProvider = context.read<ReadingProvider>();
    
    final settings = appState.settings;
    if (settings == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.menu),
          onPressed: () {},
        ),
        title: const Text('PUSULA'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.star, color: AppTheme.yellowColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MotivationCard(
                todayMinutes: appState.todayReadingMinutes,
                goalMinutes: settings.dailyGoalMinutes,
              ),
            ),
            const SizedBox(height: 24),
            ActionCard(
              title: 'Metni oku',
              icon: LucideIcons.volume2,
              color: AppTheme.primaryColor,
              onTap: () {
                readingProvider.play();
                onNavigate(1);
              },
            ),
            ActionCard(
              title: 'Kaldığım yeri işaretle',
              icon: LucideIcons.bookmark,
              color: AppTheme.pinkColor,
              onTap: () {
                readingProvider.saveBookmark();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kaldığın yer kaydedildi!')),
                );
              },
            ),
            ActionCard(
              title: 'Tekrar oku',
              icon: LucideIcons.refreshCw,
              color: AppTheme.lightBlueColor,
              onTap: () {
                readingProvider.play();
                onNavigate(1);
              },
            ),
            ActionCard(
              title: 'Kısa özet çıkar',
              icon: LucideIcons.fileText,
              color: AppTheme.purpleColor,
              onTap: () => _showSummaryModal(context, readingProvider),
            ),
            ActionCard(
              title: 'Devam et',
              icon: LucideIcons.playCircle,
              color: AppTheme.greenColor,
              onTap: () => onNavigate(1),
            ),
            ActionCard(
              title: 'Mola ver',
              icon: LucideIcons.coffee,
              color: AppTheme.yellowColor,
              onTap: () => _showBreakModal(context, settings.breakDurationMinutes),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LucideIcons.sprout, color: AppTheme.greenColor),
                SizedBox(width: 8),
                Text(
                  'Adım adım ilerle',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
