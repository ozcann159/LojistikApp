// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoadPosting {
  final String id;
  final String loadingAddress;
  final String destinationAddress;
  final String deliveryDate;

  LoadPosting({
    required this.id,
    required this.loadingAddress,
    required this.destinationAddress,
    required this.deliveryDate,
  });

  factory LoadPosting.fromMap(Map<String, dynamic> data) {
    return LoadPosting(
      id: data['id'] ?? '',
      loadingAddress: data['loadingAddress'] ?? '',
      destinationAddress: data['destinationAddress'] ?? '',
      deliveryDate: data['deliveryDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loadingAddress': loadingAddress,
      'destinationAddress': destinationAddress,
      'deliveryDate': deliveryDate,
    };
  }
}
