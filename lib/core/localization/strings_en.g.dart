///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsLoginEn login = TranslationsLoginEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsMoreEn more = TranslationsMoreEn.internal(_root);
	late final TranslationsAboutEn about = TranslationsAboutEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome Back'
	String get title => 'Welcome Back';

	/// en: 'Please sign in to continue'
	String get subtitle => 'Please sign in to continue';

	/// en: 'Username'
	String get usernameLabel => 'Username';

	/// en: 'Enter your username'
	String get usernameHint => 'Enter your username';

	/// en: 'Password'
	String get passwordLabel => 'Password';

	/// en: 'Enter your password'
	String get passwordHint => 'Enter your password';

	/// en: 'Sign In'
	String get button => 'Sign In';

	/// en: 'This field cannot be empty'
	String get errorEmpty => 'This field cannot be empty';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get title => 'Home';

	/// en: 'Hello, ${name}!'
	String greeting({required Object name}) => 'Hello, \$${name}!';

	/// en: 'Logout'
	String get logout => 'Logout';
}

// Path: more
class TranslationsMoreEn {
	TranslationsMoreEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More'
	String get title => 'More';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'General and Appearance settings'
	String get settingsSubtitle => 'General and Appearance settings';

	/// en: 'About'
	String get about => 'About';

	/// en: 'App version and info'
	String get aboutSubtitle => 'App version and info';
}

// Path: about
class TranslationsAboutEn {
	TranslationsAboutEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get title => 'About';

	/// en: 'Description'
	String get descriptionTitle => 'Description';

	/// en: 'A modern Flutter application built with clean architecture and Riverpod.'
	String get descriptionSubtitle => 'A modern Flutter application built with clean architecture and Riverpod.';

	/// en: 'Developed by'
	String get developedByTitle => 'Developed by';

	/// en: 'Codename Antigravity'
	String get developedBySubtitle => 'Codename Antigravity';

	/// en: 'Copyright'
	String get copyrightTitle => 'Copyright';

	/// en: '© 2024 Codename Antigravity. All rights reserved.'
	String get copyrightSubtitle => '© 2024 Codename Antigravity. All rights reserved.';

	/// en: 'View Licenses'
	String get viewLicenses => 'View Licenses';

	/// en: '© 2024 Codename Antigravity'
	String get legalese => '© 2024 Codename Antigravity';

	/// en: 'Version ${version} (${build})'
	String version({required Object version, required Object build}) => 'Version \$${version} (\$${build})';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'General'
	String get general => 'General';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Indonesian'
	String get languageIndonesian => 'Indonesian';

	/// en: 'English'
	String get languageEnglish => 'English';

	/// en: 'Theme Mode'
	String get theme => 'Theme Mode';

	/// en: 'Pure black dark mode'
	String get trueBlack => 'Pure black dark mode';

	/// en: 'Use pure black background in dark mode'
	String get trueBlackSubtitle => 'Use pure black background in dark mode';

	/// en: 'Theme Scheme'
	String get themeScheme => 'Theme Scheme';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Template App'
	String get appTitle => 'Template App';

	/// en: 'An error occurred'
	String get error => 'An error occurred';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Search...'
	String get search => 'Search...';

	late final TranslationsCommonDialogEn dialog = TranslationsCommonDialogEn.internal(_root);
}

// Path: common.dialog
class TranslationsCommonDialogEn {
	TranslationsCommonDialogEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Logout'
	String get logoutTitle => 'Logout';

	/// en: 'Are you sure you want to logout?'
	String get logoutContent => 'Are you sure you want to logout?';

	/// en: 'Exit App'
	String get exitTitle => 'Exit App';

	/// en: 'Are you sure you want to exit the app?'
	String get exitContent => 'Are you sure you want to exit the app?';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'login.title' => 'Welcome Back',
			'login.subtitle' => 'Please sign in to continue',
			'login.usernameLabel' => 'Username',
			'login.usernameHint' => 'Enter your username',
			'login.passwordLabel' => 'Password',
			'login.passwordHint' => 'Enter your password',
			'login.button' => 'Sign In',
			'login.errorEmpty' => 'This field cannot be empty',
			'home.title' => 'Home',
			'home.greeting' => ({required Object name}) => 'Hello, \$${name}!',
			'home.logout' => 'Logout',
			'more.title' => 'More',
			'more.settings' => 'Settings',
			'more.settingsSubtitle' => 'General and Appearance settings',
			'more.about' => 'About',
			'more.aboutSubtitle' => 'App version and info',
			'about.title' => 'About',
			'about.descriptionTitle' => 'Description',
			'about.descriptionSubtitle' => 'A modern Flutter application built with clean architecture and Riverpod.',
			'about.developedByTitle' => 'Developed by',
			'about.developedBySubtitle' => 'Codename Antigravity',
			'about.copyrightTitle' => 'Copyright',
			'about.copyrightSubtitle' => '© 2024 Codename Antigravity. All rights reserved.',
			'about.viewLicenses' => 'View Licenses',
			'about.legalese' => '© 2024 Codename Antigravity',
			'about.version' => ({required Object version, required Object build}) => 'Version \$${version} (\$${build})',
			'settings.title' => 'Settings',
			'settings.general' => 'General',
			'settings.appearance' => 'Appearance',
			'settings.language' => 'Language',
			'settings.languageIndonesian' => 'Indonesian',
			'settings.languageEnglish' => 'English',
			'settings.theme' => 'Theme Mode',
			'settings.trueBlack' => 'Pure black dark mode',
			'settings.trueBlackSubtitle' => 'Use pure black background in dark mode',
			'settings.themeScheme' => 'Theme Scheme',
			'settings.themeSystem' => 'System',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'common.appTitle' => 'Template App',
			'common.error' => 'An error occurred',
			'common.retry' => 'Retry',
			'common.success' => 'Success',
			'common.cancel' => 'Cancel',
			'common.logout' => 'Logout',
			'common.search' => 'Search...',
			'common.dialog.logoutTitle' => 'Logout',
			'common.dialog.logoutContent' => 'Are you sure you want to logout?',
			'common.dialog.exitTitle' => 'Exit App',
			'common.dialog.exitContent' => 'Are you sure you want to exit the app?',
			_ => null,
		};
	}
}
