import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:geometry/geometry.dart';
import 'package:vector_math/vector_math_64.dart' as vm64;

/// {@template ellipse_shape}
/// Creates an ellipse.
/// {@endtemplate}
class EllipseShape extends ChainShape {
  /// {@macro ellipse_shape}
  EllipseShape({
    required this.center,
    required this.majorRadius,
    required this.minorRadius,
  }) {
    // forge2d's [Vector2] and geometry's [Vector2] are distinct types (see
    // arc_shape.dart), so the ellipse points must be converted at this
    // boundary.
    final points = calculateEllipse(
      center: vm64.Vector2(center.x, center.y),
      majorRadius: majorRadius,
      minorRadius: minorRadius,
    );
    createChain(points.map((p) => Vector2(p.x, p.y)).toList());
  }

  /// The top left corner of the ellipse.
  ///
  /// Where the initial painting begins.
  final Vector2 center;

  /// Major radius is specified by [majorRadius].
  final double majorRadius;

  /// Minor radius is specified by [minorRadius].
  final double minorRadius;

  /// Rotates the ellipse by a given [angle] in radians.
  void rotate(double angle) {
    for (final vector in vertices) {
      vector.rotate(angle);
    }
  }
}
