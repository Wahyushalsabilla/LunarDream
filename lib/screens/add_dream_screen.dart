import 'package:flutter/material.dart';
import '/models/dream.dart';
import '/theme/app_theme.dart';
import 'package:uuid/uuid.dart';

class AddDreamScreen extends StatefulWidget {
  const AddDreamScreen({super.key});

  @override
  State<AddDreamScreen> createState() => _AddDreamScreenState();
}

class _AddDreamScreenState extends State<AddDreamScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedMood = 'content';
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dream'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name this dream',
                style: AppTheme.subheadingStyle,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter a title for your dream',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'What was it about?',
                style: AppTheme.subheadingStyle,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Describe your dream...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Column(
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
                      _buildMoodOption('happy'),
                      _buildMoodOption('content'),
                      _buildMoodOption('sad'),
                      _buildMoodOption('angry'),
                      _buildMoodOption('scared'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Add a prominent Save Dream button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveDream,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Dream',
                    style: AppTheme.subheadingStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodOption(String mood) {
    final bool isSelected = _selectedMood == mood;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
              border: Border.all(
                color: isSelected ? const Color(0xFF011638) : AppTheme.secondaryTextColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(
                'images/mood_$mood.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mood.substring(0, 1).toUpperCase() + mood.substring(1),
            style: TextStyle(
              color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _saveDream() {
    if (_formKey.currentState!.validate()) {
      final newDream = Dream(
        id: const Uuid().v4(),
        date: DateTime.now(),
        title: _titleController.text,
        description: _descriptionController.text,
        mood: _selectedMood,
      );
      
      Navigator.pop(context, newDream);
    }
  }
}
