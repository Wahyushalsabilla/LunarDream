import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class MoodSelector extends StatelessWidget {
  final String selectedMood;
  final Function(String) onMoodSelected;
  
  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I felt',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMoodOption('happy', '😊', context),
            _buildMoodOption('neutral', '😐', context),
            _buildMoodOption('sad', '😔', context),
            _buildMoodOption('angry', '😠', context),
            _buildMoodOption('surprised', '😲', context),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodOption(String mood, String emoji, BuildContext context) {
    final bool isSelected = selectedMood == mood;
    
    return GestureDetector(
      onTap: () => onMoodSelected(mood),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

