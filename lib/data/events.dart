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
  star: '3',
  timeSlot: '10:00 - End',
  banner:
      'https://s3-alpha-sig.figma.com/img/a57d/397b/cb8baf649d7360e2e273fb414f9863d9?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pPyjQv6lbgBnthf9ahI6FfxM22y3mhBg-Vj9WgOnNQnFl60C7Aduu-~1PwXH6TyGWzFp7STnYfLmb4mmqwYwk9dggyWCQQEzMFmDsWAO1Ek-jiNCEFyV81oUpG56bb-ok~hiPA7S9EtDPr6d-oVwh66asZOMhUraxFfdk8QMo4yol8AA34KKX628vOMUpSLQcONPlUDv6xyGzoGaPwW20s4W9b4Bo~2BPSa4H4uR01DFaDTVMwzwcUFrFJApH1P2IHarYPmg0SlCduDgmdv-MbXcikG4jz3ZKqmOfCw67jQycsGXWN4nj8SX~blTd19620Eo~LPU9etaHhgbI4z00A__',
  images: [
    'https://s3-alpha-sig.figma.com/img/da6d/1aeb/08dfb16d0b034c49a3fa9ef94b1f8aca?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=EHB~nDmdtKkw0fwYafLyDwjXDjKR6dLXbb03lJfJ2UdWmeGXrC64YCWfj21jft1wK1hE29ZftJV~yfMLMwmkbIUuOUjtABW7gzr5OISgaVLNnfEH3WZ2xDrZ~ryZhoXrrpEBuLyNAcHSwb8cZLy35GSumlQHnKfMgl~BdrIBS2ULmCcJeyoXtEGnnMfgTz~t1ryaDm6P06FkdzZ~Jixb30SKAyI8nSFPJSoO4miFbwV8ADX7T5fsvRz-V5aJcSPzT14jhP1rruQazBdG~YDC3~oqt5jN7cJ~xp0jqCpm1NbgmZWh~iqZGRx37jAs0mCxj~KnnnDGKM0tl6s9ag7jTQ__',
    'https://s3-alpha-sig.figma.com/img/47c6/c9f4/66bb721215e6e9e5ad75efa35d9f36c2?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fczTkpcxVN~GQnUfMSZuIX1Zw4YoTm~u-TyYgurYi2EJRzwkW5CHp44aD3zw~6sVEfzhp-ak5U47v9K3JmlaMaSBgQUpTYbNyIg8bJT~4S15DTkJ~ynSTgi7WTpaUDBVO34uVDYOOg3Tq-qubdAoq9bTYtRbZN-e1LfqjJ1Px9kp1ziTAirwqaCbqDCSAW4LBEczivARVy-u5suHFOUpRVaipzWzOAF54AmEpZ~jIxAviaUWcvfdLO7a2scE2ELNa8JeVBhPX7gaFwg1YikF6xcukKcUOe0CeaE2A3K226JQ0HMZZZImAwGOtxS56U816Eq61Qi1XfIT0tAhnmqIvg__',
    'https://s3-alpha-sig.figma.com/img/ac16/8dca/49c90ea41525b6a540aa9b3b1140bdb0?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=stRfTPqr3DNhsdfq4ly4QKo-aCYzLuJAXzqj5H5~QesMtz5EjLOcDlzXHFqgWOQhMcLAIs~h3TfNz~XZmR1Vk2SxNLXfTCNjPU-xxYazkL4Iy9pmmHKYAKl6CscwkH5K8a2fZbxgcM9uZ9nBF4V7YR1vXL0RYJZVCOVZ10fBpdwiiSHaluarxStFYSWbgAGBvMwodfDPGZMsuFU-mwb5mzowfB0gUKRG5u~rrzdF3uaM7-ZTlWiMML1rSlsRRZT5lqoX7imiHyFrzSJQQ-IHIrK5NUNc32YMZZ5Ar~mhKbUzWymjRaGzmigj1z6QvekvUr2cefRQy-GQIEV-S5EL7w__',
    'https://s3-alpha-sig.figma.com/img/5dd8/394f/ff8ff5955827e3b001fa11806747cf12?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qDM0YjiSHTKx6iyBGQnZ1S4Dm04yCEpjr4NdpmznNsusnE51ldBdms1SbI-aVaSDFssqVgB1ZlwBQXp6~ZI3u1qrVC5E~ERfkKnOJluAu5jpLZGeiufMVTT3nqnhynjWx4rSj6RGhjIlQpH4CXd1UU3fk4ttXfA~Ptr8uEq0GqgxmNnv3U5c6lOBaa7KpyLO3U98zgZ5S2uyIsfei~KaknE66Z~IvSlfq49Sb1CRl1ux-GbyEB4Xsz9BhIR9MmpmpUsuDvhQ3bK8rUqBu3HL-tqQesdw8sowZ6V013mvimeyuCLvVba3f9VQefHJDT~tpuRVT3JtQiBv8oZIB4JRPw__',
    'https://s3-alpha-sig.figma.com/img/a57d/397b/cb8baf649d7360e2e273fb414f9863d9?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pPyjQv6lbgBnthf9ahI6FfxM22y3mhBg-Vj9WgOnNQnFl60C7Aduu-~1PwXH6TyGWzFp7STnYfLmb4mmqwYwk9dggyWCQQEzMFmDsWAO1Ek-jiNCEFyV81oUpG56bb-ok~hiPA7S9EtDPr6d-oVwh66asZOMhUraxFfdk8QMo4yol8AA34KKX628vOMUpSLQcONPlUDv6xyGzoGaPwW20s4W9b4Bo~2BPSa4H4uR01DFaDTVMwzwcUFrFJApH1P2IHarYPmg0SlCduDgmdv-MbXcikG4jz3ZKqmOfCw67jQycsGXWN4nj8SX~blTd19620Eo~LPU9etaHhgbI4z00A__'
  ],
  distance: '124',
  imgSrc:
      'https://s3-alpha-sig.figma.com/img/da6d/1aeb/08dfb16d0b034c49a3fa9ef94b1f8aca?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=EHB~nDmdtKkw0fwYafLyDwjXDjKR6dLXbb03lJfJ2UdWmeGXrC64YCWfj21jft1wK1hE29ZftJV~yfMLMwmkbIUuOUjtABW7gzr5OISgaVLNnfEH3WZ2xDrZ~ryZhoXrrpEBuLyNAcHSwb8cZLy35GSumlQHnKfMgl~BdrIBS2ULmCcJeyoXtEGnnMfgTz~t1ryaDm6P06FkdzZ~Jixb30SKAyI8nSFPJSoO4miFbwV8ADX7T5fsvRz-V5aJcSPzT14jhP1rruQazBdG~YDC3~oqt5jN7cJ~xp0jqCpm1NbgmZWh~iqZGRx37jAs0mCxj~KnnnDGKM0tl6s9ag7jTQ__',
  location: 'Tashkent, Concert hall',
  description:
      "Let’s continue your journey through Uzbekistan—there’s so much more to explore!",
  title: 'Lola returns to Tashkent for a concert after 10 years',
  dateString: '2025-02-15T14:37:40.658Z',
);
final events = List.generate(10, (index) => testEvent);
