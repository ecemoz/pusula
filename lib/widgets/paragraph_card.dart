import 'package:flutter/material.dart';

class ParagraphCard extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isPlaying;
  final String fontSizeStr;

  const ParagraphCard({
    Key? key,
    required this.text,
    required this.isActive,
    required this.isPlaying,
    required this.fontSizeStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = 18.0;
    if (fontSizeStr == 'small') fontSize = 14.0;
    if (fontSizeStr == 'large') fontSize = 24.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: isActive
            ? Border.all(color: Theme.of(context).primaryColor, width: 2)
            : Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive && isPlaying)
            Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 4.0),
              child: Icon(Icons.volume_up, color: Theme.of(context).primaryColor),
            ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.5,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
