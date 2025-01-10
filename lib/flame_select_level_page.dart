import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/experimental.dart' as flameExp;
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class FlameSelectLevelPage extends StatelessWidget {
  const FlameSelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: SelectLevelGame(),
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
          alignment: Anchor(0.6, 0.03),
          child: SelectLevelButton(
            number: "11",
            status: LevelStatus.disabled,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.56, 0.12),
          child: SelectLevelButton(
            number: "10",
            status: LevelStatus.disabled,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.52, 0.21),
          child: SelectLevelButton(
            number: "9",
            status: LevelStatus.disabled,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.48, 0.31),
          child: SelectLevelButton(
            number: "8",
            status: LevelStatus.enabled,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.59, 0.39),
          child: SelectLevelButton(
            number: "7",
            status: LevelStatus.star2,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.6, 0.49),
          child: SelectLevelButton(
            number: "6",
            status: LevelStatus.star1,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.67, 0.58), // 0.5,0.9
          child: SelectLevelButton(
            number: "5",
            size: Vector2(100, 100),
            status: LevelStatus.star2,
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.7, 0.68),
          child: SelectLevelButton(
            number: "4",
            status: LevelStatus.star2,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.53, 0.74),
          child: SelectLevelButton(
            number: "3",
            status: LevelStatus.star3,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.46, 0.84),
          child: SelectLevelButton(
            number: "2",
            status: LevelStatus.star3,
            size: Vector2(100, 100),
          ),
        ),
        AlignComponent(
          alignment: Anchor(0.44, 0.93), // 0.5,0.9
          child: SelectLevelButton(
            number: "1",
            size: Vector2(100, 100),
            status: LevelStatus.star3,
          ),
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

enum LevelStatus {
  disabled,
  enabled,
  star1,
  star2,
  star3;

  String get asset => switch (this) {
        LevelStatus.disabled => "stage/Parts/buttons/button01.png",
        LevelStatus.enabled => "stage/Parts/buttons/button01.png",
        LevelStatus.star1 => "stage/Parts/buttons/button02.png",
        LevelStatus.star2 => "stage/Parts/buttons/button03.png",
        LevelStatus.star3 => "stage/Parts/buttons/button04.png",
      };
}

class SelectLevelButton extends AdvancedButtonComponent {
  final String number;
  final LevelStatus status;

  SelectLevelButton({
    required this.number,
    required this.status,
    super.position,
    super.size,
  }) : assert(RegExp(r'^[0-9]*$').hasMatch(number),
            "Oops! Only digits is allowed, your try use $number as String number, try fix it write correct number");

  @override
  AlignComponent labelAlignContainer =
      AlignComponent(alignment: Anchor(0.41, 0.4));

  String getNum(String character) {
    if (status == LevelStatus.disabled) {
      return switch (character) {
        "0" => 'stage/Parts/buttons/num00-gray.png',
        "1" => 'stage/Parts/buttons/num01-gray.png',
        "2" => 'stage/Parts/buttons/num02-gray.png',
        "3" => 'stage/Parts/buttons/num03-gray.png',
        "4" => 'stage/Parts/buttons/num04-gray.png',
        "5" => 'stage/Parts/buttons/num05-gray.png',
        "6" => 'stage/Parts/buttons/num06-gray.png',
        "7" => 'stage/Parts/buttons/num07-gray.png',
        "8" => 'stage/Parts/buttons/num08-gray.png',
        "9" => 'stage/Parts/buttons/num09-gray.png',
        _ => throw Exception('not expected symbol'),
      };
    }
    return switch (character) {
      "0" => 'stage/Parts/buttons/num00.png',
      "1" => 'stage/Parts/buttons/num01.png',
      "2" => 'stage/Parts/buttons/num02.png',
      "3" => 'stage/Parts/buttons/num03.png',
      "4" => 'stage/Parts/buttons/num04.png',
      "5" => 'stage/Parts/buttons/num05.png',
      "6" => 'stage/Parts/buttons/num06.png',
      "7" => 'stage/Parts/buttons/num07.png',
      "8" => 'stage/Parts/buttons/num08.png',
      "9" => 'stage/Parts/buttons/num09.png',
      _ => throw Exception('not expected symbol'),
    };
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteNum = await Future.wait(
      number.characters.map((i) => Sprite.load(getNum(i))),
    );
    final skinAsset = await Sprite.load(status.asset);

    defaultLabel = RectangleComponent(children: [
      ...spriteNum.mapIndexed((index, sprite) => SpriteComponent(
            size: Vector2.all(16),
            position:
                Vector2(-number.length * 10, 0) + Vector2(20.0 * index, 0),
            sprite: sprite,
          ))
    ]);

    defaultSkin = SpriteComponent(
      // size: Vector2.all(20),
      sprite: skinAsset,
    );
    if (status == LevelStatus.disabled) {
      defaultSkin?.decorator = PaintDecorator.grayscale(opacity: 0.3);
    }
    if (status != LevelStatus.disabled) {
      hoverSkin = SpriteComponent(
        sprite: skinAsset,
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
          sprite: await Sprite.load('stage/Parts/buttons/button04.png'));
    }
  }
}
