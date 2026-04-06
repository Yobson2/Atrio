import 'package:flutter/material.dart';

/// Semantic icon mapping for the design system.
///
/// Centralizes icon choices so they can be changed in one place.
/// Organized by domain category.
class AppIcons {
  const AppIcons._();

  // ── Navigation ─────────────────────────────────────────────

  static const IconData home = Icons.home_outlined;
  static const IconData homeActive = Icons.home;
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close;
  static const IconData menu = Icons.menu;
  static const IconData more = Icons.more_vert;
  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsActive = Icons.settings;
  static const IconData profile = Icons.person_outline;
  static const IconData profileActive = Icons.person;

  // ── Salon & Barber ─────────────────────────────────────────

  static const IconData salon = Icons.storefront_outlined;
  static const IconData salonActive = Icons.storefront;
  static const IconData barber = Icons.content_cut;
  static const IconData chair = Icons.chair_outlined;
  static const IconData services = Icons.list_alt_outlined;

  // ── Booking ────────────────────────────────────────────────

  static const IconData booking = Icons.calendar_today_outlined;
  static const IconData bookingActive = Icons.calendar_today;
  static const IconData calendar = Icons.calendar_month_outlined;
  static const IconData time = Icons.access_time_outlined;
  static const IconData schedule = Icons.schedule;

  // ── Queue ──────────────────────────────────────────────────

  static const IconData queue = Icons.people_outline;
  static const IconData queueActive = Icons.people;
  static const IconData live = Icons.fiber_manual_record;
  static const IconData skip = Icons.skip_next;
  static const IconData advance = Icons.arrow_forward;

  // ── Actions ────────────────────────────────────────────────

  static const IconData search = Icons.search;
  static const IconData filter = Icons.tune;
  static const IconData add = Icons.add;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline;
  static const IconData share = Icons.share_outlined;
  static const IconData favorite = Icons.favorite_border;
  static const IconData favoriteActive = Icons.favorite;
  static const IconData refresh = Icons.refresh;
  static const IconData sort = Icons.sort;

  // ── Info & Status ──────────────────────────────────────────

  static const IconData location = Icons.location_on_outlined;
  static const IconData phone = Icons.phone_outlined;
  static const IconData email = Icons.email_outlined;
  static const IconData rating = Icons.star;
  static const IconData ratingOutlined = Icons.star_border;
  static const IconData ratingHalf = Icons.star_half;
  static const IconData price = Icons.attach_money;
  static const IconData info = Icons.info_outline;
  static const IconData warning = Icons.warning_amber_outlined;
  static const IconData error = Icons.error_outline;
  static const IconData success = Icons.check_circle_outline;

  // ── Notification ───────────────────────────────────────────

  static const IconData notification = Icons.notifications_outlined;
  static const IconData notificationActive = Icons.notifications;

  // ── Connectivity & Sync ────────────────────────────────────

  static const IconData offline = Icons.wifi_off;
  static const IconData online = Icons.wifi;
  static const IconData sync = Icons.cloud_upload_outlined;
  static const IconData synced = Icons.cloud_done_outlined;

  // ── Auth ────────────────────────────────────────────────────

  static const IconData login = Icons.login;
  static const IconData logout = Icons.logout;
  static const IconData lock = Icons.lock_outline;
  static const IconData visibility = Icons.visibility_outlined;
  static const IconData visibilityOff = Icons.visibility_off_outlined;

  // ── Media ──────────────────────────────────────────────────

  static const IconData camera = Icons.camera_alt_outlined;
  static const IconData gallery = Icons.photo_library_outlined;
  static const IconData image = Icons.image_outlined;

  // ── Misc ───────────────────────────────────────────────────

  static const IconData chevronRight = Icons.chevron_right;
  static const IconData chevronLeft = Icons.chevron_left;
  static const IconData expandMore = Icons.expand_more;
  static const IconData expandLess = Icons.expand_less;
  static const IconData map = Icons.map_outlined;
  static const IconData dashboard = Icons.dashboard_outlined;
  static const IconData dashboardActive = Icons.dashboard;
  static const IconData stats = Icons.bar_chart;
  static const IconData empty = Icons.inbox_outlined;

  // ── Theme ──────────────────────────────────────────────────

  static const IconData lightMode = Icons.light_mode_outlined;
  static const IconData darkMode = Icons.dark_mode_outlined;
  static const IconData systemMode = Icons.brightness_auto_outlined;
}
