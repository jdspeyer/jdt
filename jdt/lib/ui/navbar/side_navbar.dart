// ignore_for_file: must_be_immutable

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/icons/generic_icon.dart';
import 'package:jdt/ui/icons/hover_icon.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/navbar/side_navbar_item.dart';
import 'package:jdt/ui/navbar/side_navbar_item_def.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SideNavbar extends ConsumerStatefulWidget {
  SideNavbar({
    super.key,
    required this.width,
    required this.height,
    required this.delegate,
  });

  double width;
  double height;
  bool isSelected = false;
  BeamerDelegate delegate;

  late final List<SideNavbarItemDef> _navbarItemDefinitions = [
    SideNavbarItemDef(
      route: '/dashboard/home',
      iconAsset: 'assets/images/lottie/home-icon.rough.json',
      keyFrames: const [0.0, 0.13, 0.86, 1],
    ),
    SideNavbarItemDef(
      route: '/dashboard/addmodule',
      iconAsset: 'assets/images/lottie/add-module-icon.rough.json',
      keyFrames: const [0.0, 0.2, 0.7, 1],
    ),
    SideNavbarItemDef(
      route: '/dashboard/modulestack',
      iconAsset: 'assets/images/lottie/module-stacks-icon.rough.json',
      keyFrames: const [0.0, 0.11, 0.55, 0.8],
    ),
    SideNavbarItemDef(
      route: '/dashboard/settings',
      iconAsset: 'assets/images/lottie/settings-icon.rough.json',
      keyFrames: const [0.0, 0.2, 0.7, 1],
    ),
    SideNavbarItemDef(
      route: '/dashboard/documentation',
      iconAsset: 'assets/images/lottie/documentation-icon.rough.json',
      keyFrames: const [0.0, 0.2, 0.82, 1],
    ),
  ];

  @override
  ConsumerState<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends ConsumerState<SideNavbar> {
  late bool _isSelected = widget.isSelected;
  final ModuleThemeManager _manager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _manager.currentTheme;

  _navigateToSignIn() async {
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    await authAWSRepo.logout();
    Beamer.of(context).beamTo(AuthenticationLocation());
  }

  List<Widget> _generateNavbarItems() {
    List<Widget> items = [];
    for (SideNavbarItemDef itemDef in widget._navbarItemDefinitions) {
      items.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: _manager.currentTheme.innerVerticalPadding),
        child: SideNavbarItem(
          definition: itemDef,
          clearNavSelection: _clearNavSelection,
        ),
      ));
    }

    return items;
  }

  _clearNavSelection(String route) {
    setState(() {
      for (SideNavbarItemDef itemDef in widget._navbarItemDefinitions) {
        itemDef.needsReset = false;

        if (itemDef.isSelected && itemDef.route != route) {
          itemDef.needsReset = true;
        }

        if (itemDef.route == route) {
          itemDef.isSelected = true;

          widget.delegate.beamToNamed(itemDef.route);
        } else {
          itemDef.isSelected = false;
        }
      }
    });
  }

  @override
  void initState() {
    _clearNavSelection('/dashboard/home');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: _loadedTheme.outerHorizontalPadding,
        right: _loadedTheme.outerHorizontalPadding,
      ),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: _loadedTheme.innerVerticalPadding),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(_loadedTheme.cardBorderRadius)),
          color: Theme.of(context).cardColor,
        ),
        width: widget.width,
        height: widget.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: _generateNavbarItems(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: _loadedTheme.innerHorizontalPadding * 0.5,
                    vertical: _loadedTheme.innerVerticalPadding * 0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(_loadedTheme.cardBorderRadius * 0.75)),
                  color: _loadedTheme.textColor.withOpacity(0.5),
                ),
                child: HoverIcon(
                  color: _loadedTheme.accentColor,
                  asset: 'assets/images/lottie/logout-icon.rough.json',
                  needsReset: false,
                  introStartKeyFrame: 0.0,
                  introEndKeyFrame: 0.2,
                  hoverStartKeyFrame: 0.8,
                  hoverEndKeyFrame: 1,
                  duration: Duration(milliseconds: 600),
                  tapCallback: _navigateToSignIn,
                ),
              )
            ]),
      ),
    );
  }
}
