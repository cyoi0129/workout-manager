import 'package:intl/intl.dart';

class DataPackage {
  List<String> dateList = [
    '2023-06-25',
    '2023-06-26',
    '2023-06-27',
    '2023-06-28',
    '2023-06-29',
    '2023-06-30',
    '2023-07-01'
  ];

  List<Map<String, dynamic>> initWorkoutMasterData = [
    {'id': 1, 'type': '自重', 'part': '胸筋', 'name': '腕立て伏せ'},
    {'id': 2, 'type': '自重', 'part': '胸筋', 'name': 'ディップス'},
    {'id': 3, 'type': '自重', 'part': '腹筋', 'name': 'クランチ'},
    {'id': 4, 'type': '自重', 'part': '腹筋', 'name': 'レッグレイズ'},
    {'id': 5, 'type': '自重', 'part': '背筋', 'name': '懸垂'},
    {'id': 6, 'type': '自重', 'part': '脚', 'name': 'スクワット'},
    {'id': 7, 'type': 'フリーウェイト', 'part': '胸筋', 'name': 'ベンチプレス'},
    {'id': 8, 'type': 'フリーウェイト', 'part': '胸筋', 'name': 'ダンベルフライ'},
    {'id': 9, 'type': 'フリーウェイト', 'part': '背筋', 'name': 'デッドリフト'},
    {'id': 10, 'type': 'フリーウェイト', 'part': '背筋', 'name': 'ダンベルローイング'},
    {'id': 11, 'type': 'フリーウェイト', 'part': '腕', 'name': 'アームカール'},
    {'id': 12, 'type': 'フリーウェイト', 'part': '脚', 'name': 'ブルガリアスクワット'},
    {'id': 13, 'type': 'フリーウェイト', 'part': '脚', 'name': 'バーベルスクワット'},
    {'id': 14, 'type': 'フリーウェイト', 'part': '肩', 'name': 'サイドレイズ'},
    {'id': 15, 'type': 'マシン', 'part': '胸筋', 'name': 'チェストプレス'},
    {'id': 16, 'type': 'マシン', 'part': '胸筋', 'name': 'ケーブルクロスオーバー'},
    {'id': 17, 'type': 'マシン', 'part': '背筋', 'name': 'ラットプルダウン'},
    {'id': 18, 'type': 'マシン', 'part': '肩', 'name': 'ショルダープレス'},
    {'id': 19, 'type': 'マシン', 'part': '脚', 'name': 'レッグエクステンション'},
    {'id': 20, 'type': 'マシン', 'part': '脚', 'name': 'レッグプレス'}
  ];

  List<Map<String, dynamic>> initWorkoutTaskData = [
    {
      'id': 1,
      'master': 7,
      'date': '2023-06-28',
      'weight': 40,
      'sets': 3,
      'rep': 10,
    },
    {
      'id': 2,
      'master': 9,
      'date': '2023-06-28',
      'weight': 50,
      'sets': 3,
      'rep': 10
    },
    {
      'id': 3,
      'master': 13,
      'date': '2023-06-29',
      'weight': 50,
      'sets': 3,
      'rep': 10
    }
  ];
  List<Map<String, dynamic>> initAccountData = [
    {
      'id': 1,
      'gender': '男',
      'age': 25,
      'height': 170,
      'weight': 60,
    }
  ];
  List<Map<String, dynamic>> initFoodMasterData = [
    {
      'id': 1,
      'name': 'ご飯(150g)',
      'type': '穀類',
      'protein': 4,
      'sugar': 56,
      'fat': 1,
      'calorie': 249
    },
    {
      'id': 2,
      'name': '鶏ささみ(100g)',
      'type': '肉',
      'protein': 23,
      'sugar': 0,
      'fat': 1,
      'calorie': 101
    },
    {
      'id': 3,
      'name': 'ブロッコリー(100g)',
      'type': '野菜',
      'protein': 5,
      'sugar': 1,
      'fat': 1,
      'calorie': 33
    },
  ];
  List<Map<String, dynamic>> initFoodTaskData = [
    {'id': 1, 'master': 1, 'date': '2023-06-25', 'volume': 100},
    {'id': 2, 'master': 2, 'date': '2023-06-25', 'volume': 200},
    {'id': 3, 'master': 3, 'date': '2023-06-26', 'volume': 300},
    {'id': 4, 'master': 1, 'date': '2023-06-26', 'volume': 100},
    {'id': 5, 'master': 2, 'date': '2023-06-27', 'volume': 200},
    {'id': 6, 'master': 3, 'date': '2023-06-27', 'volume': 300},
    {'id': 7, 'master': 1, 'date': '2023-06-28', 'volume': 100},
    {'id': 8, 'master': 2, 'date': '2023-06-28', 'volume': 200},
    {'id': 9, 'master': 3, 'date': '2023-06-29', 'volume': 300},
    {'id': 10, 'master': 1, 'date': '2023-06-29', 'volume': 100},
    {'id': 11, 'master': 2, 'date': '2023-06-30', 'volume': 200},
    {'id': 12, 'master': 3, 'date': '2023-06-30', 'volume': 300},
    {'id': 13, 'master': 1, 'date': '2023-07-01', 'volume': 100},
    {'id': 14, 'master': 2, 'date': '2023-07-01', 'volume': 200},
    {'id': 15, 'master': 3, 'date': '2023-07-01', 'volume': 300},
  ];

  List<Map<String, dynamic>> initWeightData = [
    {'id': 1, 'date': '2023-06-25', 'weight': 80, 'calorie': 2000},
    {'id': 2, 'date': '2023-06-26', 'weight': 79, 'calorie': 1900},
    {'id': 3, 'date': '2023-06-27', 'weight': 80, 'calorie': 2000},
    {'id': 4, 'date': '2023-06-28', 'weight': 79, 'calorie': 1900},
    {'id': 5, 'date': '2023-06-29', 'weight': 80, 'calorie': 2000},
    {'id': 6, 'date': '2023-06-30', 'weight': 79, 'calorie': 1900},
    {'id': 7, 'date': '2023-07-01', 'weight': 80, 'calorie': 2000},
  ];
}
