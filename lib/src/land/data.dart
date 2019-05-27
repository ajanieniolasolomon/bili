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
    Color(0xFF39393A),
    Color(0xFFFFE074),
    2,
    'assets/play.flr',
    'play',
    'Welcome to Bili',
    'Live life ,enjoy life(bili ke o bili)',
  ),
  OnboardPageModel(
    Color(0xFF39393A),
    Color(0xFFFF5252),
    Color(0xFF39393A),
    2,
    'assets/play.flr',
    'play',
    'Challenge',
    'Start a challenge and invite your friends to join in the challenge',
  ),
  OnboardPageModel(
    Color(0xFFFF5252),
    Color(0xFFE6E6E6),

    Color(0xFFE6E6E6),
    0,
    'assets/chall.flr',
    'post_challenge',
    'Upvote / Downvote',
    'Upvote or Downvote a challenge or trend',
  ),
  OnboardPageModel(
    Color(0xFFE6E6E6),
    Color(0xFF39393A),


    Color(0xFF005699),
    1,
    'assets/conn.flr',
    'conn',
    'Join the community',
    'let help you begin your journey',
  ),
]; 