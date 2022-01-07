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
    // Determines the state of the app. It manages whether the app initialized login and if the user completed the onboarding.
    appStateManager.addListener(notifyListeners);
    // Manages the list of grocery items and the item selection state.
    groceryManager.addListener(notifyListeners);
    // Manages the user’s profile and settings.
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  // RouterDelegate requires to add a build(). This configures navigator and pages.
  @override
  Widget build(BuildContext context) {
    // Configures a Navigator.
    return Navigator(
      // Uses the navigatorKey, which is required to retrieve the current navigator.
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // Declares pages, the stack of pages that describes navigation stack.
      pages: [
        // Add SplashScreen.
        if (!appStateManager.isInitialized) SplashScreen.page(),
        // Add LoginScreen.
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        // Add OnboardingScreen.
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        // Add Home.
        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),
        // Create new item.
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            // If so, shows the Grocery Item screen.
            onCreate: (item) {
              // Once the user saves the item, updates the grocery list.
              groceryManager.addItem(item);
            },
            onUpdate: (item, index) {
              // onUpdate only gets called when the user updates an existing item.
            },
          ),
        // Select GroceryItemScreen.
        // Checks to see if a grocery item is selected.
        if (groceryManager.selectedIndex != -1)
          // If so, creates the Grocery Item screen page.
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                // When the user changes and saves an item, it updates the item at the current index.
                groceryManager.updateItem(item, index);
              },
              onCreate: (_) {
                // onCreate only gets called when the user adds a new item.
              }),
        // Add Profile Screen.
        // This checks the profile manager to see if the user selected their profile. If so, it shows the Profile screen.
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),

        // Add WebView Screen.
        // This checks if the user tapped the option to go to the raywenderlich.com website. If so, it presents the WebView screen.
        if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
      ],
    );
  }

  bool _handlePopPage(
      // This is the current Route, which contains information like RouteSettings to retrieve the route’s name and arguments.
      Route<dynamic> route,
      // result is the value that returns when the route completes — a value that a dialog returns, for example.
      result) {
    // Checks if the current route’s pop succeeded.
    if (!route.didPop(result)) {
      return false;
    }

    // If the route pop succeeds, this checks the different routes and triggers the appropriate state changes.

    // If the user taps the Back button from the Onboarding screen, it calls logout(). This resets the entire app state and the user has to log in again.
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    // This ensures that the appropriate state is reset when the user taps the back button from the Grocery Item screen.
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    // This checks to see if the route you are popping is indeed the profilePath, then tells the profileManager that the Profile screen is not visible anymore.
    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    // Here, you check if the name of the route setting is raywenderlich, then call the appropriate method on profileManager.
    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
