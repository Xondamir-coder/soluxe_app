import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// Label or placeholder text for a button/feature that finds events near the user
  ///
  /// In en, this message translates to:
  /// **'Find events near'**
  String get findEventsNear;

  /// Country name used to filter or display events and venues located in Uzbekistan
  ///
  /// In en, this message translates to:
  /// **'Uzbekistan'**
  String get uzbekistan;

  /// Call-to-action text for initiating a search for events based on user input
  ///
  /// In en, this message translates to:
  /// **'Search events'**
  String get searchEvents;

  /// Category label for music events and live performances
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get concerts;

  /// Category label for hotel listings and accommodations
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotels;

  /// Category label for dining options and food establishments
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// Category label for event options and event establishments
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// Filter option to display all types of events or venues without any specific category
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Category label for historical landmarks and culturally significant sites
  ///
  /// In en, this message translates to:
  /// **'Historical place'**
  String get historicalPlace;

  /// Category label for museums, exhibitions, and art galleries
  ///
  /// In en, this message translates to:
  /// **'Museums'**
  String get museums;

  /// General category label for various types of entertainment options
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// Section title for events scheduled to occur in the near future
  ///
  /// In en, this message translates to:
  /// **'Upcoming events'**
  String get upcomingEvents;

  /// Link or button text used to expand a list and view all available items
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Call-to-action text encouraging users to discover or browse events and places
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// Label for the list or menu that groups content into different types or classifications
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Label for the user profile section where personal information and settings can be viewed or edited
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Label used to denote events or venues operating during the nighttime
  ///
  /// In en, this message translates to:
  /// **'night'**
  String get night;

  /// Section header displaying search terms that are trending or frequently used by users
  ///
  /// In en, this message translates to:
  /// **'Popular searches'**
  String get popularSearches;

  /// Message displayed when a search returns no matching results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Filter label allowing users to narrow down results based on cost or budget
  ///
  /// In en, this message translates to:
  /// **'Price range'**
  String get priceRange;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// Name of the month used for date selections or event scheduling
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// Button label for aborting or closing the current action without applying changes
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button label for confirming selections or applying filters/settings
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Label for the option that allows users to refine search results or content based on various criteria
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// Name of the day of the week used for scheduling or date filters
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// Label that indicates the average cost or typical pricing for an event or venue
  ///
  /// In en, this message translates to:
  /// **'Average price'**
  String get averagePrice;

  /// Section header or label for displaying contact information
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// Label indicating the operating hours of a venue or event
  ///
  /// In en, this message translates to:
  /// **'Opening hours'**
  String get openingHours;

  /// Label for a field where users can specify or view the intended location or endpoint of a journey
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// Button or link label used to initiate a phone call to a provided contact number
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// Label for a featured hotel section highlighting recommended or top-rated accommodations
  ///
  /// In en, this message translates to:
  /// **'Top picks hotel'**
  String get topPicksHotel;

  /// Category label for budget-friendly lodging options
  ///
  /// In en, this message translates to:
  /// **'Hostel'**
  String get hostel;

  /// Option for refining search results based on a specific type of venue or event
  ///
  /// In en, this message translates to:
  /// **'Filter by type'**
  String get filterByType;

  /// Option for refining search results based on user or expert ratings
  ///
  /// In en, this message translates to:
  /// **'Filter by rating'**
  String get filterByRating;

  /// Message displayed when no venues or locations match the search criteria
  ///
  /// In en, this message translates to:
  /// **'No places found'**
  String get noPlacesFound;

  /// Unit abbreviation for kilometers, typically used to indicate distance
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// Section label where users can manage and update their account preferences and information
  ///
  /// In en, this message translates to:
  /// **'Account setting'**
  String get accountSetting;

  /// General label for user choices or customizable settings within the app
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get preference;

  /// Section header where users can view or edit their personal data, such as name, email, etc
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personalInformation;

  /// Setting option to enable or disable push notifications from the app
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// Setting option to enable or disable receiving event or promotional updates via email
  ///
  /// In en, this message translates to:
  /// **'Email updates'**
  String get emailUpdates;

  /// Label for the option that allows users to select the language for the app interface
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Setting option that toggles the app’s color scheme between light and dark themes
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// Section header for frequently asked questions and help topics
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// Label or link to the document detailing how user data is collected, used, and protected
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Section label where users can get help or contact customer service for assistance
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Button label used to confirm and send data from a form or input
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Field label for entering or displaying the user’s complete name
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// Option for users to receive alerts directly to their mobile phone
  ///
  /// In en, this message translates to:
  /// **'Get alert in your phone'**
  String get getAlertPhone;

  /// Option for users to receive alerts via email
  ///
  /// In en, this message translates to:
  /// **'Get alert in your email'**
  String get getAlertEmail;

  /// Option for users to receive push notifications for updates and alerts
  ///
  /// In en, this message translates to:
  /// **'Get alert in your notifications'**
  String get getAlertNotifications;

  /// Label for subscription options to periodic email newsletters
  ///
  /// In en, this message translates to:
  /// **'Newsletters'**
  String get newsletters;

  /// Option for subscribing to emails that highlight upcoming events and promotions
  ///
  /// In en, this message translates to:
  /// **'Receieve emails with events'**
  String get receieveEmailsEvents;

  /// Field label for entering or displaying an email address
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Field label for entering or displaying a phone number
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Option for selecting English as the language for the app interface
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Option for selecting Chinese as the language for the app interface
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// Prompt for users to choose their preferred language from a list of options
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// Section header encouraging users to explore content based on various topics
  ///
  /// In en, this message translates to:
  /// **'Browse by topic'**
  String get browseByTopic;

  /// Label introducing a frequently asked question or a topic of inquiry
  ///
  /// In en, this message translates to:
  /// **'Question about'**
  String get questionAbout;

  /// Button text used to expand a section and reveal additional content
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// Generic label for initiating a search within the app
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Field label for specifying or displaying a geographic location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Section label providing information about the app, company, or service
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label for a photo or image section, often used for profile pictures or galleries
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// Label representing the culinary aspect of a venue, typically used in restaurant contexts
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get kitchen;

  /// Unit of time representing one hour, used in scheduling and duration displays
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// Unit of time representing one minute, used in scheduling and duration displays
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// Section label for displaying alerts and notifications from the app
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Button label for agreeing to terms, conditions, or prompts
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// Button label for rejecting terms, conditions, or prompts
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// Label for the home or main page of an app or website
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Uzbek currency
  ///
  /// In en, this message translates to:
  /// **'sum'**
  String get sum;

  /// Message indicating that the email has been y updated
  ///
  /// In en, this message translates to:
  /// **'Email y updated'**
  String get emailUpdated;

  /// Message indicating that the phone number has been y updated
  ///
  /// In en, this message translates to:
  /// **'Phone y updated'**
  String get phoneUpdated;

  /// Message indicating that the password has been y updated
  ///
  /// In en, this message translates to:
  /// **'Password y updated'**
  String get passwordUpdated;

  /// Message indicating that the full name has been y updated
  ///
  /// In en, this message translates to:
  /// **'Full name y updated'**
  String get fullNameUpdated;

  /// The address of given
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// European style
  ///
  /// In en, this message translates to:
  /// **'European'**
  String get european;

  /// Uzbek style
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get uzbek;

  /// Generic label for indicating that content is being loaded or processed
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Button label for skipping or advancing to the next step or section
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Title for the first section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Explore Uzbekistan like a local!'**
  String get welcomeTitle1;

  /// Title for the second section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Welcome to Your Pocket Guide to Uzbekistan!'**
  String get welcomeTitle2;

  /// Title for the third section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Pick a language, start exploring!'**
  String get welcomeTitle3;

  /// Title for the fourth section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Let’s Get Started'**
  String get welcomeTitle4;

  /// Subtitle for the first section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Your ultimate travel companion with insider tips, must-visit places, and essential travel info.'**
  String get welcomeSubTitle1;

  /// Subtitle for the second section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Discover the beauty, history, and culture of Uzbekistan with ease. From ancient Silk Road cities to hidden local gems—everything you need is right at your fingertips. Let’s start exploring!'**
  String get welcomeSubTitle2;

  /// Subtitle for the third section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Set your preferred language for the best experience'**
  String get welcomeSubTitle3;

  /// Subtitle for the fourth section of the welcome page
  ///
  /// In en, this message translates to:
  /// **'Your journey begins here'**
  String get welcomeSubTitle4;

  /// Button label for initiating or starting a journey or action
  ///
  /// In en, this message translates to:
  /// **'Let\'s go'**
  String get letsGo;

  /// Message indicating that the user does not have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// Button label for creating or registering a new account
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// Button label for continuing with a phone number
  ///
  /// In en, this message translates to:
  /// **'Continue with phone'**
  String get continueWithPhone;

  /// Button label for continuing with a email number
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continueWithEmail;

  /// Button label for continuing with Google
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// Button label for continuing with Apple
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// Button label for signing in with Apple
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// Button label for signing in with Google
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Button label for signing up with Apple
  ///
  /// In en, this message translates to:
  /// **'Sign up with Apple'**
  String get signUpWtihApple;

  /// Button label for signing up with Google
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// Arabic greeting
  ///
  /// In en, this message translates to:
  /// **'Assalomu Aleykum'**
  String get assalomuAleykum;

  /// Subtitle for the login page
  ///
  /// In en, this message translates to:
  /// **'Let’s continue your journey through Uzbekistan—there’s so much more to explore!'**
  String get loginSubtitle;

  /// Button label for advancing to the next step or section
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Button label for requesting a password reset
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// Label for a password or PIN code
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Prompt for providing valid input
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid'**
  String get pleaseEnterValid;

  /// Prompt for entering an email address for password reset
  ///
  /// In en, this message translates to:
  /// **'Please enter the email address associated with your account'**
  String get forgotPasswordText;

  /// Label for an email verification code
  ///
  /// In en, this message translates to:
  /// **'Email code'**
  String get emailCode;

  /// Label for a new password or PIN code
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Title for resetting your password
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get resetYourPassword;

  /// Button label for resetting your password
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Button label for resending OTP code
  ///
  /// In en, this message translates to:
  /// **'Resend OTP code'**
  String get resendOTPCode;

  /// Message that process was successful
  ///
  /// In en, this message translates to:
  /// **'Code has been sent'**
  String get codeHasBeenSent;

  /// Message indicating that all codes must be entered
  ///
  /// In en, this message translates to:
  /// **'Enter all codes'**
  String get enterAllCodes;

  /// Label for Verification Code
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// Message indicating that verification code is being sent
  ///
  /// In en, this message translates to:
  /// **'We are sending verification code to'**
  String get weAreSendingVerificationCodeTo;

  /// Message indicating successful login
  ///
  /// In en, this message translates to:
  /// **'Successfully logged in'**
  String get successfullyLoggedIn;

  /// Message indicating successful email confirmation
  ///
  /// In en, this message translates to:
  /// **'Successfully confirmed your email'**
  String get successfullyConfirmedEmail;

  /// Message indicating an error has occurred
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// Button label for confirming or accepting an action
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// Label for a section containing user reviews or feedback
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Label for a section containing hotel rooms or accommodations
  ///
  /// In en, this message translates to:
  /// **'Hotel Rooms'**
  String get hotelRooms;

  /// Label for a section containing user reviews or feedback
  ///
  /// In en, this message translates to:
  /// **'User Reviews'**
  String get userReviews;

  /// Button label for logging out of the app
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Privacy policy consent text
  ///
  /// In en, this message translates to:
  /// **'Please read and accept our privacy policy to continue.'**
  String get consentText;

  /// Button label for agreeing to terms or conditions
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// Button label for viewing a privacy policy
  ///
  /// In en, this message translates to:
  /// **'View Policy'**
  String get viewPolicy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
