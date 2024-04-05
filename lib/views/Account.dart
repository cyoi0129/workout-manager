import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../components/Footer.dart';
import '../features/AccountData.dart';

class AccountView extends HookWidget {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final AccountData _accountData = context.watch<AccountData>();
    final AccountEditModel _currentData = context.watch<AccountEditModel>();
    AccountModel _currentAccountData = _accountData.getAccountData();
    final snackBar = SnackBar(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      margin: const EdgeInsetsDirectional.all(16),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.teal,
            ),
            Text(
              '保存しました',
              style: TextStyle(color: Colors.teal),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 4.0,
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      dismissDirection: DismissDirection.horizontal,
    );

    void _updateAccountData() {
      _currentData.setAccountEditModel(_currentAccountData);
    }

    useEffect(() {
      _updateAccountData();
    }, [_currentAccountData]);

    final formatter = NumberFormat("#,###");
    void _doUpdate() {
      print(_currentData.getEditingAccount().gender);
      _accountData.updateAccount(_currentData.getEditingAccount());
    }

    void _showSnack() {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: SizedBox(
            width: 32,
            height: 31.5,
            child:
                Image.asset('assets/images/header.png', fit: BoxFit.contain)),
        title: const Text('まっちょノート'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/account', (route) => false);
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Text('ユーザー情報',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0))),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('性別'),
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        margin: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                        child: ListTile(
                          title: const Text('男'),
                          leading: Radio(
                            value: '男',
                            groupValue: _currentData.getEditingAccount().gender,
                            onChanged: (value) {
                              _currentData.changeGender(value);
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                        child: ListTile(
                          title: const Text('女'),
                          leading: Radio(
                            value: '女',
                            groupValue: _currentData.getEditingAccount().gender,
                            onChanged: (value) {
                              _currentData.changeGender(value);
                            },
                          ),
                        ),
                      )
                    ],
                  ))
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('年齢（歳）'),
                  SizedBox(
                      width: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _currentData.ageEditingController,
                        onChanged: (value) =>
                            _currentData.changeAge(int.parse(value)),
                      ))
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('身長（cm）'),
                  SizedBox(
                      width: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _currentData.heightEditingController,
                        onChanged: (value) =>
                            _currentData.changeHeight(int.parse(value)),
                      ))
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('体重（kg）'),
                  SizedBox(
                      width: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _currentData.weightEditingController,
                        onChanged: (value) =>
                            _currentData.changeWeight(int.parse(value)),
                      ))
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '基礎代謝: ${formatter.format(_currentData.getBaseData().calorie)}'),
                  Text('タンパク質: ${_currentData.getBaseData().protein}'),
                  Text('糖質: ${_currentData.getBaseData().sugar}'),
                  Text('脂質: ${_currentData.getBaseData().fat}'),
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    _doUpdate();
                    Timer(const Duration(seconds: 1), () => _showSnack());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 16),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(120, 40),
                    alignment: Alignment.center,
                  ),
                  child: const Text("保存")),
            ]))
      ])),
      bottomNavigationBar: const Footer(current: 4),
    );
  }
}
