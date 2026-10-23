enum Severity { critical, high, medium, low }

final class StockAlert {
  const StockAlert({
    required this.id,
    required this.medicineNameEn,
    required this.medicineNameAr,
    required this.severity,
    required this.daysOfCover,
    required this.branchCode,
    this.acknowledged = false,
  });

  final String id;
  final String medicineNameEn;
  final String medicineNameAr;
  final Severity severity;
  final double daysOfCover;
  final String branchCode;
  final bool acknowledged;

  factory StockAlert.fromJson(Map<String, Object?> json) {
    // 1. id
    final rawId = json['id'];
    if (rawId is! String || rawId.trim().isEmpty) {
      throw const FormatException('Invalid or missing id');
    }

    // 2. medicineNameEn
    final rawNameEn = json['medicineNameEn'];
    if (rawNameEn is! String || rawNameEn.trim().isEmpty) {
      throw const FormatException('Invalid or missing medicineNameEn');
    }

    // 3. medicineNameAr
    final rawNameAr = json['medicineNameAr'];
    if (rawNameAr is! String || rawNameAr.trim().isEmpty) {
      throw const FormatException('Invalid or missing medicineNameAr');
    }

    // 4. branchCode
    final rawBranch = json['branchCode'];
    if (rawBranch is! String || rawBranch.trim().isEmpty) {
      throw const FormatException('Invalid or missing branchCode');
    }

    // 5. severity
    final rawSeverity = json['severity'];
    if (rawSeverity is! String) {
      throw const FormatException('Invalid or missing severity');
    }
    Severity severity;
    switch (rawSeverity.toLowerCase().trim()) {
      case 'critical':
        severity = Severity.critical;
        break;
      case 'high':
        severity = Severity.high;
        break;
      case 'medium':
        severity = Severity.medium;
        break;
      case 'low':
        severity = Severity.low;
        break;
      default:
        throw FormatException('Unknown severity: $rawSeverity');
    }

    // 6. daysOfCover
    final rawDays = json['daysOfCover'];
    double daysOfCover;
    if (rawDays is int) {
      daysOfCover = rawDays.toDouble();
    } else if (rawDays is double) {
      daysOfCover = rawDays;
    } else {
      throw const FormatException('Invalid or missing daysOfCover');
    }
    if (daysOfCover < 0) {
      throw const FormatException('daysOfCover must be >= 0');
    }

    // 7. acknowledged (optional)
    bool acknowledged = false;
    if (json.containsKey('acknowledged') && json['acknowledged'] != null) {
      final rawAck = json['acknowledged'];
      if (rawAck is! bool) {
        throw const FormatException('acknowledged must be a bool');
      }
      acknowledged = rawAck;
    }

    return StockAlert(
      id: rawId,
      medicineNameEn: rawNameEn,
      medicineNameAr: rawNameAr,
      severity: severity,
      daysOfCover: daysOfCover,
      branchCode: rawBranch,
      acknowledged: acknowledged,
    );
  }

  StockAlert copyWith({
    String? id,
    String? medicineNameEn,
    String? medicineNameAr,
    Severity? severity,
    double? daysOfCover,
    String? branchCode,
    bool? acknowledged,
  }) {
    return StockAlert(
      id: id ?? this.id,
      medicineNameEn: medicineNameEn ?? this.medicineNameEn,
      medicineNameAr: medicineNameAr ?? this.medicineNameAr,
      severity: severity ?? this.severity,
      daysOfCover: daysOfCover ?? this.daysOfCover,
      branchCode: branchCode ?? this.branchCode,
      acknowledged: acknowledged ?? this.acknowledged,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StockAlert &&
        other.id == id &&
        other.medicineNameEn == medicineNameEn &&
        other.medicineNameAr == medicineNameAr &&
        other.severity == severity &&
        other.daysOfCover == daysOfCover &&
        other.branchCode == branchCode &&
        other.acknowledged == acknowledged;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      medicineNameEn,
      medicineNameAr,
      severity,
      daysOfCover,
      branchCode,
      acknowledged,
    );
  }
}