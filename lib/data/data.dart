import 'package:learn_blockchain/model/DocumentData.dart';

const documentDataList = [
  {
    "title": "Play with block chain: Introduction to Blockchain",
    "description": "Basic intro to block chain",
    "playgroundPath": "/hash",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "image": "assets/logos/part1/logo1.jpeg",
    "documentData": [
      {
        "path": "assets/document/part1/decentralization.md",
        "title": "Decentralization",
        "source": "assets",
        "type": "md",
      },
      {
        "path": "assets/document/part1/what_is_block_chain.md",
        "title": "What is block chain",
        "source": "assets",
        "type": "md",
      }
    ]
  },
  {
    "title": "Token Money",
    "description":
        "Token money, or token, is money that has little intrinsic value compared to its face value. Unlike fiat money, which also has little intrinsic value, it is limited legal tender. It does not have free coinage.",
    "image": "assets/logos/part2/logo2.jpeg",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "documentData": [
      {
        "path":
            "https://notes.sirileepage.com/files/MSBD5017/Lecture2-Token-Money-Feb19-2021.pdf",
        "source": "internet",
        "type": "pdf",
        "title": "Token Money"
      },
    ]
  },
  {
    "title": "Cryptography",
    "description": "Only authorized parties are able to understand the data.",
    "image": "assets/logos/part3/logo3.jpeg",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "documentData": [
      {
        "path":
            "https://notes.sirileepage.com/files/MSBD5017/Lecture3-Cryptography-Feb26-2021.pdf",
        "source": "internet",
        "type": "pdf",
        "title": "Token Money"
      },
    ]
  },
  {
    "title": "Block Chain Structure",
    "description": "",
    "image": "assets/logos/part4/logo4.png",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "documentData": [
      {
        "path":
            "https://notes.sirileepage.com/files/MSBD5017/Lecture4-Blockchain-Structure-Mar-5.pdf",
        "source": "internet",
        "type": "pdf",
        "title": "Token Money"
      },
    ]
  },
  {
    "title": "Block Chain Consensus",
    "description": "",
    "image": "assets/logos/part5/part5.jpeg",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "documentData": [
      {
        "path":
            "https://notes.sirileepage.com/files/MSBD5017/Lecture6-Blockchain-Consensus-Mar19-2021.pdf",
        "source": "internet",
        "type": "pdf",
        "title": "Token Money"
      },
    ]
  },
  {
    "title": "Play with block chain: Simple Block Chain",
    "description": "",
    "image": "assets/logos/part5/part5.jpeg",
    "playgroundPath": "/difficulty",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "documentData": [
      {
        "path": "assets/document/part2/difficulty.md",
        "title": "Decentralization",
        "source": "assets",
        "type": "md",
      },
    ]
  }
];

var documents = documentDataList.map((e) => Lesson.fromJSON(e)).toList();
