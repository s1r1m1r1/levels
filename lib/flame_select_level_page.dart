import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/experimental.dart' as flameExp;
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:levels/sandbox/camera_and_viewport/camera_component_example.dart';
import 'package:levels/sandbox/camera_and_viewport/camera_component_properties_example.dart';
import 'package:levels/sandbox/camera_and_viewport/camera_follow_and_world_bounds.dart';
import 'package:levels/sandbox/camera_and_viewport/coordinate_systems_example.dart';
import 'package:levels/sandbox/camera_and_viewport/fixed_resolution_example.dart';
import 'package:levels/sandbox/camera_and_viewport/static_components_example.dart';
import 'package:levels/sandbox/camera_and_viewport/zoom_example.dart';
import 'package:levels/sandbox/examples/small_parallax_example.dart';
import 'package:levels/sandbox/input/scroll_example.dart';

class FlameSelectLevelPage extends StatelessWidget {
  const FlameSelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: SelectLevelGame(),
        // game: SmallParallaxExample()
        // game: CameraComponentExample()
        // game: CameraComponentPropertiesExample()
        // game: CameraFollowAndWorldBoundsExample()
        // game: CoordinateSystemsExample()
        // game: StaticComponentsExample(viewportResolution: Vector2.all(500))
        // game: ZoomExample(viewportResolution: Vector2.all(500))
        // game: ScrollExample()
      ),
    );
  }
}

class SelectLevelGame extends FlameGame with ScrollDetector {
  static const speed = 2000.0;

  @override
  void onScroll(PointerScrollInfo info) {
    camera.stop();
    camera.viewfinder.add(MoveToEffect(
        camera.viewfinder.position
            .clone()
            .translated(info.scrollDelta.global.x, info.scrollDelta.global.y),
        EffectController(speed: speed)));

    debugPrint("CAMERA pos:2 ${camera.viewfinder.position}");
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  FutureOr<void> onLoad() async {
    final bg = SpriteComponent(
      sprite: await loadSprite('stage/01/layers/l2_ground.png'),
      // size: Vector2(1536 , 2048),
    );
    bg.addAll(
      [
        AlignComponent(
          alignment: Anchor(0.65, 0.08),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
            // position: Vector2(paddingStep * 10, verticalPadding * 2),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.25, 0.3),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
            // position: Vector2(paddingStep * 10, verticalPadding * 2),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.62, 0.43),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
            // position: Vector2(paddingStep * 10, verticalPadding * 2),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.64, 0.67),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
            // position: Vector2(paddingStep * 10, verticalPadding * 2),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.44, 0.9), // 0.5,0.9
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
            // position: Vector2(paddingStep * 10, verticalPadding * 2),
          ),
        ),
      ],
    );

    world.add(bg);
    final inset = camera.viewport.virtualSize;
    camera.setBounds(
      flameExp.Rectangle.fromRect(
        Rect.fromLTWH(
          inset.x / 2,
          inset.y / 2,
          (bg.size.x) - inset.x,
          (bg.size.y) - inset.y,
        ),
      ),
    );
    return super.onLoad();
  }
}
