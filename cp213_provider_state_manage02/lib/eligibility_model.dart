import 'package:flutter/material.dart';

class EligibilityModel extends ChangeNotifier {
  String _eligibilityMessage = "";
  bool _isEligible = false;

  String get eligibilityMessage => _eligibilityMessage;
  bool get isEligible => _isEligible;

  // Check eligibility based on age
  void checkEligibility(int age) {
    if (age >= 18) {
      eligibleForVoting();
    } else {
      notEligibleForVoting();
    }
  }

  // User is eligible for voting
  void eligibleForVoting() {
    _eligibilityMessage = "You are eligible for Voting";
    _isEligible = true;
    notifyListeners();
  }

  // User is not eligible for voting
  void notEligibleForVoting() {
    _eligibilityMessage = "You are not eligible for Voting";
    _isEligible = false;
    notifyListeners();
  }
}
