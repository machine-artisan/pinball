import 'package:flutter/material.dart';
import 'package:pinball/game/game.dart';
import 'package:pinball/l10n/l10n.dart';
import 'package:pinball_ui/pinball_ui.dart';

/// {@template launch_button_overlay}
/// [Widget] that renders an always-visible button to launch the ball.
///
/// Without this, the only way to launch the ball is tapping the rocket
/// sprite directly, which isn't discoverable and can render outside the
/// visible camera area on some aspect ratios.
/// {@endtemplate}
class LaunchButtonOverlay extends StatelessWidget {
  /// {@macro launch_button_overlay}
  const LaunchButtonOverlay({required this.game, Key? key}) : super(key: key);

  /// Game instance.
  final PinballGame game;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Unlike Play/Replay (shown once, at deliberate checkpoints), this
    // button reappears every ball/round, so it's kept noticeably smaller
    // than the full-size PinballButton the others use.
    return SizedBox(
      width: 120,
      height: 56,
      child: FittedBox(
        child: PinballButton(
          text: l10n.launch,
          onTap: game.launchBall,
        ),
      ),
    );
  }
}
