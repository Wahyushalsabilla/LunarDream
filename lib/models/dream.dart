class Dream {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String mood; // 'happy', 'content', 'sad', 'angry', 'scared'

  Dream({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.mood,
  });

  Dream copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? description,
    String? mood,
  }) {
    return Dream(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      mood: mood ?? this.mood,
    );
  }

  // Empty sample dreams list
  static List<Dream> sampleDreams = [];
  
  // If you need to create sample dreams in the future, you can use this method
  static void createSampleDreams() {
    sampleDreams = [
      Dream(
        id: '1',
        date: DateTime.now(),
        title: 'Sample Dream',
        description: 'This is a sample dream.',
        mood: 'happy',
      ),
    ];
  }
}