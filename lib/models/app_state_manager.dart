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

  // TODO: Add initializeApp
  // TODO: Add login
  // TODO: Add completeOnboarding
  // TODO: Add goToTab
  // TODO: Add goToRecipes
  // TODO: Add logout
}