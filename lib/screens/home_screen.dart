import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/dream.dart';
import '/widgets/logo_widget.dart';
import '/widgets/dream_card.dart';
import '/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dream> dreams = Dream.sampleDreams;
  Dream? selectedDream;
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011638), // Dark blue background
      body: SafeArea(
        child: Column(
          children: [
            // App bar with logo on the right
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Posisi ke kiri
            crossAxisAlignment: CrossAxisAlignment.start, // Posisi ke atas
            children: [
             Image.asset(
                'images/logo2.png',
                height: 94,
              ),
            ],
          ),
          ),
            
            // Dream list
            Expanded(
              child: dreams.isEmpty
                  ? _buildEmptyState()
                  : _buildDreamList(),
            ),
            
            // Dream details section (expandable)
            if (showDetails && selectedDream != null)
              _buildDreamDetails(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add-dream');
          if (result != null && result is Dream) {
            setState(() {
              dreams.add(result);
            });
          }
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Opacity(
            opacity: 0.45,
            child: Container(
              margin: const EdgeInsets.only(right: 10),  // Menambahkan margin kanan
              child: Image.asset(
                'images/moon.png',
                height: 94,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to your dream journal!',
            style: AppTheme.subheadingStyle.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "It's currently empty.",
            style: AppTheme.bodyStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Tap the + button to add your first dream',
            style: AppTheme.captionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDreamList() {
    return ListView.builder(
      itemCount: dreams.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final dream = dreams[index];
        return _buildDreamCard(dream);
      },
    );
  }

  Widget _buildDreamCard(Dream dream) {
    final bool isSelected = selectedDream?.id == dream.id;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            // If already selected, toggle details visibility
            showDetails = !showDetails;
          } else {
            // If not selected, select it and show details
            selectedDream = dream;
            showDetails = true;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0D2143) : const Color(0xFF0D1B40),
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
              ? Border.all(color: Colors.white.withOpacity(0.3), width: 1)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MMMM').format(dream.date),
                  style: AppTheme.captionStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      dream.date.day.toString(),
                      style: AppTheme.headingStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Dream content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream.title,
                    style: AppTheme.subheadingStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dream.description,
                    style: AppTheme.bodyStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDreamDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B40),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date and options row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('d MMMM yyyy').format(selectedDream!.date),
                style: AppTheme.captionStyle,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: _showOptionsBottomSheet,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Dream title
          Text(
            selectedDream!.title,
            style: AppTheme.headingStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          // Dream description
          Text(
            selectedDream!.description,
            style: AppTheme.bodyStyle,
          ),
          const SizedBox(height: 16),
          // Mood indicators
          Row(
            children: [
              Image.asset(
                'images/mood_${selectedDream!.mood}.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                selectedDream!.mood.substring(0, 1).toUpperCase() + selectedDream!.mood.substring(1),
                style: AppTheme.captionStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13284A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.white),
                title: const Text('Edit Dream', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context); // Close bottom sheet
                  final result = await Navigator.pushNamed(
                    context,
                    '/edit-dream',
                    arguments: selectedDream,
                  );
                  
                  if (result != null && result is Dream) {
                    setState(() {
                      final index = dreams.indexWhere((d) => d.id == selectedDream!.id);
                      if (index != -1) {
                        dreams[index] = result;
                        selectedDream = result;
                      }
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Dream', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  _showDeleteConfirmation();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF13284A),
          title: const Text('Delete Dream', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to delete this dream? This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
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
                setState(() {
                  dreams.removeWhere((d) => d.id == selectedDream!.id);
                  showDetails = false;
                  selectedDream = null;
                });
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

