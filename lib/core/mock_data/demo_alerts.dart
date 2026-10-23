import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';

const List<StockAlert> demoAlerts = [
  StockAlert(
    id: 'insulin',
    medicineNameEn: 'Insulin glargine',
    medicineNameAr: 'انسولين جلارجين',
    severity: Severity.critical,
    daysOfCover: 2,
    branchCode: 'CAI-014',
  ),
  StockAlert(
    id: 'levo',
    medicineNameEn: 'Levothyroxine 50 mcg',
    medicineNameAr: 'ليفوثيروكسين ٥٠ ميكروجرام',
    severity: Severity.high,
    daysOfCover: 6,
    branchCode: 'CAI-014',
  ),
  StockAlert(
    id: 'amox',
    medicineNameEn: 'Amoxicillin syrup',
    medicineNameAr: 'شراب أموكسيسيلين',
    severity: Severity.medium,
    daysOfCover: 9,
    branchCode: 'CAI-014',
  ),
  StockAlert(
    id: 'vitd',
    medicineNameEn: 'Vitamin D3 drops',
    medicineNameAr: 'نقط فيتامين د',
    severity: Severity.low,
    daysOfCover: 30,
    branchCode: 'CAI-014',
  ),
];
