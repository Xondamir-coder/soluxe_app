import 'package:soluxe/models/hotel/hotel.dart';
import 'package:soluxe/models/hotel/hotel_amenity.dart';
import 'package:soluxe/models/hotel/hotel_comment.dart';
import 'package:soluxe/models/hotel/hotel_review.dart';
import 'package:soluxe/models/hotel/hotel_room.dart';

final images = [
  'https://images.pexels.com/photos/28124028/pexels-photo-28124028.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/30721324/pexels-photo-30721324.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  'https://images.pexels.com/photos/11906476/pexels-photo-11906476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/30824250/pexels-photo-30824250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/29434679/pexels-photo-29434679.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  'https://images.pexels.com/photos/11336249/pexels-photo-11336249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
];

final testHotelRoom = HotelRoom(
  title: 'Super Class',
  star: '2',
  price: '\$260',
  imgSrc:
      'https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=600',
  amenities: [
    HotelAmenity(iconPath: 'assets/icons/bed.svg', name: 'Queen Bed'),
    HotelAmenity(iconPath: 'assets/icons/cup.svg', name: 'Breakfast'),
  ],
);

final testHotelAmenities = [
  HotelAmenity(iconPath: 'assets/icons/park.svg', name: 'Parking Slot'),
  HotelAmenity(iconPath: 'assets/icons/breakfast.svg', name: 'Breakfast'),
  HotelAmenity(iconPath: 'assets/icons/wifi.svg', name: 'Free Wifi'),
  HotelAmenity(iconPath: 'assets/icons/date.svg', name: 'Concerts'),
];

final testHotelComment = HotelComment(
  imgSrc:
      'https://upload.wikimedia.org/wikipedia/commons/5/57/Scarlett_Johansson_by_Gage_Skidmore_2_%28cropped%29_%28cropped%29.jpg',
  name: 'Scarlett Johansson',
  dateString: DateTime.now().toIso8601String(),
  text:
      'Dictum ipsum scelerisque posuere adipiscing; tempor vestibulum ligula. Primis nunc vivamus eu eros malesuada',
);

final testSimilarHotel = HotelRoom(
  title: 'Super Class',
  star: '2',
  price: '\$260',
  imgSrc:
      'https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=600',
  amenities: [
    HotelAmenity(iconPath: 'assets/icons/bed.svg', name: 'Queen Bed'),
    HotelAmenity(iconPath: 'assets/icons/cup.svg', name: 'Breakfast'),
  ],
);

final testHotel = Hotel(
  averagePrice: '2 400 000 Sum',
  openingHours: 'Daily 10:00 - 23:00',
  phoneNumber: '+998 90 900 90 99',
  website: 'www.nihol.uz',
  review: HotelReview(
    rating: 4.6,
    ratingCount: 532,
    fiveStars: 400,
    fourStars: 100,
    threeStars: 20,
    twoStars: 6,
    oneStar: 6,
    fiveStarsPercentage: 0.8,
    fourStarsPercentage: 0.2,
    threeStarsPercentage: 0.0,
    twoStarsPercentage: 0.0,
    oneStarPercentage: 0.0,
  ),
  facilitiesIconPaths: ['assets/icons/park.svg', 'assets/icons/pool.svg'],
  similars: List.generate(2, (index) => testSimilarHotel),
  comments: List.generate(5, (index) => testHotelComment),
  images: images,
  description:
      'Dictum ipsum scelerisque posuere adipiscing; tempor vestibulum ligula. Primis nunc vivamus eu eros malesuada nostra per. Magna euismod euismod lobortis id risus quisque. Per sapien enim interdum iaculis cubilia eget magna felis',
  price: '\$260',
  rooms: List.generate(3, (index) => testHotelRoom),
  amenities: testHotelAmenities,
  title: 'A Cultural & Culinary Oasis: Taste Plov',
  star: '3',
  location: 'Tashkent',
  distance: '124',
  dateString: '2025-02-22T08:54:27.558Z',
  imgSrc:
      'https://images.pexels.com/photos/30824250/pexels-photo-30824250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
);

final hotels = List.generate(4, (index) => testHotel);
