import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';
import 'package:flutter/foundation.dart';
import '../../../data/repositories/alert_repository.dart';


class AlertsViewModel extends ChangeNotifier {
  AlertsViewModel({required AlertRepository repository})
      : _repository = repository;

  final AlertRepository _repository;

  bool _loading = false;
  @override
  bool get loading => _loading;

  List<StockAlert> _allAlerts = [];
  
  final Set<Severity> _activeFilters = {};
  Set<Severity> get activeFilters => Set.unmodifiable(_activeFilters);

  String _query = '';

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    try {
      _allAlerts = await _repository.fetchAlerts();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<StockAlert> get visibleAlerts {
    var filtered = _allAlerts.where((alert) {
      if (_activeFilters.isNotEmpty && !_activeFilters.contains(alert.severity)) {
        return false;
      }
      return _matchesSearch(alert, _query);
    }).toList();

    filtered.sort((a, b) {
      // 1. unacknowledged before acknowledged
      if (a.acknowledged != b.acknowledged) {
        return a.acknowledged ? 1 : -1;
      }

      // 2. severity order: critical, high, medium, low
      const severityOrder = {
        Severity.critical: 0,
        Severity.high: 1,
        Severity.medium: 2,
        Severity.low: 3,
      };
      final sevCompare = severityOrder[a.severity]!.compareTo(severityOrder[b.severity]!);
      if (sevCompare != 0) return sevCompare;

      // 3. daysOfCover ascending
      final daysCompare = a.daysOfCover.compareTo(b.daysOfCover);
      if (daysCompare != 0) return daysCompare;

      // 4. medicineNameEn A-Z ignoring case
      return a.medicineNameEn.toLowerCase().compareTo(b.medicineNameEn.toLowerCase());
    });

    return List.unmodifiable(filtered);
  }

  List<StockAlert> get visibleAlertsUnmodifiable => visibleAlerts;

  void toggleFilter(Severity severity) {
    if (_activeFilters.contains(severity)) {
      _activeFilters.remove(severity);
    } else {
      _activeFilters.add(severity);
    }
    notifyListeners();
  }

  void setQuery(String query) {
    final normalizedNew = _normalize(query);
    final normalizedOld = _normalize(_query);

    if (normalizedNew == normalizedOld) {
      return;
    }

    _query = query;
    notifyListeners();
  }

  Future<void> acknowledge(String id) async {
    final index = _allAlerts.indexWhere((a) => a.id == id);
    if (index == -1) return;

    await _repository.acknowledge(id);
    _allAlerts[index] = _allAlerts[index].copyWith(acknowledged: true);
    notifyListeners();
  }

  int get unacknowledgedCriticalCount {
    return _allAlerts.where((a) => !a.acknowledged && a.severity == Severity.critical).length;
  }

  bool _matchesSearch(StockAlert alert, String rawQuery) {
    final normQuery = _normalize(rawQuery);
    if (normQuery.isEmpty) return true;

    final normEn = _normalize(alert.medicineNameEn);
    final normAr = _normalize(alert.medicineNameAr);

    return normEn.contains(normQuery) || normAr.contains(normQuery);
  }

  String _normalize(String input) {
    var text = input.toLowerCase().trim();
    
    // Arabic normalisation rules
    text = text
        .replaceAll(RegExp(r'[أإآ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('\u0640', ''); // tatweel

    // Remove Arabic diacritics (harakat, tanween, shadda, sukun: U+064B to U+0652)
    text = text.replaceAll(RegExp(r'[\u064B-\u0652]'), '');

    return text;
  }
}