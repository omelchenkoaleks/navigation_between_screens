import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // Declares GlobalKey, a unique key across the entire app.
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // Declares AppStateManager. The router will listen to app state changes to configure the navigator’s list of pages.
  final AppStateManager appStateManager;
  // Declares GroceryManager to listen to the user’s state when you create or edit an item.
  final GroceryManager groceryManager;
  // Declares ProfileManager to listen to the user profile state.
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    // TODO: Add Listeners
  }

  // TODO: Dispose listeners

  // RouterDelegate requires to add a build(). This configures navigator and pages.
  @override
  Widget build(BuildContext context) {
    // Configures a Navigator.
    return Navigator(
      // Uses the navigatorKey, which is required to retrieve the current navigator.
      key: navigatorKey,
      // TODO: Add onPopPage
      // Declares pages, the stack of pages that describes navigation stack.
      pages: [
        // TODO: Add SplashScreen
        // TODO: Add LoginScreen
        // TODO: Add OnboardingScreen
        // TODO: Add Home
        // TODO: Create new item
        // TODO: Select GroceryItemScreen
        // TODO: Add Profile Screen
        // TODO: Add WebView Screen
      ],
    );
  }

  // TODO: Add _handlePopPage

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
