import 'package:gym_gemini_pro/features/settings/models/settings_state.dart';

class WeightConverter {
  /// Converts weight from storage (KG) to display (KG/LBS)
  static double toDisplay(double kg, WeightUnit unit) {
    if (unit == WeightUnit.kg) return kg;
    return kg * 2.20462;
  }

  /// Converts weight from user input (KG/LBS) to storage (KG)
  static double toStorage(double displayValue, WeightUnit unit) {
    if (unit == WeightUnit.kg) return displayValue;
    return displayValue / 2.20462;
  }

  /// Formats a weight value for display with the appropriate unit label
  static String format(double kg, WeightUnit unit,
      {bool includeUnit = true, int decimals = 1}) {
    final value = toDisplay(kg, unit);
    final formattedValue = value.toStringAsFixed(decimals);
    if (!includeUnit) return formattedValue;

    final unitStr = unit == WeightUnit.kg ? 'kg' : 'lbs';
    return '$formattedValue $unitStr';
  }
}
