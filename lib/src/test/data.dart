import 'dart:ui';

class OnboardPageModel {
  final Color primeColor;
  final Color accentColor;
  final Color nextAccentColor;
  final int pageNumber;
  final String imagePath;
  final String caption;
  final String subhead;
  final String description;

  OnboardPageModel(this.primeColor, this.accentColor, this.nextAccentColor, this.pageNumber, this.imagePath,
      this.caption, this.subhead, this.description);
}
List<OnboardPageModel> onboardData  = [
  OnboardPageModel(
    Color(0xFFE6E6E6),
    Color(0xFF005699),
    Color(0xFFFFE074),
    2,
    'assets/illustration.png',
    'EXPLORING',
    'FLUTTER',
    'On this channel we try and build fun stuff using Flutter and Dart. Subscribe for more content and let me know what you think in the comments!',
  ),
  OnboardPageModel(
    Color(0xFF005699),
    Color(0xFFFFE074),
    Color(0xFF39393A),
    2,
    'assets/illustration.png',
    'ANIMATING',
    'FLARE',
    'Making Flare animations and incorporating it into Flutter. Mobile animations have never been so easy!',
  ),
  OnboardPageModel(
    Color(0xFFFFE074),
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    0,
    'assets/illustration2.png',
    'DESIGN AND',
    'ANIMATION',
    'Recreating and imagining our own designs and animations ',
  ),
  OnboardPageModel(
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    Color(0xFF005699),
    1,
    'assets/illustration3.png',
    'EDUCATIONAL',
    'PROGRAMMING',
    'Learn coding with examples, in a fun, somewhat structured, way. Enjoy!',
  ),
]; 