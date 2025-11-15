import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @fonts.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get fonts;

  /// No description provided for @import_from_google_calendar.
  ///
  /// In en, this message translates to:
  /// **'Import from Google calendar'**
  String get import_from_google_calendar;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @change_app_language.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get change_app_language;

  /// No description provided for @change_app_typography.
  ///
  /// In en, this message translates to:
  /// **'Change app typography'**
  String get change_app_typography;

  /// No description provided for @change_app_color.
  ///
  /// In en, this message translates to:
  /// **'Change app color'**
  String get change_app_color;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @color_screen.
  ///
  /// In en, this message translates to:
  /// **'Color Screen'**
  String get color_screen;

  /// No description provided for @edit_task.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get edit_task;

  /// No description provided for @task_category.
  ///
  /// In en, this message translates to:
  /// **'Task Category :'**
  String get task_category;

  /// No description provided for @task_priority.
  ///
  /// In en, this message translates to:
  /// **'Task Priority :'**
  String get task_priority;

  /// No description provided for @sub_task.
  ///
  /// In en, this message translates to:
  /// **'Sub-Task  :'**
  String get sub_task;

  /// No description provided for @add_sub_task.
  ///
  /// In en, this message translates to:
  /// **'Add Sub-Task'**
  String get add_sub_task;

  /// No description provided for @delete_task.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get delete_task;

  /// No description provided for @index.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get index;

  /// No description provided for @what_do_you_want_today.
  ///
  /// In en, this message translates to:
  /// **'What do you want to do today?'**
  String get what_do_you_want_today;

  /// No description provided for @tap_to_add_tasks.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your tasks'**
  String get tap_to_add_tasks;

  /// No description provided for @search_for_task.
  ///
  /// In en, this message translates to:
  /// **'Search for your task...'**
  String get search_for_task;

  /// No description provided for @not_completed.
  ///
  /// In en, this message translates to:
  /// **'Not Completed'**
  String get not_completed;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @focus_mode.
  ///
  /// In en, this message translates to:
  /// **'Focus Mode'**
  String get focus_mode;

  /// No description provided for @start_focusing.
  ///
  /// In en, this message translates to:
  /// **'Start Focusing'**
  String get start_focusing;

  /// No description provided for @stop_timer.
  ///
  /// In en, this message translates to:
  /// **'Stop Timer'**
  String get stop_timer;

  /// No description provided for @resume_timer.
  ///
  /// In en, this message translates to:
  /// **'Resume Timer'**
  String get resume_timer;

  /// No description provided for @select_timer_duration.
  ///
  /// In en, this message translates to:
  /// **'Select Timer Duration'**
  String get select_timer_duration;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get sun;

  /// No description provided for @no_tasks_available.
  ///
  /// In en, this message translates to:
  /// **'No tasks available'**
  String get no_tasks_available;

  /// No description provided for @add_task.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get add_task;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Fill All fields'**
  String get fill_all_fields;

  /// No description provided for @task_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Task Added Successfully'**
  String get task_added_successfully;

  /// No description provided for @choose_category.
  ///
  /// In en, this message translates to:
  /// **'Choose Category'**
  String get choose_category;

  /// No description provided for @add_category.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get add_category;

  /// No description provided for @please_select_priority.
  ///
  /// In en, this message translates to:
  /// **'Please Select Priority'**
  String get please_select_priority;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit_task_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Task Title'**
  String get edit_task_title;

  /// No description provided for @create_new_category.
  ///
  /// In en, this message translates to:
  /// **'Create new category'**
  String get create_new_category;

  /// No description provided for @category_name.
  ///
  /// In en, this message translates to:
  /// **'Category name :'**
  String get category_name;

  /// No description provided for @category_icon.
  ///
  /// In en, this message translates to:
  /// **'Category icon :'**
  String get category_icon;

  /// No description provided for @choose_icon_from_library.
  ///
  /// In en, this message translates to:
  /// **'Choose icon from library'**
  String get choose_icon_from_library;

  /// No description provided for @category_color.
  ///
  /// In en, this message translates to:
  /// **'Category color :'**
  String get category_color;

  /// No description provided for @create_category.
  ///
  /// In en, this message translates to:
  /// **'Create Category'**
  String get create_category;

  /// No description provided for @choose_icon.
  ///
  /// In en, this message translates to:
  /// **'Choose Icon'**
  String get choose_icon;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get app_settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @change_account_name.
  ///
  /// In en, this message translates to:
  /// **'Change Account Name'**
  String get change_account_name;

  /// No description provided for @task_time.
  ///
  /// In en, this message translates to:
  /// **'Task Time :'**
  String get task_time;

  /// No description provided for @change_account_password.
  ///
  /// In en, this message translates to:
  /// **'Change Account Password'**
  String get change_account_password;

  /// No description provided for @change_account_image.
  ///
  /// In en, this message translates to:
  /// **'Change Account Image'**
  String get change_account_image;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @support_us.
  ///
  /// In en, this message translates to:
  /// **'Support Us'**
  String get support_us;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
