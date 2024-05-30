// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class LoadPosting {
  final String loadType;
  final String loadingAddress;
  final String destinationAddress;
  final DateTime deliveryDate;
  final double weight;
  LoadPosting({
    required this.loadType,
    required this.loadingAddress,
    required this.destinationAddress,
    required this.deliveryDate,
    required this.weight,
  });

  factory LoadPosting.fromMap(Map<String, dynamic> data) {
    return LoadPosting(
      loadType: data['loadType'] ?? '',
      loadingAddress: data['loadingAddress'] ?? '',
      destinationAddress: data['destinationAddress'] ?? '',
      deliveryDate: (data['deliveryDate'] as Timestamp).toDate(),
      weight: data['weight'] != null ? data['weight'].toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadType': loadType,
      'loadingAddress': loadingAddress,
      'destinationAddress': destinationAddress,
      'deliveryDate': Timestamp.fromDate(deliveryDate),
      'weight': weight,
    };
  }
}
