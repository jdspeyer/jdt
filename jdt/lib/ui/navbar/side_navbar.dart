// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/icons/hover_icon.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/navbar/side_navbar_item.dart';
import 'package:jdt/ui/navbar/side_navbar_item_def.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

/* ------------------------------- SideNavbar ------------------------------- */
/// The navbar which appears on the [DashboardScreen] of the application.
/// Used for subnavigation
class SideNavbar extends ConsumerStatefulWidget {
  SideNavbar({
    super.key,
    required this.width,
    required this.height,
    required this.delegate,
  });

  /// Width and head of navbar
  double width;
  double height;

  /// Delegate used for navigation between pages
  BeamerDelegate delegate;

  /// Tracks which navigation option is currently selected.
  bool isSelected = false;

  /// Additional navigation options can be added here
  /// This list is converted to visual widgets that appear on the navbar.
  late final List<SideNavbarItemDef> _navbarItemDefinitions = [
    /// Home option
    SideNavbarItemDef(
      route: '/dashboard/home',
      iconAsset: 'assets/images/lottie/home-icon.rough.json',
      keyFrames: const [0.0, 0.13, 0.86, 1],
    ),

    /// Add module option
    SideNavbarItemDef(
      route: '/dashboard/addmodule',
      iconAsset: 'assets/images/lottie/add-module-icon.rough.json',
      keyFrames: const [0.0, 0.2, 0.7, 1],
    ),

    /// Create module stack option
    SideNavbarItemDef(
      route: '/dashboard/modulestack',
      iconAsset: 'assets/images/lottie/module-stacks-icon.rough.json',
      keyFrames: const [0.0, 0.11, 0.55, 0.8],
    ),

    /// Settings option
    SideNavbarItemDef(
      route: '/dashboard/settings',
      iconAsset: 'assets/images/lottie/settings-icon.rough.json',
      keyFrames: const [0.0, 0.2, 0.7, 1],
    ),

    /// Documentation option
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
  /// Theme manager and current theme
  final ModuleThemeManager _manager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _manager.currentTheme;

  /* ---------------------------- _navigateToSignIn --------------------------- */
  /// Called when the logout button is pressed. De-auths the currently signed in user
  /// and then navigates back to the sign in screen.
  _navigateToSignIn() async {
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    await authAWSRepo.logout();
    Beamer.of(context).beamTo(AuthenticationLocation());
  }

  /* -------------------------- _generateNavbarItems -------------------------- */
  /// Generates the list of [SideNavbarItem]s which are displayed in the navbar. Called from build.
  List<Widget> _generateNavbarItems() {
    List<Widget> items = [];

    /// Loop through the above list.
    for (SideNavbarItemDef itemDef in widget._navbarItemDefinitions) {
      items.add(
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: _manager.currentTheme.innerVerticalPadding),
          child: SideNavbarItem(
            definition: itemDef,
            clearNavSelection: _clearNavSelection,
          ),
        ),
      );
    }

    /// return list of navigation widgets.
    return items;
  }

  /* --------------------------- _clearNavSelection --------------------------- */
  /// Clears navbar selection colors using the logic depicted below.
  _clearNavSelection(String route) {
    setState(() {
      /// 1.) Loop through all navigation options.
      for (SideNavbarItemDef itemDef in widget._navbarItemDefinitions) {
        /// 2.) [itemDef.needsReset] will trigger the animation from selection back to resting. This should only be
        /// set for the currently selected icon before the one the user just clicked on is processed.
        /// We set them all to false by default and then enable the one we want to reset.
        itemDef.needsReset = false;

        /// 3.) This gets the navigation icon of the page we just left. [route] represents the
        /// new page. So if we check if its selected but the routes don't match then we will only be
        /// left with the previous page.
        if (itemDef.isSelected && itemDef.route != route) {
          itemDef.needsReset = true;
        }

        /// 4.) This is the page we selected from the menu. Mark it as selected and navigate to it.
        if (itemDef.route == route) {
          itemDef.isSelected = true;

          widget.delegate.beamToNamed(itemDef.route);
        }

        /// 5.) Otherwise we dont want anything to do with the option. Make sure it is not selected.
        else {
          itemDef.isSelected = false;
        }
      }
    });
  }

  /* -------------------------------- initState ------------------------------- */
  @override
  void initState() {
    /// Default navigation location when the app first opens
    _clearNavSelection('/dashboard/home');
    super.initState();
  }

  /* ---------------------------------- build --------------------------------- */
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
              /// Navigation Options
              Column(
                children: _generateNavbarItems(),
              ),

              /// Logout Button
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
                  duration: const Duration(milliseconds: 600),
                  tapCallback: _navigateToSignIn,
                ),
              )
            ]),
      ),
    );
  }
}
