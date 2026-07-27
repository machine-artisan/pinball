import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:geometry/geometry.dart';
import 'package:vector_math/vector_math_64.dart' as vm64;

/// {@template bezier_curve_shape}
/// Creates a bezier curve.
/// {@endtemplate}
class BezierCurveShape extends ChainShape {
  /// {@macro bezier_curve_shape}
  BezierCurveShape({
    required this.controlPoints,
  }) {
    // forge2d's [Vector2] and geometry's [Vector2] are distinct types (see
    // arc_shape.dart), so the control points must be converted at this
    // boundary.
    final vm64ControlPoints =
        controlPoints.map((p) => vm64.Vector2(p.x, p.y)).toList();
    final points = calculateBezierCurve(controlPoints: vm64ControlPoints);
    createChain(points.map((p) => Vector2(p.x, p.y)).toList());
  }

  /// Specifies the control points of the curve.
  ///
  /// First and last [controlPoints] set the beginning and end of the curve,
  /// inner points between them set its final shape.
  final List<Vector2> controlPoints;
}
