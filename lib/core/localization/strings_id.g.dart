///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsId extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	@override 
	TranslationsId $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsLoginId login = _TranslationsLoginId._(_root);
	@override late final _TranslationsHomeId home = _TranslationsHomeId._(_root);
	@override late final _TranslationsMoreId more = _TranslationsMoreId._(_root);
	@override late final _TranslationsAboutId about = _TranslationsAboutId._(_root);
	@override late final _TranslationsSettingsId settings = _TranslationsSettingsId._(_root);
	@override late final _TranslationsCommonId common = _TranslationsCommonId._(_root);
}

// Path: login
class _TranslationsLoginId extends TranslationsLoginEn {
	_TranslationsLoginId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selamat Datang Kembali';
	@override String get subtitle => 'Silakan masuk untuk melanjutkan';
	@override String get usernameLabel => 'Nama Pengguna';
	@override String get usernameHint => 'Masukkan nama pengguna Anda';
	@override String get passwordLabel => 'Kata Sandi';
	@override String get passwordHint => 'Masukkan kata sandi Anda';
	@override String get button => 'Masuk';
	@override String get errorEmpty => 'Kolom ini tidak boleh kosong';
}

// Path: home
class _TranslationsHomeId extends TranslationsHomeEn {
	_TranslationsHomeId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beranda';
	@override String greeting({required Object name}) => 'Halo, \$${name}!';
	@override String get logout => 'Keluar';
}

// Path: more
class _TranslationsMoreId extends TranslationsMoreEn {
	_TranslationsMoreId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lainnya';
	@override String get settings => 'Pengaturan';
	@override String get settingsSubtitle => 'Pengaturan Umum dan Tampilan';
	@override String get about => 'Tentang';
	@override String get aboutSubtitle => 'Versi aplikasi dan info';
}

// Path: about
class _TranslationsAboutId extends TranslationsAboutEn {
	_TranslationsAboutId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tentang';
	@override String get descriptionTitle => 'Deskripsi';
	@override String get descriptionSubtitle => 'Aplikasi Flutter modern yang dibangun dengan arsitektur bersih dan Riverpod.';
	@override String get developedByTitle => 'Dikembangkan oleh';
	@override String get developedBySubtitle => 'Codename Antigravity';
	@override String get copyrightTitle => 'Hak Cipta';
	@override String get copyrightSubtitle => '© 2024 Codename Antigravity. Seluruh hak dilindungi.';
	@override String get viewLicenses => 'Lihat Lisensi';
	@override String get legalese => '© 2024 Codename Antigravity';
	@override String version({required Object version, required Object build}) => 'Versi \$${version} (\$${build})';
}

// Path: settings
class _TranslationsSettingsId extends TranslationsSettingsEn {
	_TranslationsSettingsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pengaturan';
	@override String get general => 'Umum';
	@override String get appearance => 'Tampilan';
	@override String get language => 'Bahasa';
	@override String get languageIndonesian => 'Bahasa Indonesia';
	@override String get languageEnglish => 'Bahasa Inggris';
	@override String get theme => 'Mode Tema';
	@override String get trueBlack => 'Mode gelap hitam pekat';
	@override String get trueBlackSubtitle => 'Gunakan latar belakang hitam murni di mode gelap';
	@override String get themeScheme => 'Skema Tema';
	@override String get themeSystem => 'Sistem';
	@override String get themeLight => 'Terang';
	@override String get themeDark => 'Gelap';
}

// Path: common
class _TranslationsCommonId extends TranslationsCommonEn {
	_TranslationsCommonId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get appTitle => 'Templat App';
	@override String get error => 'Terjadi kesalahan';
	@override String get retry => 'Coba lagi';
	@override String get success => 'Sukses';
	@override String get cancel => 'Batal';
	@override String get logout => 'Keluar';
	@override String get search => 'Cari...';
	@override late final _TranslationsCommonDialogId dialog = _TranslationsCommonDialogId._(_root);
}

// Path: common.dialog
class _TranslationsCommonDialogId extends TranslationsCommonDialogEn {
	_TranslationsCommonDialogId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get logoutTitle => 'Keluar';
	@override String get logoutContent => 'Apakah Anda yakin ingin keluar?';
	@override String get exitTitle => 'Keluar Aplikasi';
	@override String get exitContent => 'Apakah Anda yakin ingin keluar dari aplikasi?';
}

/// The flat map containing all translations for locale <id>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'login.title' => 'Selamat Datang Kembali',
			'login.subtitle' => 'Silakan masuk untuk melanjutkan',
			'login.usernameLabel' => 'Nama Pengguna',
			'login.usernameHint' => 'Masukkan nama pengguna Anda',
			'login.passwordLabel' => 'Kata Sandi',
			'login.passwordHint' => 'Masukkan kata sandi Anda',
			'login.button' => 'Masuk',
			'login.errorEmpty' => 'Kolom ini tidak boleh kosong',
			'home.title' => 'Beranda',
			'home.greeting' => ({required Object name}) => 'Halo, \$${name}!',
			'home.logout' => 'Keluar',
			'more.title' => 'Lainnya',
			'more.settings' => 'Pengaturan',
			'more.settingsSubtitle' => 'Pengaturan Umum dan Tampilan',
			'more.about' => 'Tentang',
			'more.aboutSubtitle' => 'Versi aplikasi dan info',
			'about.title' => 'Tentang',
			'about.descriptionTitle' => 'Deskripsi',
			'about.descriptionSubtitle' => 'Aplikasi Flutter modern yang dibangun dengan arsitektur bersih dan Riverpod.',
			'about.developedByTitle' => 'Dikembangkan oleh',
			'about.developedBySubtitle' => 'Codename Antigravity',
			'about.copyrightTitle' => 'Hak Cipta',
			'about.copyrightSubtitle' => '© 2024 Codename Antigravity. Seluruh hak dilindungi.',
			'about.viewLicenses' => 'Lihat Lisensi',
			'about.legalese' => '© 2024 Codename Antigravity',
			'about.version' => ({required Object version, required Object build}) => 'Versi \$${version} (\$${build})',
			'settings.title' => 'Pengaturan',
			'settings.general' => 'Umum',
			'settings.appearance' => 'Tampilan',
			'settings.language' => 'Bahasa',
			'settings.languageIndonesian' => 'Bahasa Indonesia',
			'settings.languageEnglish' => 'Bahasa Inggris',
			'settings.theme' => 'Mode Tema',
			'settings.trueBlack' => 'Mode gelap hitam pekat',
			'settings.trueBlackSubtitle' => 'Gunakan latar belakang hitam murni di mode gelap',
			'settings.themeScheme' => 'Skema Tema',
			'settings.themeSystem' => 'Sistem',
			'settings.themeLight' => 'Terang',
			'settings.themeDark' => 'Gelap',
			'common.appTitle' => 'Templat App',
			'common.error' => 'Terjadi kesalahan',
			'common.retry' => 'Coba lagi',
			'common.success' => 'Sukses',
			'common.cancel' => 'Batal',
			'common.logout' => 'Keluar',
			'common.search' => 'Cari...',
			'common.dialog.logoutTitle' => 'Keluar',
			'common.dialog.logoutContent' => 'Apakah Anda yakin ingin keluar?',
			'common.dialog.exitTitle' => 'Keluar Aplikasi',
			'common.dialog.exitContent' => 'Apakah Anda yakin ingin keluar dari aplikasi?',
			_ => null,
		};
	}
}
