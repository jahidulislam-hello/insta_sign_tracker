import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================================================================
  // ORIGINAL PALETTE (unchanged — every existing screen keeps working as-is)
  // =========================================================================

  // Background Colors
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color onboardingColor = Color(0xFFF5F5F7);
  static const Color loadingColor = Color(0xFF60A79F);
  static const Color loadingBacColor = Color(0x7B65711A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color homeLinear = Color(0x7B65711A);

  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF4DD0E1);
  static const Color lightBlueBg = Color(0xFFE3F2FD);
  static const Color lightOrangeBg = Color(0xFFFFF3E0);
  static const Color lightPinkBg = Color(0xFFFFEBEE);
  static const Color appBarColor = Color(0xFF30B3FB);
  static const Color selectedTabColor = Color(0xFF0033CF);

  // Icon Colors
  static const Color coralRed = Color(0xFFE53935);
  static const Color orange = Color(0xFFFF9800);

  // Alert Colors
  static const Color transparent = Color(0x00000000);
  static const Color red = Colors.red;

  // Utility colors
  static Color grey400 = Colors.grey[400]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;

  //green
  static const Color blackGreen = Color(0xFF004D3C);
  static const Color green = Color(0xFF007A5E);

  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF14161A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  static const Color border = Color(0xFFE5E7EB);
  static const Color fieldFill = Color(0xFFF1F2F4);

  static const Color blue = Color(0xFF2E86F0);
  static const Color blueLight = Color(0xFFEAF3FE);

  static const Color redLight = Color(0xFFFDECEC);
  static const Color pink = Color(0xFFEF9A9A);

  static const Color greenLight = Color(0xFFE9F8EF);

  static const Color orangeLight = Color(0xFFFEF3E2);

  static const Color blueBadgeBg = Color(0xFFDCEAFE);

  static const Color chipBlack = Color(0xFF14161A);
  static const cardBackground = Color(0xFFFFFFFF);
  static const inputFill = Color(0xFFF0F1F4);

  static const installerBg = Color(0xFFE6F0FE);
  static const installerText = Color(0xFF2F80ED);

  static const photographerBg = Color(0xFFFCE8F3);
  static const photographerText = Color(0xFFD6318F);

  static const iconView = Color(0xFF6B7280);
  static const iconEdit = Color(0xFF27AE60);
  static const iconDelete = Color(0xFFEB5757);

  static const statusPending = Color(0xFFF2994A);
  static const statusCompleted = Color(0xFF27AE60);
  static const statusAdded = Color(0xFF27AE60);
  static const statusApproved = Color(0xFF27AE60);
  static const tableHeaderBg = Color(0xFFF3F6FB);

  static const Color pageBackground = Color(0xFFF4F5F7);

  static const Color borderStrong = Color(0xFFD5D8DC);

  static const Color blueDark = Color(0xFF1F86D3);
  static const Color blueLink = Color(0xFF2F80ED);

  static const Color redSoft = Color(0xFFF16A6A);

  static const Color amberLabel = Color(0xFFB8860B);

  static const double radiusSm = 8;
  static const double radiusMd = 10;
  static const double radiusLg = 14;

  // ---- Aliases so the admin-panel widgets map onto your existing palette ----
  static const Color divider = border;
  static const Color primaryBlueDark = blueDark;
  static const Color editGreen = iconEdit;
  static const Color deleteRed = iconDelete;
  static const Color totalBadgeBg = blueBadgeBg;
  static const Color totalBadgeText = blue;
  static const Color searchFieldBg = inputFill;
  static const Color priceText = amberLabel;

  // =========================================================================
  // NEW PALETTE — merged from the 3 pasted AppColors blocks.
  //
  // Every field that was an exact duplicate across the 3 blocks (same name,
  // same hex) appears once below. Where a name collided with a DIFFERENT
  // hex value — either against another pasted block or against the
  // original palette above — the newer one was kept under an `Alt` name so
  // nothing was silently overwritten. See the inline notes.
  // =========================================================================

  // Page / surface backgrounds
  static const Color bg = Color(0xFFF6F7FB); // consistent across all 3 blocks
  static const Color dialogBg = Color(0xFFF3F4F8);
  static const Color cardBg = cardBackground; // identical value to the existing white card bg — aliased, not redefined

  // Borders
  static const Color cardBorder = Color(0xFFE7E9F0);
  static const Color inputBorder = Color(0xFFE3E5EE);
  static const Color rowBorder = Color(0xFFEFF0F5);
  static const Color dividerLight = Color(0xFFECEDF3); // "divider" was already taken (= border) with a different hex, so this is separate

  static const Color amber = Color(0xFFB8860B);

  // Text
  static const Color heading = Color(0xFF1E2233);
  static const Color subtitle = Color(0xFF9AA1B1);
  static const Color label = Color(0xFF394053); // 2 of 3 blocks agreed on this value
  // NOTE: the 3rd block set `label = 0xFF6C63FF`, which is identical to
  // `totalBadgeTextAlt` below (a purple accent) — almost certainly a
  // copy/paste slip in that snippet rather than an intentional text color,
  // so it was not used here. If that purple *was* meant for label text,
  // swap this constant's value to totalBadgeTextAlt's.
  static const Color placeholder = Color(0xFFAEB2C1);
  static const Color featureText = Color(0xFF7A7F91);
  static const Color dateText = Color(0xFF2B2F3C);
  static const Color emailText = Color(0xFFB08A3E);

  // Inputs
  static const Color inputBg = Color(0xFFF4F5F9);

  // Links / accents
  static const Color link = Color(0xFF3B82F6);
  static const Color nameLink = link; // identical value, aliased
  // `primaryBlue` already existed above (0xFF2196F3). All 3 new blocks
  // agreed on a different blue (0xFF3B82F6), so it's kept as its own token
  // rather than overwriting the original:
  static const Color accentBlue = Color(0xFF3B82F6);

  // Reds
  // `red` (Colors.red) and `deleteRed`/`editGreen` (aliases above) already
  // existed with different hexes, so the new snippets' equivalents are
  // kept distinctly named:
  static const Color dangerRed = Color(0xFFE5533D); // "red" / "required" in the pasted blocks
  static const Color required = dangerRed;
  static const Color blockedRedBg = Color(0xFFFDEBEC);
  static const Color blockedRedText = Color(0xFFE53E4D);
  static const Color deleteRedAlt = blockedRedText; // same value as the pasted "deleteRed"

  // Greens
  static const Color teal = Color(0xFF29B6C9);
  static const Color activeGreenBg = Color(0xFFE6F8EC); // 2 blocks used this; 1 used a near-identical 0xFFE4F7EA
  static const Color activeGreenText = Color(0xFF34A853);
  static const Color editGreenAlt = activeGreenText; // pasted "editGreen" — collided with the existing editGreen (0xFF27AE60)
  static const Color checkGreen = activeGreenText; // identical value, aliased

  // Table header
  static const Color headerBg = tableHeaderBg; // near-identical to the pasted "headerBg" (0xFFF3F6FC vs 0xFFF3F6FB) — aliased to the existing one

  // Badges
  // The pasted "totalBadgeBg"/"totalBadgeText" collided with the existing
  // aliases above (which point at blueBadgeBg / blue), so kept separate:
  static const Color totalBadgeBgAlt = Color(0xFFEFEBFF);
  static const Color totalBadgeTextAlt = Color(0xFF6C63FF);

  // =========================================================================
  // SCHEDULING SETTINGS SCREEN ADDITIONS
  //
  // Tokens the Scheduling Settings screen needed that weren't covered by
  // anything above. Two (`panelFill`, `toggleOffTrack`) turned out to be
  // exact-value duplicates of existing colors, so they're aliased rather
  // than redeclared; the rest are genuinely new and added directly.
  // =========================================================================

  static const Color blueIconBg = blueBadgeBg; // identical hex (0xFFDCEAFE vs 0xFFDCEBFE) — reused for the card icon circles
  static const Color orangeMuted = Color(0xFFB98157); // muted "Dashboard" breadcrumb text
  static const Color panelFill = background; // identical value — reused for inset panel backgrounds (toggle rows, etc.)
  static const Color toggleOffTrack = textPrimary; // identical value — used as the Switch "off" thumb/track color
  static const Color inputFillLight = Color(0xFFFAFAFB); // a touch lighter than `inputFill` (0xFFF0F1F4) — kept distinct so this screen's fields don't shift shade
  static const Color purple = Color(0xFF8355D6);
}

