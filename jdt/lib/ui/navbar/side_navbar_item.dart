// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jdt/ui/icons/generic_icon.dart';
import 'package:jdt/ui/navbar/side_navbar_item_def.dart';

/* ----------------------------- SideNavbarItem ----------------------------- */
/// The widget representation of the [SideNavbar] options that the user can tap
/// to navigate to a specific page.
class SideNavbarItem extends StatefulWidget {
  SideNavbarItem({
    super.key,
    required this.definition,
    required this.clearNavSelection,
  });

  /// The class used to model the data stored in this widget.
  SideNavbarItemDef definition;

  /// Callback refered to when the item is clicked on.
  final void Function(String) clearNavSelection;

  @override
  State<SideNavbarItem> createState() => _SideNavbarItemState();
}

class _SideNavbarItemState extends State<SideNavbarItem> {
  /* ------------------------------ _iconSelected ----------------------------- */
  /// Runs once the icon has been selected by the user.
  _iconSelected() {
    setState(() {
      /// Run the clear navigation callback with the provided route of the [SideNavbarItemDef]
      widget.clearNavSelection(widget.definition.route);
      widget.definition.isSelected = true;
    });
  }

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    return GenericIcon(
      needsReset: widget.definition.needsReset,
      tapCallback: _iconSelected,
      asset: widget.definition.iconAsset,
      introStartKeyFrame: widget.definition.keyFrames[0],
      introEndKeyFrame: widget.definition.keyFrames[1],
      hoverStartKeyFrame: widget.definition.keyFrames[2],
      hoverEndKeyFrame: widget.definition.keyFrames[3],
      isSelected: widget.definition.isSelected,
    );
  }
}
