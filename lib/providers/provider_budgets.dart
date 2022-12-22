import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../objects/budget.dart';
import '../objects/transaction.dart';

import './functions.dart' as functions;

class ProviderBudgets with ChangeNotifier {
  Budget? _privateBudget;
  Budget? _publicBudget;
  Budget? _houseBudget;

  // Returns users personal budget
  Budget? get privateBudget {
    return _privateBudget;
  }

  // Returns users public budget
  Budget? get publicBudget {
    return _publicBudget;
  }

  // Returns the total budget of the house
  Budget? get houseBudget {
    return _houseBudget;
  }

  Future<void> fetchBudgets({required String jwt}) async {
    http.Response response = await functions.httpGet(
      resourcePath: '/budget/get-budgets',
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
      },
    );
    // BUG Unhandled exception if run when not authenticated.
    //     Json is not a list of maps in that case so
    //     [userDataList] is no iterable.
    var payload = jsonDecode(response.body);
    _privateBudget = Budget.fromMap(map: payload['private_budget']);
    _publicBudget = Budget.fromMap(map: payload['public_budget']);
    _houseBudget = Budget.fromMap(map: payload['house_budget']);
    //print(userDataList);
    notifyListeners();
  }

  Future<void> editBudget({
    required String jwt,
    double? privateIncome,
    double? privateExpense,
    double? publicIncome,
    double? publicExpense,
  }) async {
    http.Response response = await functions
        .httpPut(resourcePath: '/budget/edit-budget', headers: <String, String>{
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      'private_income': privateIncome,
      'private_expenses': privateExpense,
      'public_income': publicIncome,
      'public_expenses': publicExpense,
    });
    if (response.statusCode != 204) {
      throw Future.error('${response.statusCode}:${response.reasonPhrase}');
    }
    fetchBudgets(jwt: jwt);
  }
}
