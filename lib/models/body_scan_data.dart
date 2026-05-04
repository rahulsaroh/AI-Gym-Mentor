class BodyScanData {
  final String userName;
  final String gender;
  final int age;
  final DateTime scanDateTime;
  
  // Left side measurements
  final double leftBicep;
  final double leftBicepDelta;
  final double chest;
  final double chestDelta;
  final double waist;
  final double waistDelta;
  final double hips;
  final double hipsDelta;
  final double leftThigh;
  final double leftThighDelta;
  final double leftCalf;
  final double leftCalfDelta;
  
  // Right side measurements
  final double rightBicep;
  final double rightBicepDelta;
  final double rightThigh;
  final double rightThighDelta;
  final double rightCalf;
  final double rightCalfDelta;
  
  // Bottom data points
  final double bodyFat;
  final double leanMass;
  final double weight;
  
  final List<DateTime> scanHistory;

  BodyScanData({
    required this.userName,
    required this.gender,
    required this.age,
    required this.scanDateTime,
    required this.leftBicep,
    required this.leftBicepDelta,
    required this.chest,
    required this.chestDelta,
    required this.waist,
    required this.waistDelta,
    required this.hips,
    required this.hipsDelta,
    required this.leftThigh,
    required this.leftThighDelta,
    required this.leftCalf,
    required this.leftCalfDelta,
    required this.rightBicep,
    required this.rightBicepDelta,
    required this.rightThigh,
    required this.rightThighDelta,
    required this.rightCalf,
    required this.rightCalfDelta,
    required this.bodyFat,
    required this.leanMass,
    required this.weight,
    required this.scanHistory,
  });
}
