/* ---------------------------- SideNavbarItemDef --------------------------- */
/// The class holding the data for each selectable item in the side navbar.
class SideNavbarItemDef {
  SideNavbarItemDef({
    required this.route,
    required this.iconAsset,
    required this.keyFrames,
    this.isSelected = false,
    this.needsReset = false,
  }) : assert(keyFrames.length == 4);

  /// The navigation route that the user will be taken to when they click.
  String route;

  /// The path to the .json file of the icon used. This will be converted to a [JdtIcon]
  String iconAsset;

  /// The keyframes of the animation
  /// [keyFrames[0]] - Introduction animation start keyframe (typically frame where icon is invisible).
  /// [keyFrames[1]] - End of introduction animation keyframe.
  /// [keyFrames[2]] - Start of hover animation (this will also be what the icon looks like when the user is not hovering).
  /// [keyFrames[3]] - The end of the hover animation (this will also be what the icon looks like when the user has selected it).
  List<double> keyFrames;

  /// Is this item currently selected?
  bool isSelected;

  /// Does this items icons animation need to be reset.
  bool needsReset;
}
