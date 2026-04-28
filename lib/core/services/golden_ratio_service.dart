import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';

class GoldenRatioService {
  static const double phi = 1.618;

  /// Calculates ideal body measurements based on height (cm) and sex.
  /// Returns a Map<String, double> where keys match MetricConfig IDs.
  static Map<String, double> calculateTargets({
    required double heightCm,
    required BiologicalSex sex,
  }) {
    // Use the Steve Reeves Golden Ratio formula:
    // Chest = height × 0.818 (for males)
    // Waist = chest / phi  (approx. chest × 0.618)
    // Hips  = chest × 0.952 (approx.)
    // Shoulders = chest × 1.618 (for males) OR chest × 1.47 (females)
    // Neck  = chest × 0.370
    // Bicep (armLeft/armRight) = neck × phi × 0.5  → neck × 0.809
    // Forearm = bicep × 0.909
    // Thigh (thighLeft/thighRight) = bicep × 1.75
    // Calf (calfLeft/calfRight)  = bicep × 1.0 (roughly equal to bicep)
    //
    // Female adjustments (multiply male values by these factors):
    //   chest ×0.90, waist ×0.88, hips ×0.98, shoulders ×0.87, etc.

    // Refined multipliers based on height (cm) for an "Ideal/Golden Ratio" physique
    // These are derived from anthropometric standards (Reeves, classic bodybuilding)
    
    final bool isMale = sex == BiologicalSex.male;
    
    final double chest      = heightCm * (isMale ? 0.625 : 0.55);
    final double waist      = heightCm * (isMale ? 0.455 : 0.38);
    final double hips       = heightCm * (isMale ? 0.54 : 0.58);
    final double shoulders  = heightCm * (isMale ? 0.76 : 0.65);
    final double neck       = heightCm * (isMale ? 0.225 : 0.19);
    final double arm        = heightCm * (isMale ? 0.225 : 0.18);
    final double forearm    = arm * 0.82;
    final double thigh      = heightCm * (isMale ? 0.33 : 0.34);
    final double calf       = heightCm * (isMale ? 0.225 : 0.20);

    return {
      'chest':       _round(chest),
      'waist':       _round(waist),
      'hips':        _round(hips),
      'shoulders':   _round(shoulders),
      'neck':        _round(neck),
      'armLeft':     _round(arm),
      'armRight':    _round(arm),
      'forearmLeft': _round(forearm),
      'forearmRight':_round(forearm),
      'thighLeft':   _round(thigh),
      'thighRight':  _round(thigh),
      'calfLeft':    _round(calf),
      'calfRight':   _round(calf),
    };
  }

  static double _round(double v) => double.parse(v.toStringAsFixed(1));
}
