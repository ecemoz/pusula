import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/reading_content.dart';
import '../providers/reading_provider.dart';

class LibraryScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const LibraryScreen({Key? key, required this.onNavigate}) : super(key: key);

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  Future<void> _openPageVoiceSheet(
    BuildContext context,
    ReadingProvider provider,
    ReadingContent content,
  ) async {
    await provider.setActiveContent(content.id);
    final pages = provider.pageChunks;

    if (!context.mounted) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(ctx).size.height * 0.72,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.volume2),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sayfa Seslendirme • ${content.title}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      final preview = pages[index].replaceAll('\n', ' ');
                      final shortPreview = preview.length > 120
                          ? '${preview.substring(0, 120)}...'
                          : preview;

                      return Card(
                        child: ListTile(
                          title: Text('Sayfa ${index + 1}'),
                          subtitle: Text(shortPreview),
                          trailing: IconButton(
                            icon: const Icon(LucideIcons.playCircle),
                            onPressed: () async {
                              await provider.setPage(index);
                              await provider.playCurrentPage();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReadingProvider>();
    final library = provider.library;

    return Scaffold(
      appBar: AppBar(title: const Text('Kütüphane'), centerTitle: true),
      body: library.isEmpty
          ? const Center(
              child: Text(
                'Henüz içerik yok.\nAna sayfadan içerik çekebilirsin.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: library.length,
              itemBuilder: (context, index) {
                final item = library[index];
                final isActive = item.id == provider.content.id;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isActive)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Aktif',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(item.summary),
                        const SizedBox(height: 12),
                        Text(
                          'Çekilme tarihi: ${_formatDate(item.fetchedAt)} • ${item.paragraphs.length} paragraf',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(LucideIcons.bookOpen),
                                label: const Text('Oku'),
                                onPressed: () async {
                                  await provider.setActiveContent(item.id);
                                  if (!context.mounted) {
                                    return;
                                  }
                                  onNavigate(2);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(LucideIcons.volume2),
                                label: const Text('Sayfayı Seslendir'),
                                onPressed: () => _openPageVoiceSheet(
                                  context,
                                  provider,
                                  item,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
