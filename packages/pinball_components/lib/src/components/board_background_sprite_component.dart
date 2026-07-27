import 'package:flame/components.dart';
import 'package:pinball_components/pinball_components.dart';
import 'package:pinball_flame/pinball_flame.dart';

class BoardBackgroundSpriteComponent extends SpriteComponent
    with HasGameReference, ZIndex {
  BoardBackgroundSpriteComponent()
      : super(
          anchor: Anchor.center,
          position: Vector2(-0.2, 0.1),
        ) {
    zIndex = ZIndexes.boardBackground;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sprite = Sprite(
      game.images.fromCache(
        Assets.images.boardBackground.keyName,
      ),
    );
    this.sprite = sprite;
    size = sprite.originalSize / 10;
  }
}
