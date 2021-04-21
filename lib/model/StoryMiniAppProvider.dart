import 'package:flutter/material.dart';
import 'package:learn_blockchain/model/StoryProvider.dart';

/// This provider will provide some functions for the story
/// For example, start a poll, make a payment, get poll results,
/// make a payment and get user info
class StoryMiniAppProvider extends StoryProvider {
  /// User auth
  Future<bool> auth() async {
    return false;
  }

  /// Make a payment. Will return total number of amount transered
  Future<double> makePayment(
      {required String sender,
      required String receiver,
      required double amount}) async {
    return 0;
  }

  Future<bool> showComments() async {
    return false;
  }

  /// Make a poll. Return true if the success
  Future<bool> makePoll(
      {required String fromUser,
      required Map<String, dynamic> value,
      required quizID}) async {
    return false;
  }

  /// Get poll results.
  ///
  /// questionID: value
  Future<Map<String, dynamic>> getPollResults({required quizID}) async {
    return {};
  }
}
