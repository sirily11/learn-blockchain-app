![logo](images/learn-blockchain.png)

## Introduction

Learn blockchain is an app which helps people to learn the concept of block chain by building a cryptocurrency.

It contains follow functinalities:

- Quizzes to help understand the blockchain
- User friendly UI
- Reward!
- Store your store in the ethereum network forever!

## Story function

Story is a place that you can share your story and stored in the block chain network forever. And you can also follow others by entering their wallet address.

# Installation

## First step

you first need to download the Flutter framework and setup everything that Flutter requires.

And second add update your vscode configuration like this

```json
 {
            "name": "learn_blockchain",
            "request": "launch",
            "type": "dart",
            "args": ["--no-sound-null-safety"]
 },
```

This will disable the null-safety check for your app.

## Second step

Create a `secrets.dart` file under `lib/model` folder. And have the content like this:

```dart
final apiUrl = "http://0.0.0.0:8545";
final contractStr = "some string";
```

## Third step

Download node.js on your local computer

## Fourth step

Download Ganache on your computer for local ethereum development

## Fifth step

Deploy the smart contract locally using this [file](coin/erc20-token-sample.sol)

## Final step

Install dependencies by typing `flutter pub get` in the main folder and `npm install` in demo_web_app folder

# Run the app

1. Start flutter app by following the instruction on Flutter website

2. Start the webapp in demo_web_app by typing `npm start`

3. Start you Ganache local eth network app

4. Enjoy
