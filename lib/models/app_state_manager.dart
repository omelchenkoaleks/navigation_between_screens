import 'dart:async';
import 'package:flutter/material.dart';

// Creates constants for each tab the user taps.
class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  // _initialized checks if the app is initialized.
  bool _initialized = false;
  // _loggedIn lets you check if the user has logged in.
  bool _loggedIn = false;
  // _onboardingComplete checks if the user completed the onboarding flow.
  bool _onboardingComplete = false;
  // _selectedTab keeps track of which tab the user is on.
  int _selectedTab = FooderlichTab.explore;

  // These are getter methods for each property.
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    // This sets how long the splash screen will display after the user launches the app.  In a real app you would call the server to get feature flags or app configurations.
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        // Notifies all listeners.
        notifyListeners();
      },
    );
  }

  // In a real scenario, make an API request to log in. In this case, however, just using a mock.
  void login(String username, String password) {
    // Sets loggedIn to true.
    _loggedIn = true;
    // Notifies all listeners.
    notifyListeners();
  }

  // Calling completeOnboarding() will notify all listeners that the user has completed the onboarding guide.
  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  // goToTab sets the index of _selectedTab and notifies all listeners.
  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  // TODO: Add goToRecipes
  // TODO: Add logout
}
