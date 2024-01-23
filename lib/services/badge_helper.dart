class BadgeHelper {
  static int _badgeCount = 0;

  static int get badgeCount => _badgeCount;

  static void setBadgeCount(int count) {
    _badgeCount = count;
  }

  static void resetBadgeCount() {
    _badgeCount = 0;
  }
}