class AppText {
  AppText._();

  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle cellLink = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.blueLink,
  );

  static const TextStyle sectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle columnHeader = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle cell = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle cellMuted = TextStyle(
    fontSize: 13,
    color: AppColors.textMuted,
  );

  // ---- Aliases used by the admin-panel widgets ----
  static const TextStyle pageTitle = title;
  static const TextStyle cellText = cell;
  static const TextStyle dialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle price = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.amberLabel,
  );

  // ---- New text styles matching the "heading" / "subtitle" tokens above ----
  static const TextStyle headingDark = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.heading,
  );
  static const TextStyle subtitleMuted = TextStyle(
    fontSize: 12.5,
    color: AppColors.subtitle,
  );
  static const TextStyle labelText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.label,
  );

  // ---- Scheduling Settings screen additions ----
  static const TextStyle breadcrumb = TextStyle(
    fontSize: 12.5,
    color: AppColors.textSecondary,
  );
  static const TextStyle pageSubtitle = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
  static const TextStyle cardTitle = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );
  static const TextStyle optionTitle = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle optionBody = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
    height: 1.35,
  );
  // NOTE: this screen's original "body" style (12.5, textSecondary,
  // height 1.4) collided with the existing `AppText.body` above (13,
  // textPrimary, no line-height) — different size, color, AND purpose
  // (description text vs. primary reading text), so it's kept as its own
  // token rather than overwriting the original:
  static const TextStyle descriptionText = TextStyle(
    fontSize: 12.5,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}

