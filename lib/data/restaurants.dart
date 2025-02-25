import 'package:soluxe/models/places.dart';

final testRestaurant = Places(
  averagePrice: '2 400 000 Sum',
  openingHours: 'Daily 10:00 - 23:00',
  phoneNumber: '+998 90 900 90 99',
  website: 'www.nihol.uz',
  description: 'Restaurant description',
  images: [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Barbieri_-_ViaSophia25668.jpg/640px-Barbieri_-_ViaSophia25668.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Barbieri_-_ViaSophia25668.jpg/640px-Barbieri_-_ViaSophia25668.jpg'
  ],
  star: '5',
  title: 'Besh Qozon',
  location: '448a Farabi St., Olmazorsky district',
  imgSrc:
      'https://s3-alpha-sig.figma.com/img/b9e6/c5a8/0413373a4d5c10ea14b6ef03c2cd7e36?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=IIi90N6IohwCHLnFzNiisF--05lry7AJyf2avOP9TilmlcTbRAUAYnbJ5jTKhzsTowWIpe4nSnre8pOujDNlKiuKJzKEo0fI4OTmH2TVBqLMHsx~-auO4Q18QWbzdQPfnlYywkXkzD2mzSuNn9bV7Az3v4EFvHePbIhDeLUnA07ukmu1elui9OnsF5uQPlKPESFon1OFkuLv-aFVlDkSo6kXBm7FkaH~a~aPEMjvLB0VlgAPFpX6WlAHPaNIKYqeoURAwH-wmyeBr06SDALnd4zPfiqOT2ptdAaMVTX~CoULC8e69IVZYz4Kw6RjDWng6jRPJIKmZBgIc6QAsSrRBA__',
  dateString: DateTime.now().toIso8601String(),
  distance: '124',
);

final restaurants = List.generate(5, (index) => testRestaurant);
