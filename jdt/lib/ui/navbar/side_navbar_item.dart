import 'package:flutter/material.dart';
import 'package:jdt/ui/icons/animated_icon.dart';
import 'package:jdt/ui/icons/generic_icon.dart';
import 'package:jdt/ui/navbar/side_navbar_item_def.dart';

class SideNavbarItem extends StatefulWidget {
  SideNavbarItem({
    super.key,
    required this.definition,
    required this.clearNavSelection,
  });

  SideNavbarItemDef definition;
  final void Function(String) clearNavSelection;

  @override
  State<SideNavbarItem> createState() => _SideNavbarItemState();
}

class _SideNavbarItemState extends State<SideNavbarItem> {
  _iconSelected() {
    setState(() {
      widget.clearNavSelection(widget.definition.route);
      widget.definition.isSelected = true;
    });
  }

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
