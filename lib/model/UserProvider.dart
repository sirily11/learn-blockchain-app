import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/model/abi.dart';
import 'package:learn_blockchain/model/database/Database.dart';
import 'package:learn_blockchain/model/database/DatabasePreferenceProvider.dart';
import 'package:learn_blockchain/model/secrets.dart';
import 'package:web3dart/web3dart.dart';

class UserProvider with ChangeNotifier {
  Database database = DatabasePreferenceProvider();
  Web3Client? web3client;
  Client? httpClient;
  EthereumAddress? contractAddress;
  DeployedContract? contract;

  UserProvider() {
    this.httpClient = new Client();
    this.web3client = new Web3Client(apiUrl, httpClient);
    this.contractAddress = EthereumAddress.fromHex(contractStr);
    this.contract = DeployedContract(
      ContractAbi.fromJson(JsonEncoder().convert(abi), "Learn Blockchain Coin"),
      contractAddress,
    );
  }

  Future<String> getAccount() async {
    return await database.readFromDB("key");
  }

  Future<void> addAccount(String account) async {
    await database.writeToDB("key", account);
  }

  Future<void> updateAccount(String account) async {
    await database.updateDB("key", account);
  }

  Future<double> getAccountBalence(String? account) async {
    await EasyLoading.show();
    if (account != null) {
      try {
        var address = EthereumAddress.fromHex(account);

        final balanceFunction = contract?.function('balanceOf');

        final balance = await web3client?.call(
            contract: contract, function: balanceFunction, params: [address]);
        await EasyLoading.dismiss();
        return (balance?[0] as BigInt).toDouble();
      } catch (err) {
        await EasyLoading.showError("Cannot fetch balence",
            duration: Duration(seconds: 2));
        await EasyLoading.dismiss();
      }
    }
    return 0;
  }

  Future<void> mint(String account, int amout) async {
    try {
      await EasyLoading.show();
      final address = EthereumAddress.fromHex(account);
      final mintFunction = contract?.function("mint");
      await web3client?.call(
          contract: contract, function: mintFunction, params: [address, amout]);
    } catch (err) {
      await EasyLoading.showError("Cannot mint coin");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> addStory(String account, String story) async {
    try {
      await EasyLoading.show();
      final address = EthereumAddress.fromHex(account);
      final addStoryFunction = contract?.function("mint");
      await web3client?.call(
        contract: contract,
        function: addStoryFunction,
        params: [story],
        sender: address,
      );

      await EasyLoading.dismiss();
    } catch (err) {
      await EasyLoading.showError("Cannot add story. $err");
      await EasyLoading.dismiss();
    }
  }

  Future<List<Story>?> getStories(int start, int end) async {
    try {
      await EasyLoading.show();

      final getStoryFunction = contract?.function("getStoryInRange");
      final s = await web3client?.call(
        contract: contract,
        function: getStoryFunction,
        params: [start, end],
      );

      await EasyLoading.dismiss();
      return (s as List).map((e) => Story.fromJson(e)).toList();
    } catch (err) {
      await EasyLoading.showError("Cannot add story. $err");
      await EasyLoading.dismiss();
    }
  }

  Future<int?> getStorySize() async {
    try {
      await EasyLoading.show();

      final getStoryFunction = contract?.function("getStoryInRange");
      final s = await web3client?.call(
        contract: contract,
        function: getStoryFunction,
        params: [],
      );

      await EasyLoading.dismiss();
      return (s?[0] as BigInt).toInt();
    } catch (err) {
      await EasyLoading.showError("Cannot add story. $err");
      await EasyLoading.dismiss();
    }
  }
}
