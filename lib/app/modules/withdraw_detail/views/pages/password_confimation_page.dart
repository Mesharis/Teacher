import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/withdraw_detail_controller.dart';
import '../../../../styles/styles.dart';

class PasswordConfirmationPage extends GetView<WithdrawDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confim Password',
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.blue[400],
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                onChanged: (value) => controller.pass.value = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.requestWithdraw();
                  },
                  child: Text('Verify Password'))
            ],
          ),
        )));
  }
}
