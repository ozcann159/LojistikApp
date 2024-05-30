// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final String surname;
  final String email;
  final String userType;
  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      surname: json["surname"],
      email: json['email'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'userType': userType,
      // Diğer parametreler buraya eklenir
    };
  }
}

final String userCollection = 'users';
