enum MainTab {
  home,
  reels,
  shop,
  wishlist,
  more,
}

extension MainTabX on MainTab {
  int get index => MainTab.values.indexOf(this);

  static MainTab fromIndex(int index) {
    if (index < 0 || index >= MainTab.values.length) {
      return MainTab.home;
    }
    return MainTab.values[index];
  }
}
