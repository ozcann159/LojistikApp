class LoadPosting {
  final String id;
  final String title;
  final String description;
  final String location;
  final String amount;

  LoadPosting({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.amount,
  });

  factory LoadPosting.fromMap(Map<String, dynamic> data) {
    return LoadPosting(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      amount: data['amount'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'amount': amount,
    };
  }
}