/// Kept as a thin alias so existing call sites (`AppTextStyles.xxx`) keep working.
typedef AppTextStyles = AppText;

InputDecoration inputDecoration({String? hint, EdgeInsetsGeometry? padding}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFFAFAFB),
    contentPadding:
    padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColors.blue, width: 1.4),
    ),
  );
}

/// Input decoration matching the newer "inputBg / inputBorder" tokens,
/// for screens built against the new palette.
InputDecoration inputDecorationAlt({String? hint, EdgeInsetsGeometry? padding}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.placeholder, fontSize: 13),
    isDense: true,
    filled: true,
    fillColor: AppColors.inputBg,
    contentPadding:
    padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.accentBlue, width: 1.4),
    ),
  );
}

/// Small reusable "card" decoration used by every modal/popover.
BoxDecoration modalDecoration({double radius = 12}) {
  return BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.18),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
    ],
  );
}

/// Card decoration matching the newer "cardBg / cardBorder" tokens.
BoxDecoration cardDecorationAlt({double radius = 10}) {
  return BoxDecoration(
    color: AppColors.cardBg,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.cardBorder),
  );
}

/// Bordered white card with a subtle shadow, used by the Scheduling
/// Settings screen's expandable cards. Distinct from `cardDecorationAlt`
/// above (no shadow, different border token) and from `modalDecoration`
/// (heavier shadow, meant for dialogs/popovers).
BoxDecoration cardDecoration({double radius = 10}) {
  return BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.02),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

/// Input decoration matching the Scheduling Settings screen's original
/// palette (lighter fill, `textMuted` hint, `blue` focus ring) — distinct
/// from `inputDecoration` and `inputDecorationAlt` above so none of the
/// three shift shade against each other.
InputDecoration boxedInputDecoration({String? hint, EdgeInsetsGeometry? padding}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
    isDense: true,
    filled: true,
    fillColor: AppColors.inputFillLight,
    contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.blue, width: 1.4),
    ),
  );
}

/// ---------------------------------------------------------------------
/// Badge color pairs (for Sign Type / Category chips), built from your
/// existing palette so chips stay on-brand.
/// ---------------------------------------------------------------------
class BadgeColor {
  final Color background;
  final Color text;
  const BadgeColor(this.background, this.text);
}

class BadgePalette {
  BadgePalette._();

  static const List<BadgeColor> palette = [
    BadgeColor(AppColors.lightBlueBg, AppColors.primaryBlue), // blue
    BadgeColor(AppColors.greenLight, AppColors.green), // green
    BadgeColor(AppColors.photographerBg, AppColors.photographerText), // pink/purple-ish
    BadgeColor(AppColors.orangeLight, AppColors.orange), // orange
    BadgeColor(AppColors.installerBg, AppColors.installerText), // sky blue
    BadgeColor(AppColors.redLight, AppColors.redSoft), // red
  ];

  static BadgeColor colorFor(String key, List<String> orderedKeys) {
    final index = orderedKeys.indexOf(key);
    if (index < 0) return palette[0];
    return palette[index % palette.length];
  }
}

/// Status badge pair for the new "Active" / "Blocked" style rows
/// (agents, users, etc.) introduced by the new palette.
class StatusBadge {
  StatusBadge._();

  static const BadgeColor active = BadgeColor(AppColors.activeGreenBg, AppColors.activeGreenText);
  static const BadgeColor blocked = BadgeColor(AppColors.blockedRedBg, AppColors.blockedRedText);
  static const BadgeColor inStock = BadgeColor(AppColors.greenLight, AppColors.green);
  static const BadgeColor outOfStock = BadgeColor(AppColors.blueBadgeBg, AppColors.blue);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.pageBackground,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
  );
}