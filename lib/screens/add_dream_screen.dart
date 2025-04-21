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
  
  // Add focus nodes to track focus state
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listeners to rebuild when focus changes
    _titleFocusNode.addListener(() {
      setState(() {});
    });
    _descriptionFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // Dispose focus nodes
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(title: const Text('Add Dream'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name this dream', style: AppTheme.subheadingStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                cursorColor: Color.fromARGB(255, 46, 42, 148),
                cursorWidth: 2.5,
                cursorHeight: 24.0,
                showCursor: true,
                cursorRadius: Radius.circular(1.0),
                decoration: InputDecoration(
                  // Only show hint text when not focused
                  hintText: _titleFocusNode.hasFocus ? '' : 'Enter a title for your dream',
                  border: OutlineInputBorder(),
                  // Change the border color when focused
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 46, 42, 148),
                      width: 2.0,
                    ),
                  ),
                  // Optional: you can also change the fill color when focused
                  fillColor: _titleFocusNode.hasFocus 
                      ? Color(0xFF201E66).withOpacity(0.05)
                      : Colors.transparent,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text('What was it about?', style: AppTheme.subheadingStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                cursorColor: Color.fromARGB(255, 46, 42, 148),
                cursorWidth: 2.5,
                cursorHeight: 24.0,
                showCursor: true,
                cursorRadius: Radius.circular(1.0),
                decoration: InputDecoration(
                  // Only show hint text when not focused
                  hintText: _descriptionFocusNode.hasFocus ? '' : 'Describe your dream',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  // Change the border color when focused
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 46, 42, 148),
                      width: 2.0,
                    ),
                  ),
                  // Optional: you can also change the fill color when focused
                  fillColor: _descriptionFocusNode.hasFocus 
                      ? Color(0xFF201E66).withOpacity(0.05)
                      : Colors.transparent,
                  filled: true,
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
                  Text('I felt', style: AppTheme.subheadingStyle),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMoodOption('happy'),
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
                    backgroundColor: Color(0xFF201E66),
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
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image.asset('images/mood_$mood.png', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 200), // Animation duration
            style: TextStyle(
              fontSize: isSelected ? 16 : 15, // Slightly larger when selected
              color: isSelected
                  ? const Color.fromARGB(255, 49, 45, 156)
                  : AppTheme.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(mood[0].toUpperCase() + mood.substring(1)),
          )
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
