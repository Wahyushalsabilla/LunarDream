import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/dream.dart';
import '/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  // Make dreams list static so it can be accessed from other screens
  static List<Dream> dreams = Dream.sampleDreams;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dream? selectedDream;
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppTheme.primaryColor, 
      body: SafeArea(
        child: Column(
          children: [
            // App bar with logo on the right
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
              child: HomeScreen.dreams.isEmpty
                  ? _buildEmptyState()
                  : _buildDreamList(),
            ),
            
            // Dream details section (expandable)
            if (showDetails && selectedDream != null)
              _buildDreamDetails(),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF1A1F37),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomAppBar(
            height: 70,
            padding: EdgeInsets.zero,
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            color: const Color(0xFF1A1F37),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              // Left button - View Card Dream
Expanded(
  child: InkWell(
    onTap: () {
      // Already on dreams screen, no need to navigate
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.auto_stories,
          color: Color(0xFF394FAA),  // Highlight in blue to show active
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          'Dreams',
          style: TextStyle(
            color: Color(0xFF394FAA),  // Highlight in blue to show active
            fontSize: 12,
          ),
        ),
      ],
    ),
  ),
),
                // Spacer for FAB
                const Expanded(child: SizedBox()),
                
                // Right button - View Article
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/view-article');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.article_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Articles',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Floating action button untuk add dream
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color : Color(0xFF394FAA),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3148A1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            // Simpan hasil dari add dream screen
            final result = await Navigator.pushNamed(context, '/add-dream');
            
            // Update state jika ada dream baru
            if (result != null && result is Dream) {
              setState(() {
                HomeScreen.dreams.add(result);
              });
            }
          },
          backgroundColor: const Color.fromARGB(0, 205, 45, 45),
          elevation: 0,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              margin: const EdgeInsets.only(right: 10),
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
      itemCount: HomeScreen.dreams.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final dream = HomeScreen.dreams[index];
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
          color: isSelected ? const Color.fromARGB(255, 22, 38, 103) : Color.fromARGB(255, 21, 8, 82),
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
                      final index = HomeScreen.dreams.indexWhere((d) => d.id == selectedDream!.id);
                      if (index != -1) {
                        HomeScreen.dreams[index] = result;
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
                  HomeScreen.dreams.removeWhere((d) => d.id == selectedDream!.id);
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