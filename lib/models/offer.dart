class Offer {
  final String id;
  final String loadPostingId;
  final String offerAmount;
  final String deliveryTime;
  final String contactInfo;

  Offer({
    required this.id,
    required this.loadPostingId,
    required this.offerAmount,
    required this.deliveryTime,
    required this.contactInfo,
  });

  factory Offer.fromMap(Map<String, dynamic> data) {
    return Offer(
      id: data['id'] ?? '',
      loadPostingId: data['loadPostingId'] ?? '',
      offerAmount: data['offerAmount'] ?? '',
      deliveryTime: data['deliveryTime'] ?? '',
      contactInfo: data['contactInfo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loadPostingId': loadPostingId,
      'offerAmount': offerAmount,
      'deliveryTime': deliveryTime,
      'contactInfo': contactInfo,
    };
  }
}
