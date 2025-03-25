import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/dream.dart';
import '/theme/app_theme.dart';

class DreamDetailScreen extends StatelessWidget {
  final Dream dream;
  
  const DreamDetailScreen({
    super.key,
    required this.dream,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('d MMMM yyyy').format(dream.date),
          style: AppTheme.subheadingStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsBottomSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dream.title,
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: 24),
            Text(
              dream.description,
              style: AppTheme.bodyStyle,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Mood: ',
                  style: AppTheme.subheadingStyle,
                ),
                const SizedBox(width: 8),
                _buildMoodIndicator(dream.mood),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodIndicator(String mood) {
    String emoji;
    switch (mood) {
      case 'happy':
        emoji = '😊';
        break;
      case 'neutral':
        emoji = '😐';
        break;
      case 'sad':
        emoji = '😔';
        break;
      case 'angry':
        emoji = '😠';
        break;
      case 'surprised':
        emoji = '😲';
        break;
      default:
        emoji = '😐';
    }
    
    return Text(
      emoji,
      style: const TextStyle(fontSize: 24),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Dream'),
                onTap: () async {
                  Navigator.pop(context); // Close bottom sheet
                  final result = await Navigator.pushNamed(
                    context,
                    '/edit-dream',
                    arguments: dream,
                  );
                  
                  if (result != null && result is Dream) {
                    Navigator.pop(context, result); // Return updated dream
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Dream', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  _showDeleteConfirmation(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Dream'),
          content: const Text('Are you sure you want to delete this dream? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context, 'delete'); // Return delete signal
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

