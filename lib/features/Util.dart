import 'package:intl/intl.dart';

class DataPackage {
  String current = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<Map<String, dynamic>> initMasterData = [
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

  List<Map<String, dynamic>> initTaskData = [
    {
      'id': 1,
      'master': 7,
      'date': '2023-06-10',
      'weight': 40,
      'sets': 3,
      'rep': 10,
    },
    {
      'id': 2,
      'master': 9,
      'date': '2023-06-10',
      'weight': 50,
      'sets': 3,
      'rep': 10
    },
    {
      'id': 3,
      'master': 13,
      'date': '2023-06-10',
      'weight': 50,
      'sets': 3,
      'rep': 10
    }
  ];
}
