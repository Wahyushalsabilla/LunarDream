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

  // Sample dreams for demo
  static List<Dream> sampleDreams = [
    Dream(
      id: '1',
      date: DateTime(2025, 3, 25),
      title: 'Taman peri',
      description: 'Pergi ke taman bunga membuatku sangat senang sekali. Aku bertemu dengan banyak bunga yang indah.',
      mood: 'happy',
    ),
    Dream(
      id: '2',
      date: DateTime(2025, 3, 27),
      title: 'Ketemu Ibuperi',
      description: 'Ibu peri datang ke mimpiku!',
      mood: 'scared',
    ),
  ];
}


