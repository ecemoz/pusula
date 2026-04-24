import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/reading_provider.dart';
import '../providers/app_state.dart';
import '../widgets/paragraph_card.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readingProvider = context.watch<ReadingProvider>();
    final appState = context.watch<AppState>();
    
    final content = readingProvider.content;
    final paragraphs = content.paragraphs;
    final fontSizeStr = appState.settings?.fontSize ?? 'medium';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Okuma'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: paragraphs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => readingProvider.setParagraph(index),
                  child: ParagraphCard(
                    text: paragraphs[index],
                    isActive: index == readingProvider.currentParagraphIndex,
                    isPlaying: readingProvider.isPlaying && index == readingProvider.currentParagraphIndex,
                    fontSizeStr: fontSizeStr,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.skipBack, size: 30),
                  onPressed: () => readingProvider.previousParagraph(),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (readingProvider.isPlaying) {
                      readingProvider.pause();
                    } else {
                      readingProvider.play();
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    readingProvider.isPlaying ? LucideIcons.pause : LucideIcons.play,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.skipForward, size: 30),
                  onPressed: () => readingProvider.nextParagraph(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
