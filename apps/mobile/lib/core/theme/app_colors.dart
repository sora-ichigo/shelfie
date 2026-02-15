import 'package:flutter/material.dart';

/// アプリケーション全体のカスタムカラースキーム
///
/// 新デザインシステムへの移行中のため、既存のセマンティックカラーは
/// Legacy サフィックス付きで定義されている。
/// 新しいカラートークンは Material Design 3 に準拠して定義されている。
///
/// Theme.of(context).extension<AppColors>() でアクセスできる。
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    // --- Legacy ---
    required this.primaryLegacy,
    required this.primaryPressedLegacy,
    required this.backgroundLegacy,
    required this.surfaceLegacy,
    required this.surfaceElevatedLegacy,
    required this.borderLegacy,
    required this.inactiveLegacy,
    required this.textPrimaryLegacy,
    required this.textSecondaryLegacy,
    required this.starLegacy,
    required this.destructiveLegacy,
    required this.successLegacy,
    required this.warningLegacy,
    required this.infoLegacy,
    required this.overlayLegacy,
    // --- MD3 Core: Primary ---
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    // --- MD3 Core: Secondary ---
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    // --- MD3 Core: Tertiary ---
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    // --- MD3 Core: Error ---
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    // --- MD3 Core: Surface ---
    required this.surface,
    required this.onSurface,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.surfaceTint,
    required this.onSurfaceVariant,
    required this.inverseSurface,
    required this.inverseOnSurface,
    // --- MD3 Core: Outline / Scrim ---
    required this.outline,
    required this.outlineVariant,
    required this.scrim,
    // --- Semantic: Border ---
    required this.borderSubtle,
    required this.borderStrong,
    // --- Semantic: Text ---
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    // --- Semantic: Background ---
    required this.bgPrimary,
    required this.bgSurface,
    required this.bgMuted,
    required this.bgHero,
    required this.bgHeroGrad,
    // --- Semantic: Accent ---
    required this.accentPrimary,
    required this.accentLink,
    required this.accentWarm,
    // --- Semantic: Tab ---
    required this.tabInactive,
    // --- Semantic: Tag ---
    required this.tagAmber,
    required this.tagAmberText,
    required this.tagBlue,
    required this.tagBlueText,
    required this.tagPurple,
    required this.tagPurpleText,
    required this.tagRose,
    required this.tagRoseText,
    required this.tagTeal,
    required this.tagTealText,
    // --- Semantic: Status ---
    required this.statusComplete,
    required this.statusReading,
    // --- Semantic: Star ---
    required this.starColor,
    required this.starRating,
    // --- Semantic: Match Badge ---
    required this.matchBadge,
    required this.matchBadgeBg,
  });

  // ===========================================================================
  // Primitive Colors（基盤カラー - Legacy ダークモード用）
  // ===========================================================================

  static const Color _primaryDark = Color(0xFF2B9E8F);
  static const Color _primaryPressed = Color(0xFF238275);
  static const Color _background = Color(0xFF121212);
  static const Color _surfaceDark = Color(0xFF1E1E1E);
  static const Color _surfaceElevated = Color(0xFF2A2A2A);
  static const Color _border = Color(0xFF333333);
  static const Color _inactive = Color(0xFF666666);
  static const Color _textPrimaryDark = Color(0xFFFFFFFF);
  static const Color _textSecondaryDark = Color(0xFFB0B0B0);
  static const Color _star = Color(0xFFFFD60A);
  static const Color _destructive = Color(0xFFCF4F4A);
  static const Color _success = Color(0xFF4CAF7D);
  static const Color _warning = Color(0xFFE5A940);
  static const Color _info = Color(0xFF5B9BD5);
  static const Color _overlay = Color(0xFF000000);

  // ===========================================================================
  // Legacy Semantic Colors
  // ===========================================================================

  final Color primaryLegacy;
  final Color primaryPressedLegacy;
  final Color backgroundLegacy;
  final Color surfaceLegacy;
  final Color surfaceElevatedLegacy;
  final Color borderLegacy;
  final Color inactiveLegacy;
  final Color textPrimaryLegacy;
  final Color textSecondaryLegacy;
  final Color starLegacy;
  final Color destructiveLegacy;
  final Color successLegacy;
  final Color warningLegacy;
  final Color infoLegacy;
  final Color overlayLegacy;

  // ===========================================================================
  // MD3 Core: Primary
  // ===========================================================================

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  // ===========================================================================
  // MD3 Core: Secondary
  // ===========================================================================

  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  // ===========================================================================
  // MD3 Core: Tertiary
  // ===========================================================================

  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;

  // ===========================================================================
  // MD3 Core: Error
  // ===========================================================================

  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;

  // ===========================================================================
  // MD3 Core: Surface
  // ===========================================================================

  final Color surface;
  final Color onSurface;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color surfaceTint;
  final Color onSurfaceVariant;
  final Color inverseSurface;
  final Color inverseOnSurface;

  // ===========================================================================
  // MD3 Core: Outline / Scrim
  // ===========================================================================

  final Color outline;
  final Color outlineVariant;
  final Color scrim;

  // ===========================================================================
  // Semantic: Border
  // ===========================================================================

  final Color borderSubtle;
  final Color borderStrong;

  // ===========================================================================
  // Semantic: Text
  // ===========================================================================

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  // ===========================================================================
  // Semantic: Background
  // ===========================================================================

  final Color bgPrimary;
  final Color bgSurface;
  final Color bgMuted;
  final Color bgHero;
  final Color bgHeroGrad;

  // ===========================================================================
  // Semantic: Accent
  // ===========================================================================

  final Color accentPrimary;
  final Color accentLink;
  final Color accentWarm;

  // ===========================================================================
  // Semantic: Tab
  // ===========================================================================

  final Color tabInactive;

  // ===========================================================================
  // Semantic: Tag
  // ===========================================================================

  final Color tagAmber;
  final Color tagAmberText;
  final Color tagBlue;
  final Color tagBlueText;
  final Color tagPurple;
  final Color tagPurpleText;
  final Color tagRose;
  final Color tagRoseText;
  final Color tagTeal;
  final Color tagTealText;

  // ===========================================================================
  // Semantic: Status
  // ===========================================================================

  final Color statusComplete;
  final Color statusReading;

  // ===========================================================================
  // Semantic: Star
  // ===========================================================================

  final Color starColor;
  final Color starRating;

  // ===========================================================================
  // Semantic: Match Badge
  // ===========================================================================

  final Color matchBadge;
  final Color matchBadgeBg;

  // ===========================================================================
  // Predefined Constants
  // ===========================================================================

  static const dark = AppColors(
    primaryLegacy: _primaryDark,
    primaryPressedLegacy: _primaryPressed,
    backgroundLegacy: _background,
    surfaceLegacy: _surfaceDark,
    surfaceElevatedLegacy: _surfaceElevated,
    borderLegacy: _border,
    inactiveLegacy: _inactive,
    textPrimaryLegacy: _textPrimaryDark,
    textSecondaryLegacy: _textSecondaryDark,
    starLegacy: _star,
    destructiveLegacy: _destructive,
    successLegacy: _success,
    warningLegacy: _warning,
    infoLegacy: _info,
    overlayLegacy: _overlay,
    // MD3 Core: Primary
    primary: Color(0xFF3D8A5A),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEDF5F0),
    onPrimaryContainer: Color(0xFF1A3D2A),
    // MD3 Core: Secondary
    secondary: Color(0xFF8B9F7B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE0EDE5),
    onSecondaryContainer: Color(0xFF2B4C3F),
    // MD3 Core: Tertiary
    tertiary: Color(0xFFD89575),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFDF4EC),
    onTertiaryContainer: Color(0xFF5A3A2A),
    // MD3 Core: Error
    error: Color(0xFFE57373),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFF0F0),
    onErrorContainer: Color(0xFFC84A5A),
    // MD3 Core: Surface
    surface: Color(0xFFFAFAF8),
    onSurface: Color(0xFF1A1918),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF5F4F1),
    surfaceContainer: Color(0xFFEDECEA),
    surfaceContainerHigh: Color(0xFFE5E4E1),
    surfaceContainerHighest: Color(0xFFD1D0CD),
    surfaceTint: Color(0xFF3D8A5A),
    onSurfaceVariant: Color(0xFF6D6C6A),
    inverseSurface: Color(0xFF1C1917),
    inverseOnSurface: Color(0xFFFAFAF8),
    // MD3 Core: Outline / Scrim
    outline: Color(0xFF9C9B99),
    outlineVariant: Color(0xFFE5E4E1),
    scrim: Color(0x40000000),
    // Semantic: Border
    borderSubtle: Color(0xFFE5E4E1),
    borderStrong: Color(0xFFD1D0CD),
    // Semantic: Text
    textPrimary: Color(0xFF1A1918),
    textSecondary: Color(0xFF6D6C6A),
    textTertiary: Color(0xFF9C9B99),
    // Semantic: Background
    bgPrimary: Color(0xFFF5F4F1),
    bgSurface: Color(0xFFFFFFFF),
    bgMuted: Color(0xFFEDECEA),
    bgHero: Color(0xFF1C1917),
    bgHeroGrad: Color(0xFF292524),
    // Semantic: Accent
    accentPrimary: Color(0xFF3D8A5A),
    accentLink: Color(0xFF8B9F7B),
    accentWarm: Color(0xFFD89575),
    // Semantic: Tab
    tabInactive: Color(0xFFA8A7A5),
    // Semantic: Tag
    tagAmber: Color(0xFFFFF8E1),
    tagAmberText: Color(0xFF8B6914),
    tagBlue: Color(0xFFEDF4FF),
    tagBlueText: Color(0xFF4A7AC8),
    tagPurple: Color(0xFFF0EDFF),
    tagPurpleText: Color(0xFF6B4AC8),
    tagRose: Color(0xFFF5E6E0),
    tagRoseText: Color(0xFFA0614A),
    tagTeal: Color(0xFFE8F0EC),
    tagTealText: Color(0xFF3D7A5A),
    // Semantic: Status
    statusComplete: Color(0xFFA8D5BA),
    statusReading: Color(0xFFD89575),
    // Semantic: Star
    starColor: Color(0xFF4CAF50),
    starRating: Color(0xFF4CAF50),
    // Semantic: Match Badge
    matchBadge: Color(0xFFC8854A),
    matchBadgeBg: Color(0xFFFFF8F0),
  );

  static const light = AppColors(
    // Legacy tokens (dark values preserved for backward compatibility)
    primaryLegacy: _primaryDark,
    primaryPressedLegacy: _primaryPressed,
    backgroundLegacy: _background,
    surfaceLegacy: _surfaceDark,
    surfaceElevatedLegacy: _surfaceElevated,
    borderLegacy: _border,
    inactiveLegacy: _inactive,
    textPrimaryLegacy: _textPrimaryDark,
    textSecondaryLegacy: _textSecondaryDark,
    starLegacy: _star,
    destructiveLegacy: _destructive,
    successLegacy: _success,
    warningLegacy: _warning,
    infoLegacy: _info,
    overlayLegacy: _overlay,
    // MD3 Core: Primary
    primary: Color(0xFF3D8A5A),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEDF5F0),
    onPrimaryContainer: Color(0xFF1A3D2A),
    // MD3 Core: Secondary
    secondary: Color(0xFF8B9F7B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE0EDE5),
    onSecondaryContainer: Color(0xFF2B4C3F),
    // MD3 Core: Tertiary
    tertiary: Color(0xFFD89575),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFDF4EC),
    onTertiaryContainer: Color(0xFF5A3A2A),
    // MD3 Core: Error
    error: Color(0xFFE57373),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFF0F0),
    onErrorContainer: Color(0xFFC84A5A),
    // MD3 Core: Surface
    surface: Color(0xFFFAFAF8),
    onSurface: Color(0xFF1A1918),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF5F4F1),
    surfaceContainer: Color(0xFFEDECEA),
    surfaceContainerHigh: Color(0xFFE5E4E1),
    surfaceContainerHighest: Color(0xFFD1D0CD),
    surfaceTint: Color(0xFF3D8A5A),
    onSurfaceVariant: Color(0xFF6D6C6A),
    inverseSurface: Color(0xFF1C1917),
    inverseOnSurface: Color(0xFFFAFAF8),
    // MD3 Core: Outline / Scrim
    outline: Color(0xFF9C9B99),
    outlineVariant: Color(0xFFE5E4E1),
    scrim: Color(0x40000000),
    // Semantic: Border
    borderSubtle: Color(0xFFE5E4E1),
    borderStrong: Color(0xFFD1D0CD),
    // Semantic: Text
    textPrimary: Color(0xFF1A1918),
    textSecondary: Color(0xFF6D6C6A),
    textTertiary: Color(0xFF9C9B99),
    // Semantic: Background
    bgPrimary: Color(0xFFF5F4F1),
    bgSurface: Color(0xFFFFFFFF),
    bgMuted: Color(0xFFEDECEA),
    bgHero: Color(0xFF1C1917),
    bgHeroGrad: Color(0xFF292524),
    // Semantic: Accent
    accentPrimary: Color(0xFF3D8A5A),
    accentLink: Color(0xFF8B9F7B),
    accentWarm: Color(0xFFD89575),
    // Semantic: Tab
    tabInactive: Color(0xFFA8A7A5),
    // Semantic: Tag
    tagAmber: Color(0xFFFFF8E1),
    tagAmberText: Color(0xFF8B6914),
    tagBlue: Color(0xFFEDF4FF),
    tagBlueText: Color(0xFF4A7AC8),
    tagPurple: Color(0xFFF0EDFF),
    tagPurpleText: Color(0xFF6B4AC8),
    tagRose: Color(0xFFF5E6E0),
    tagRoseText: Color(0xFFA0614A),
    tagTeal: Color(0xFFE8F0EC),
    tagTealText: Color(0xFF3D7A5A),
    // Semantic: Status
    statusComplete: Color(0xFFA8D5BA),
    statusReading: Color(0xFFD89575),
    // Semantic: Star
    starColor: Color(0xFF4CAF50),
    starRating: Color(0xFF4CAF50),
    // Semantic: Match Badge
    matchBadge: Color(0xFFC8854A),
    matchBadgeBg: Color(0xFFFFF8F0),
  );

  @override
  AppColors copyWith({
    // Legacy
    Color? primaryLegacy,
    Color? primaryPressedLegacy,
    Color? backgroundLegacy,
    Color? surfaceLegacy,
    Color? surfaceElevatedLegacy,
    Color? borderLegacy,
    Color? inactiveLegacy,
    Color? textPrimaryLegacy,
    Color? textSecondaryLegacy,
    Color? starLegacy,
    Color? destructiveLegacy,
    Color? successLegacy,
    Color? warningLegacy,
    Color? infoLegacy,
    Color? overlayLegacy,
    // MD3 Core: Primary
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    // MD3 Core: Secondary
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    // MD3 Core: Tertiary
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    // MD3 Core: Error
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    // MD3 Core: Surface
    Color? surface,
    Color? onSurface,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? surfaceTint,
    Color? onSurfaceVariant,
    Color? inverseSurface,
    Color? inverseOnSurface,
    // MD3 Core: Outline / Scrim
    Color? outline,
    Color? outlineVariant,
    Color? scrim,
    // Semantic: Border
    Color? borderSubtle,
    Color? borderStrong,
    // Semantic: Text
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    // Semantic: Background
    Color? bgPrimary,
    Color? bgSurface,
    Color? bgMuted,
    Color? bgHero,
    Color? bgHeroGrad,
    // Semantic: Accent
    Color? accentPrimary,
    Color? accentLink,
    Color? accentWarm,
    // Semantic: Tab
    Color? tabInactive,
    // Semantic: Tag
    Color? tagAmber,
    Color? tagAmberText,
    Color? tagBlue,
    Color? tagBlueText,
    Color? tagPurple,
    Color? tagPurpleText,
    Color? tagRose,
    Color? tagRoseText,
    Color? tagTeal,
    Color? tagTealText,
    // Semantic: Status
    Color? statusComplete,
    Color? statusReading,
    // Semantic: Star
    Color? starColor,
    Color? starRating,
    // Semantic: Match Badge
    Color? matchBadge,
    Color? matchBadgeBg,
  }) {
    return AppColors(
      // Legacy
      primaryLegacy: primaryLegacy ?? this.primaryLegacy,
      primaryPressedLegacy: primaryPressedLegacy ?? this.primaryPressedLegacy,
      backgroundLegacy: backgroundLegacy ?? this.backgroundLegacy,
      surfaceLegacy: surfaceLegacy ?? this.surfaceLegacy,
      surfaceElevatedLegacy:
          surfaceElevatedLegacy ?? this.surfaceElevatedLegacy,
      borderLegacy: borderLegacy ?? this.borderLegacy,
      inactiveLegacy: inactiveLegacy ?? this.inactiveLegacy,
      textPrimaryLegacy: textPrimaryLegacy ?? this.textPrimaryLegacy,
      textSecondaryLegacy: textSecondaryLegacy ?? this.textSecondaryLegacy,
      starLegacy: starLegacy ?? this.starLegacy,
      destructiveLegacy: destructiveLegacy ?? this.destructiveLegacy,
      successLegacy: successLegacy ?? this.successLegacy,
      warningLegacy: warningLegacy ?? this.warningLegacy,
      infoLegacy: infoLegacy ?? this.infoLegacy,
      overlayLegacy: overlayLegacy ?? this.overlayLegacy,
      // MD3 Core: Primary
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      // MD3 Core: Secondary
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      // MD3 Core: Tertiary
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      // MD3 Core: Error
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      // MD3 Core: Surface
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
      // MD3 Core: Outline / Scrim
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      scrim: scrim ?? this.scrim,
      // Semantic: Border
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      // Semantic: Text
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      // Semantic: Background
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSurface: bgSurface ?? this.bgSurface,
      bgMuted: bgMuted ?? this.bgMuted,
      bgHero: bgHero ?? this.bgHero,
      bgHeroGrad: bgHeroGrad ?? this.bgHeroGrad,
      // Semantic: Accent
      accentPrimary: accentPrimary ?? this.accentPrimary,
      accentLink: accentLink ?? this.accentLink,
      accentWarm: accentWarm ?? this.accentWarm,
      // Semantic: Tab
      tabInactive: tabInactive ?? this.tabInactive,
      // Semantic: Tag
      tagAmber: tagAmber ?? this.tagAmber,
      tagAmberText: tagAmberText ?? this.tagAmberText,
      tagBlue: tagBlue ?? this.tagBlue,
      tagBlueText: tagBlueText ?? this.tagBlueText,
      tagPurple: tagPurple ?? this.tagPurple,
      tagPurpleText: tagPurpleText ?? this.tagPurpleText,
      tagRose: tagRose ?? this.tagRose,
      tagRoseText: tagRoseText ?? this.tagRoseText,
      tagTeal: tagTeal ?? this.tagTeal,
      tagTealText: tagTealText ?? this.tagTealText,
      // Semantic: Status
      statusComplete: statusComplete ?? this.statusComplete,
      statusReading: statusReading ?? this.statusReading,
      // Semantic: Star
      starColor: starColor ?? this.starColor,
      starRating: starRating ?? this.starRating,
      // Semantic: Match Badge
      matchBadge: matchBadge ?? this.matchBadge,
      matchBadgeBg: matchBadgeBg ?? this.matchBadgeBg,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      // Legacy
      primaryLegacy: Color.lerp(primaryLegacy, other.primaryLegacy, t)!,
      primaryPressedLegacy:
          Color.lerp(primaryPressedLegacy, other.primaryPressedLegacy, t)!,
      backgroundLegacy:
          Color.lerp(backgroundLegacy, other.backgroundLegacy, t)!,
      surfaceLegacy: Color.lerp(surfaceLegacy, other.surfaceLegacy, t)!,
      surfaceElevatedLegacy:
          Color.lerp(surfaceElevatedLegacy, other.surfaceElevatedLegacy, t)!,
      borderLegacy: Color.lerp(borderLegacy, other.borderLegacy, t)!,
      inactiveLegacy: Color.lerp(inactiveLegacy, other.inactiveLegacy, t)!,
      textPrimaryLegacy:
          Color.lerp(textPrimaryLegacy, other.textPrimaryLegacy, t)!,
      textSecondaryLegacy:
          Color.lerp(textSecondaryLegacy, other.textSecondaryLegacy, t)!,
      starLegacy: Color.lerp(starLegacy, other.starLegacy, t)!,
      destructiveLegacy:
          Color.lerp(destructiveLegacy, other.destructiveLegacy, t)!,
      successLegacy: Color.lerp(successLegacy, other.successLegacy, t)!,
      warningLegacy: Color.lerp(warningLegacy, other.warningLegacy, t)!,
      infoLegacy: Color.lerp(infoLegacy, other.infoLegacy, t)!,
      overlayLegacy: Color.lerp(overlayLegacy, other.overlayLegacy, t)!,
      // MD3 Core: Primary
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      // MD3 Core: Secondary
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      // MD3 Core: Tertiary
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer:
          Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiaryContainer:
          Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      // MD3 Core: Error
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer:
          Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      // MD3 Core: Surface
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceContainerLowest:
          Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t)!,
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainer:
          Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      surfaceContainerHighest: Color.lerp(
        surfaceContainerHighest,
        other.surfaceContainerHighest,
        t,
      )!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      inverseOnSurface:
          Color.lerp(inverseOnSurface, other.inverseOnSurface, t)!,
      // MD3 Core: Outline / Scrim
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      // Semantic: Border
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      // Semantic: Text
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      // Semantic: Background
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgMuted: Color.lerp(bgMuted, other.bgMuted, t)!,
      bgHero: Color.lerp(bgHero, other.bgHero, t)!,
      bgHeroGrad: Color.lerp(bgHeroGrad, other.bgHeroGrad, t)!,
      // Semantic: Accent
      accentPrimary: Color.lerp(accentPrimary, other.accentPrimary, t)!,
      accentLink: Color.lerp(accentLink, other.accentLink, t)!,
      accentWarm: Color.lerp(accentWarm, other.accentWarm, t)!,
      // Semantic: Tab
      tabInactive: Color.lerp(tabInactive, other.tabInactive, t)!,
      // Semantic: Tag
      tagAmber: Color.lerp(tagAmber, other.tagAmber, t)!,
      tagAmberText: Color.lerp(tagAmberText, other.tagAmberText, t)!,
      tagBlue: Color.lerp(tagBlue, other.tagBlue, t)!,
      tagBlueText: Color.lerp(tagBlueText, other.tagBlueText, t)!,
      tagPurple: Color.lerp(tagPurple, other.tagPurple, t)!,
      tagPurpleText: Color.lerp(tagPurpleText, other.tagPurpleText, t)!,
      tagRose: Color.lerp(tagRose, other.tagRose, t)!,
      tagRoseText: Color.lerp(tagRoseText, other.tagRoseText, t)!,
      tagTeal: Color.lerp(tagTeal, other.tagTeal, t)!,
      tagTealText: Color.lerp(tagTealText, other.tagTealText, t)!,
      // Semantic: Status
      statusComplete: Color.lerp(statusComplete, other.statusComplete, t)!,
      statusReading: Color.lerp(statusReading, other.statusReading, t)!,
      // Semantic: Star
      starColor: Color.lerp(starColor, other.starColor, t)!,
      starRating: Color.lerp(starRating, other.starRating, t)!,
      // Semantic: Match Badge
      matchBadge: Color.lerp(matchBadge, other.matchBadge, t)!,
      matchBadgeBg: Color.lerp(matchBadgeBg, other.matchBadgeBg, t)!,
    );
  }
}
