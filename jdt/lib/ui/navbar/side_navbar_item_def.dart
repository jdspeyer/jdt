class SideNavbarItemDef {
  SideNavbarItemDef({
    required this.route,
    required this.iconAsset,
    required this.keyFrames,
    this.isSelected = false,
    this.needsReset = false,
  }) : assert(keyFrames.length == 4);

  String route;
  String iconAsset;
  List<double> keyFrames;
  bool isSelected;
  bool needsReset;
}
