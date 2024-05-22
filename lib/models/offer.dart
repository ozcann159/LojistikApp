class Offer {
  final String id;
  final String loadPostingId;
  final String userId;
  final double price;
  final String status;

  Offer({
    required this.id,
    required this.loadPostingId,
    required this.userId,
    required this.price,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loadPostingId': loadPostingId,
      'userId': userId,
      'price': price,
      'status': status,
    };
  }

  static Offer fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'],
      loadPostingId: map['loadPostingId'],
      userId: map['userId'],
      price: map['price'],
      status: map['status'],
    );
  }
}
