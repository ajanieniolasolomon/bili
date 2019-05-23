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
    '',
    'Terms and Condition',
    'This app is part of a research to learn effective way to encourage voluntary self among youth.If you wish to participate click the forward arrow OR swip left',
  ),
  OnboardPageModel(
    Color(0xFF005699),
    Color(0xFFFFE074),
    Color(0xFF39393A),
    2,
    'assets/illustration.png',
    '',
    'STEP 1',
    'Take the self testing kit and srub round the upper part of your teeth',
  ),
  OnboardPageModel(
    Color(0xFFFFE074),
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    0,
    'assets/illustration2.png',
    '',
    'STEP 2',
    'Place the oralkit inside the oralquick solution and what for 20min',
  ),
  OnboardPageModel(
    Color(0xFF39393A),
    Color(0xFFE6E6E6),
    Color(0xFF005699),
    1,
    'assets/illustration3.png',
    '',
    'STEP 3',
    'Please click the button below indicating what you saw .',
  ),
]; 