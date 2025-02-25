import 'package:soluxe/models/event.dart';

final testEvent = Event(
  dates: [
    EventDate(month: 'Mar', day: 27),
    EventDate(month: 'Mar', day: 28),
    EventDate(month: 'Mar', day: 29),
  ],
  locationImgSrc:
      'https://s3-alpha-sig.figma.com/img/003e/a414/2643f9016f91728ee7f04c6d8864df12?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=nOXGsKuwMaaoXWWTZ1wiQgplkcfJ6TKs7sHCTNGrB-fmxqQgRBmKMHqL0DelqHzGFRX0Q49zvqaU25K9G~lEp7ytvPzdz7Zt6mhgG2SnKVVfEFBgT9L9Edw98VHEicM-VK0j4RjCpBBoNz-KKNmE8T0~6lqlboimLywsshrf8VEsk1DQBt~KzQ0Ro2HZXdrqsab0dp2IOIBik-3n5yyOZ93J77iEOBxpLgCWqiKgN2E8egGdKk610HlGzBgndasSENQdJSJq1f~yNjJNyoqOPacYdsnTIQ3zLgAsMVa1gmHjqJhuk-DKuyuzhzrYaUngz6Nej2u7CsYJoEfvLizwNg__',
  averagePrice: '2 400 000 Sum',
  openingHours: 'Daily 10:00 - 23:00',
  phoneNumber: '+998 90 900 90 99',
  website: 'www.nihol.uz',
  star: '5',
  timeSlot: '10:00 - End',
  banner:
      'https://static1.srcdn.com/wordpress/wp-content/uploads/invincible.jpg',
  images: [
    'https://assets-prd.ignimgs.com/2023/10/31/invincible-thestorysofar-blogroll-1698783536876.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTve-NFgmtTgQfSEeRnUptsVEufHTOY8oO52A&s',
    'https://okcomics.co.uk/cdn/shop/files/9781534340268_1200x1200.jpg?v=1711885682',
    'https://i.redd.it/r2th4esr1qe91.jpg',
    'https://goldenapplecomics.com/cdn/shop/products/84720-hr.jpg?v=1684939500'
  ],
  distance: '124',
  imgSrc:
      'https://hips.hearstapps.com/hmg-prod/images/mh-4-9-comic-6615b05935883.jpg?crop=0.447xw:0.894xh;0.529xw,0.0353xh&resize=640:*',
  location: 'Tashkent, Concert hall',
  description:
      "The wait is over! Invincible is coming back for Season 3, and things are about to get even more intense. Let's dive into what's next for Mark Grayson, Omni-Man, and the blood-soaked universe of Invincible!",
  title: 'Invincible Returns for Season 3 – What to Expect!',
  dateString: '2025-02-15T14:37:40.658Z',
);
final events = List.generate(10, (index) => testEvent);
