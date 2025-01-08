
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return const _LevelPart();
        },
      ),
    );
  }
}

class _LevelPart extends StatelessWidget {
  const _LevelPart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stage/01/layers/l1_sky.png'),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1536 / 2048,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final btnWidth = width * .1;
              final btnHeight = btnWidth;
              final paddingStep = width * .02;
              final verticalPadding = btnHeight;

              return Stack(
                fit: StackFit.expand,
                children: [
                  const Image(
                    image: AssetImage('assets/images/stage/01/layers/l2_ground.png'),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: paddingStep * 20,
                    bottom: verticalPadding * 1.6,
                    width: btnWidth,
                    height: btnHeight,
                    child: LevelButton(
                      fixedSize: Size(btnWidth, btnHeight),
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    left: paddingStep * 29,
                    bottom: verticalPadding * 4.1,
                    width: btnWidth,
                    height: btnHeight,
                    child: LevelButton(
                      fixedSize: Size(btnWidth, btnHeight),
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    left: paddingStep * 28,
                    bottom: verticalPadding * 7.1,
                    width: btnWidth,
                    height: btnHeight,
                    child: Center(
                      child: LevelButton(
                        fixedSize: Size(btnWidth, btnHeight),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Positioned(
                    left: paddingStep * 16,
                    bottom: verticalPadding * 9,
                    width: btnWidth,
                    height: btnHeight,
                    child: LevelButton(
                      fixedSize: Size(btnWidth, btnHeight),
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    left: paddingStep * 28,
                    bottom: verticalPadding * 11.5,
                    width: btnWidth,
                    height: btnHeight,
                    child: LevelButton(
                      onTap: () {},
                      fixedSize: Size(btnWidth, btnHeight),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum LevelStatus { enable, disable, oneStar, twoStar, threeStar }

class LevelButton extends StatelessWidget {
  const LevelButton({
    super.key,
    required this.onTap,
    this.status = LevelStatus.disable,
    required this.fixedSize,
  });
  final VoidCallback onTap;
  final LevelStatus status;
  final Size fixedSize;
  @override
  Widget build(BuildContext context) {
    final assetPath = switch (status) {
      LevelStatus.enable => 'stage/Parts/buttons/button01.png',
      LevelStatus.disable => 'stage/Parts/buttons/button01.png',
      LevelStatus.oneStar => 'stage/Parts/buttons/button02.png',
      LevelStatus.twoStar => 'stage/Parts/buttons/button03.png',
      LevelStatus.threeStar => 'stage/Parts/buttons/button04.png',
    };
    return SpriteButton.asset(
      path: assetPath,
      pressedPath: assetPath,
      onPressed: () {},
      width: fixedSize.width,
      height: fixedSize.height,
      label: SizedBox(),
    );
    // return TextButton(
    //   style: TextButton.styleFrom(
    //     fixedSize: fixedSize,
    //     padding: EdgeInsets.zero,
    //     // enableFeedback: false,
    //     splashFactory: NoSplash.splashFactory,
    //     surfaceTintColor: Colors.transparent,
    //     overlayColor: Colors.transparent,
    //     shadowColor: Colors.transparent,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(4),
    //       ),
    //     ),
    //     backgroundBuilder: (context, states, _) {
    //       final inkImage = Ink.image(fit: BoxFit.cover, image: image);
    //       return TweenAnimationBuilder(
    //           tween: Tween<double>(
    //               begin: 0,
    //               end: states.contains(WidgetState.pressed) ? 1.0 : 0.0),
    //           duration: const Duration(milliseconds: 100),
    //           child: inkImage,
    //           builder: (context, anim, child) {
    //             return SizedBox.expand(
    //               child: Padding(
    //                 padding: EdgeInsets.lerp(
    //                     EdgeInsets.zero, const EdgeInsets.all(8), anim)!,
    //                 child: Image,
    //               ),
    //             );
    //           });
    //     },
    //   ),
    //   onPressed: () {},
    //   child: const SizedBox(),
    // );
  }
}
