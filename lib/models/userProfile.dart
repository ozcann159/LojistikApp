class UserProfile {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String role; //Taşıyıcı - Taşıtan
  final String? driverLicenseType;
  final String? truckType;
  final List<String> reviews;
  final List<String>? loadOffers;

  UserProfile(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.role,
      required this.driverLicenseType,
      required this.truckType,
      required this.reviews,
      required this.loadOffers}); //Teklifler

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
        id: data['id'],
        name: data['name'],
        surname: data['surname'],
        email: data['email'],
        role: data['role'],
        driverLicenseType: data['driverLicenseType'],
        truckType: data['truckType'],
        reviews: List<String>.from(data['reviews'] ?? []),
        loadOffers: List<String>.from(data['loadOffers'] ?? []));
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'name': name,
      'surname': surname,
      'email': email,
      'role': role,
      'driverLicenseType':driverLicenseType,
      'truckType':truckType,
      'reviews':reviews,
      'loadOffers':loadOffers,
    };
  }
}
