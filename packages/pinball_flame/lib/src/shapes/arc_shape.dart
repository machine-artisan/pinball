import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:geometry/geometry.dart';
import 'package:vector_math/vector_math_64.dart' as vm64;

/// {@template arc_shape}
/// Creates an arc.
/// {@endtemplate}
class ArcShape extends ChainShape {
  /// {@macro arc_shape}
  ArcShape({
    required this.center,
    required this.arcRadius,
    required this.angle,
    this.rotation = 0,
  }) {
    // forge2d's [Vector2] (from package:vector_math/vector_math.dart) and
    // geometry's [Vector2] (from package:vector_math/vector_math_64.dart)
    // are distinct types, so the arc points must be converted at this
    // boundary.
    final points = calculateArc(
      center: vm64.Vector2(center.x, center.y),
      radius: arcRadius,
      angle: angle,
      offsetAngle: rotation,
    );
    createChain(points.map((p) => Vector2(p.x, p.y)).toList());
  }

  /// The center of the arc.
  final Vector2 center;

  /// The radius of the arc.
  final double arcRadius;

  /// Specifies the size of the arc, in radians.
  ///
  /// For example, two pi returns a complete circumference.
  final double angle;

  /// Angle in radians to rotate the arc around its [center].
  final double rotation;
}
