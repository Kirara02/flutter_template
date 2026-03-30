// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeModeNotifier)
final themeModeProvider = ThemeModeNotifierProvider._();

final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  ThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'e9da796d74bc22773eeaf6ce3c67b99104b55fdc';

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(IsTrueBlack)
final isTrueBlackProvider = IsTrueBlackProvider._();

final class IsTrueBlackProvider extends $NotifierProvider<IsTrueBlack, bool> {
  IsTrueBlackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isTrueBlackProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isTrueBlackHash();

  @$internal
  @override
  IsTrueBlack create() => IsTrueBlack();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isTrueBlackHash() => r'43e23560fcff5be8a7782e5e6b89cf65cbdc5c77';

abstract class _$IsTrueBlack extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FlexSchemeNotifier)
final flexSchemeProvider = FlexSchemeNotifierProvider._();

final class FlexSchemeNotifierProvider
    extends $NotifierProvider<FlexSchemeNotifier, FlexScheme> {
  FlexSchemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flexSchemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flexSchemeNotifierHash();

  @$internal
  @override
  FlexSchemeNotifier create() => FlexSchemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlexScheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlexScheme>(value),
    );
  }
}

String _$flexSchemeNotifierHash() =>
    r'21b1345a27437972a20cfebfe12f4697554aaee9';

abstract class _$FlexSchemeNotifier extends $Notifier<FlexScheme> {
  FlexScheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FlexScheme, FlexScheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FlexScheme, FlexScheme>,
              FlexScheme,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
