class Shipper {
  final String company;
  final String city;
  final String contactNumber;
  final String userId;

  Shipper({
    required this.company,
    required this.city,
    required this.contactNumber,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'city': city,
      'contactNumber': contactNumber,
      'userId': userId,
    };
  }

  factory Shipper.fromMap(Map<String, dynamic> map) {
    return Shipper(
      company: map['company'] ?? '',
      city: map['city'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
