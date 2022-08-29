import 'package:flutter/material.dart';

class AnimationExamplesPage extends StatefulWidget {
  const AnimationExamplesPage({Key? key}) : super(key: key);

  @override
  State<AnimationExamplesPage> createState() => _AnimationExamplesPage();
}

class _AnimationExamplesPage extends State<AnimationExamplesPage>
    with TickerProviderStateMixin {
  late final controller = AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this);
  late final animation =
      CurvedAnimation(parent: controller, curve: Curves.easeIn)
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              // controller.forward();
            }
          },
        );

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Examples'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('This text will be blinked'),
              AnimatedLogo(
                animation: animation,
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    controller.forward();
                  },
                  child: const Text('Blink')),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
