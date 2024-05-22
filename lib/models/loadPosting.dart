class LoadPosting {
  final String id;
  final String title;
  final String description;
  final String origin;
  final String destination;
  final DateTime date;

  LoadPosting({
    required this.id,
    required this.title,
    required this.description,
    required this.origin,
    required this.destination,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'origin': origin,
      'destination': destination,
      'date': date.toIso8601String(),
    };
  }

  static LoadPosting fromMap(Map<String, dynamic> map) {
    return LoadPosting(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      origin: map['origin'],
      destination: map['destination'],
      date: DateTime.parse(map['date']),
    );
  }
}
