import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id; // Document ID
  final String? brandGuideLines;
  final String? budget;
  final String? businessGoals;
  final DateTime? createdTime;
  final String? dateLaunchTime;
  final List<String>? paidCampaigns;
  final List<String>? platforms;
  final String? status;
  final String? type;
  final String? uniqueSelling;
  final String? visionForMarketing;

  RequestModel({
    required this.id, // معرف المستند
    this.brandGuideLines,
    this.budget,
    this.businessGoals,
    this.createdTime,
    this.dateLaunchTime,
    this.paidCampaigns,
    this.platforms,
    this.status,
    this.type,
    this.uniqueSelling,
    this.visionForMarketing,
  });

  factory RequestModel.fromMap(Map<String, dynamic> map, String documentId) {
    return RequestModel(
      id: documentId, // تمرير ID المستند
      brandGuideLines: map['brandGuideLines'],
      budget: map['budget'],
      businessGoals: map['businessGoals'],
      createdTime: map['createdTime'] != null
          ? (map['createdTime'] as Timestamp).toDate()
          : null,
      dateLaunchTime: map['dateLaunchTime'],
      paidCampaigns: List<String>.from(map['paidCampaigns'] ?? []),
      platforms: List<String>.from(map['platforms'] ?? []),
      status: map['status'],
      type: map['type'],
      uniqueSelling: map['uniqueSelling'],
      visionForMarketing: map['visionForMarketing'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandGuideLines': brandGuideLines,
      'budget': budget,
      'businessGoals': businessGoals,
      'createdTime': createdTime,
      'dateLaunchTime': dateLaunchTime,
      'paidCampaigns': paidCampaigns,
      'platforms': platforms,
      'status': status,
      'type': type,
      'uniqueSelling': uniqueSelling,
      'visionForMarketing': visionForMarketing,
    };
  }
}
