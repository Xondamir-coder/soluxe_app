class HotelReview {
  final double rating;
  final int ratingCount;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStar;
  final double fiveStarsPercentage;
  final double fourStarsPercentage;
  final double threeStarsPercentage;
  final double twoStarsPercentage;
  final double oneStarPercentage;

  const HotelReview({
    required this.rating,
    required this.ratingCount,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStar,
    required this.fiveStarsPercentage,
    required this.fourStarsPercentage,
    required this.threeStarsPercentage,
    required this.twoStarsPercentage,
    required this.oneStarPercentage,
  });
}
