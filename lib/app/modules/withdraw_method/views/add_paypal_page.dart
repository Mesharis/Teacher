// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/controllers/withdraw_method_controller.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

import '../../../utils/helpers/validation.dart';

class AddPaypalPage extends GetView<WithdrawMethodController> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Paypal'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SafeArea(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                GetBuilder<WithdrawMethodController>(
                  builder: (controller) {
                    return TextFormField(
                      controller: name,
                      validator: (String? value) {
                        if (value!.length < 2) {
                          return 'nameLength'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name'.tr,
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black87),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Styles.secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                      ),
                      cursorColor: Styles.primaryColor,
                      onEditingComplete: () => node.nextFocus(),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                GetBuilder<WithdrawMethodController>(
                  builder: (controller) {
                    return TextFormField(
                      controller: email,
                      validator: ((value) {
                        return Validation().validateEmail(value);
                      }),
                      decoration: InputDecoration(
                        hintText: 'Paypal Email Address'.tr,
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black87),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Styles.secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Styles.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                      ),
                      cursorColor: Styles.primaryColor,
                      onEditingComplete: () => node.nextFocus(),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                submitButton(
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        controller.addPaypal(name.text, email.text);
                        print('validation success');
                      } else {
                        print("validation failed");
                      }
                    },
                    text: 'Save'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
