import 'package:learn_blockchain/model/DocumentData.dart';

const documentDataList = [
  {
    "title": "Introduction to Blockchain",
    "description": "Basic intro to block chain",
    "playgroundPath": "/hash",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "image": "assets/logos/part1/logo1.jpeg",
    "documentData": [
      {
        "path": "assets/document/part1/decentralization.md",
        "title": "Decentralization"
      },
      {
        "path": "assets/document/part1/what_is_block_chain.md",
        "title": "What is block chain"
      }
    ]
  },
  {
    "title": "Introduction to Blockchain2",
    "description": "Basic intro to block chain",
    "playgroundPath": "/hash",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "image": "assets/logos/part1/logo1.jpeg",
    "documentData": [
      {
        "path": "assets/document/part1/decentralization.md",
        "title": "Decentralization"
      },
      {
        "path": "assets/document/part1/what_is_block_chain.md",
        "title": "What is block chain"
      }
    ]
  },
  {
    "title": "Introduction to Blockchain3",
    "description": "Basic intro to block chain",
    "playgroundPath": "/hash",
    "quizPath": "assets/quizzes/part1/quiz1.json",
    "image": "assets/logos/part1/logo1.jpeg",
    "documentData": [
      {
        "path": "assets/document/part1/decentralization.md",
        "title": "Decentralization3"
      },
      {
        "path": "assets/document/part1/what_is_block_chain.md",
        "title": "What is block chain3"
      }
    ]
  }
];

var documents = documentDataList.map((e) => Lesson.fromJSON(e)).toList();
