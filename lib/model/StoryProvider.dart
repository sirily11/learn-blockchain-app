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
import 'package:learn_blockchain/pages/settings/AccountAddressDialog.dart';
import 'package:web3dart/web3dart.dart';

class StoryProvider with ChangeNotifier {
  Database database = DatabasePreferenceProvider();
  Web3Client? web3client;
  Client? httpClient;
  EthereumAddress? contractAddress;
  DeployedContract? contract;

  StoryProvider() {
    this.httpClient = new Client();
    this.web3client = new Web3Client(apiUrl, httpClient);
    this.contractAddress = EthereumAddress.fromHex(contractStr);
    this.contract = DeployedContract(
      ContractAbi.fromJson(JsonEncoder().convert(abi), "Learn Blockchain Coin"),
      contractAddress,
    );
  }

  Future<AddressData> getAccount() async {
    return AddressData(
      address: await database.readFromDB("key"),
      privateKey: await database.readFromDB("privateKey"),
    );
  }

  Future<void> addAccount(String account) async {
    await database.writeToDB("key", account);
  }

  Future<void> updateAccount(String account, String privateKey) async {
    await database.updateDB("key", account);
    await database.updateDB("privateKey", privateKey);
  }

  Future<double> getAccountBalence(String? privateKey) async {
    await EasyLoading.show();
    if (privateKey != null) {
      try {
        var address = await web3client?.credentialsFromPrivateKey(privateKey);

        final balanceFunction = contract?.function('balanceOf');

        final balance = await web3client
            ?.call(contract: contract, function: balanceFunction, params: [
          await address?.extractAddress(),
        ]);
        await EasyLoading.dismiss();
        return (balance?[0] as BigInt).toDouble();
      } catch (err) {
        await EasyLoading.showError(
          "Cannot fetch balence. $err",
        );
        await Future.delayed(Duration(seconds: 2));
        await EasyLoading.dismiss();
      }
    }
    EasyLoading.dismiss();
    return 0;
  }

  Future<void> mint(String privateKey, int amout) async {
    try {
      await EasyLoading.show();
      var cred = await web3client?.credentialsFromPrivateKey(
        privateKey,
      );
      final mintFunction = contract?.function("reward");
      var signedTx = await web3client?.signTransaction(
        cred,
        Transaction.callContract(
          contract: contract,
          function: mintFunction,
          parameters: [BigInt.from(amout)],
          gasPrice: EtherAmount.inWei(BigInt.one),
          maxGas: 3000000,
        ),
      );

      await web3client?.sendRawTransaction(signedTx);
    } catch (err) {
      await EasyLoading.showError("Cannot mint coin");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<bool> addStory(String account, String privateKey, String story) async {
    try {
      await EasyLoading.show();
      final addStoryFunction = contract?.function("addStory");
      var cred = await web3client?.credentialsFromPrivateKey(
        privateKey,
      );
      var signedTx = await web3client?.signTransaction(
        cred,
        Transaction.callContract(
          contract: contract,
          function: addStoryFunction,
          parameters: [story],
          gasPrice: EtherAmount.inWei(BigInt.two),
          maxGas: 3000000,
        ),
      );

      await web3client?.sendRawTransaction(signedTx);
      await EasyLoading.dismiss();
      return true;
    } catch (err) {
      print(err);
      await EasyLoading.showError(
        "$err",
      );
      await Future.delayed(Duration(seconds: 2));
      await EasyLoading.dismiss();
      return false;
    }
  }

  Future<List<Story>?> getStories(int start, int end) async {
    try {
      await EasyLoading.show();

      final getStoryFunction = contract?.function("getStoryInRange");
      final s = await web3client?.call(
        contract: contract,
        function: getStoryFunction,
        params: [
          BigInt.from(start),
          BigInt.from(end),
        ],
      );

      await EasyLoading.dismiss();
      List<dynamic> result =
          (s?[0]).map((e) => Story.fromJson(JsonDecoder().convert(e))).toList();
      return result.map((e) => e as Story).toList();
    } catch (err) {
      await EasyLoading.showError("Cannot get story. $err");
      await Future.delayed(Duration(seconds: 2));
      await EasyLoading.dismiss();
    }
  }

  Future<int?> getStorySize() async {
    try {
      await EasyLoading.show();

      final getStoryFunction = contract?.function("getStorySize");
      final s = await web3client?.call(
        contract: contract,
        function: getStoryFunction,
        params: [],
      );

      await EasyLoading.dismiss();
      return (s?[0] as BigInt).toInt();
    } catch (err) {
      await EasyLoading.showError("Cannot get story size. $err");
      await Future.delayed(Duration(seconds: 2));
      await EasyLoading.dismiss();
    }
  }
}
