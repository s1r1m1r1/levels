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

class FlameSelectLevelPage extends StatelessWidget {
  const FlameSelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: SelectLevelGame(),
        // game: AdvancedButtonExample(),
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
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.25, 0.3),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.62, 0.43),
          child: SpriteComponent(
            sprite: await loadSprite('stage/Parts/buttons/button02.png'),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.64, 0.67),
          child: DefaultButton("1", size: Vector2(100, 100)),
        ),
        AlignComponent(
          alignment: Anchor(0.44, 0.9), // 0.5,0.9
          child: ToggleButton(size: Vector2(250, 50)),
          // SpriteComponent(
          //   sprite: await loadSprite('stage/Parts/buttons/button02.png'),
          // ),
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

class ToggleButton extends ToggleButtonComponent {
  ToggleButton({super.position, super.size});

  @override
  int get priority => 100;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    defaultLabel = TextComponent(
      text: 'Toggle button',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 24,
          color: BasicPalette.white.color,
        ),
      ),
    );

    defaultSelectedLabel = TextComponent(
      text: 'Toggle button',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 24,
          color: BasicPalette.red.color,
        ),
      ),
    );

    defaultSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 200, 0, 1));

    hoverSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 180, 0, 1));

    downSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 100, 0, 1));

    defaultSelectedSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 0, 200, 1));

    hoverAndSelectedSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 0, 180, 1));

    downAndSelectedSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(0, 0, 100, 1));
  }
}

class DefaultButton extends AdvancedButtonComponent {
  final String number;
  DefaultButton(
    this.number, {
    super.position,
    super.size,
  });

  @override
  AlignComponent labelAlignContainer =
      AlignComponent(alignment: Anchor(0.4, 0.5));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final paint = Paint()
      ..color = const Color(0xff39FF14)
      ..style = PaintingStyle.stroke;

    // add(
    //   CircleComponent(
    //     radius: 50,
    //     position: Vector2(300, 400),
    //     paint: paint,
    //   )..add(
    //       GlowEffect(
    //         10.0,
    //         EffectController(
    //           duration: 3,
    //           reverseDuration: 1.5,
    //           infinite: true,
    //         ),
    //       ),
    //     ),
    // );
    defaultLabel = SpriteComponent(
        size: Vector2.all(10),
        sprite: await Sprite.load('stage/Parts/buttons/num01.png'));

    // disabledSkin = SpriteComponent(
    // sprite: await Sprite.load('stage/Parts/buttons/num02-gray.png'));

    defaultSkin = SpriteComponent(
      // size: Vector2.all(20),
      sprite: await Sprite.load('stage/Parts/buttons/button02.png'),
    );

    hoverSkin = SpriteComponent(
      sprite: await Sprite.load('stage/Parts/buttons/button02.png'),
    )..add(
        SpriteAnimationComponent(
          position: Vector2(-155, -140),
          size: Vector2(400, 400),
          // anchor: Anchor(0.2, 0.2),
          animation: SpriteAnimation.spriteList(
              await Future.wait(List.generate(
                60,
                (i) => Sprite.load(
                    'auras/001_fire/001_FX_00${'$i'.padLeft(2, '0')}.png'),
              )),
              stepTime: 0.016),
        ),
      );
    downSkin = SpriteComponent(
        // size: Vector2.all(40),
        sprite: await Sprite.load('stage/Parts/buttons/button04.png'));
  }
}

class DisableButton extends AdvancedButtonComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    disabledLabel = TextComponent(text: 'Disabled button');

    // defaultSkin = SpriteComponent(
    // sprite: await Sprite.loadSprite('stage/Parts/buttons/button02.png'),
    // );

    disabledSkin = RoundedRectComponent()
      ..setColor(const Color.fromRGBO(100, 100, 100, 1));
  }
}

class RoundedRectComponent extends PositionComponent with HasPaint {
  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        0,
        0,
        width,
        height,
        topLeft: Radius.circular(height),
        topRight: Radius.circular(height),
        bottomRight: Radius.circular(height),
        bottomLeft: Radius.circular(height),
      ),
      paint,
    );
  }
}
