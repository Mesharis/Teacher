import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../login/views/widgets/divider.dart';
import '../../login/views/widgets/submit_button.dart';
import '../../login/views/widgets/title_widget.dart';
import '../../../utils/helpers/validation.dart';

import '../../../styles/styles.dart';
import '../controllers/register_controller.dart';
import 'widgets/login_account_label.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    titleApp(),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        node.nextFocus();
                      },
                      validator: ((value) {
                        if (value!.length < 3) {
                          return 'Name must be more than two characters'.tr;
                        } else {
                          return null;
                        }
                      }),
                      onSaved: (username) {
                        controller.username = username!;
                      },
                      decoration: InputDecoration(
                          hintText: 'Username'.tr,
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
                          fillColor: Colors.grey[100],
                          filled: true),
                      cursorColor: Styles.primaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        node.nextFocus();
                      },
                      validator: ((value) {
                        return Validation().validateEmail(value);
                      }),
                      onSaved: (email) {
                        controller.email = email!;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email'.tr,
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
                          fillColor: Colors.grey[100],
                          filled: true),
                      cursorColor: Styles.primaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<RegisterController>(
                      builder: (controller) => TextFormField(
                        obscureText: controller.passwordVisible,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (value!.length < 3) {
                            return 'Password must be more than four characters'
                                .tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (password) {
                          controller.password = password!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password'.tr,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                                controller.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Styles.primaryColor),
                            onPressed: () {
                              controller.passwordIconVisibility();
                            },
                          ),
                        ),
                        cursorColor: Styles.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    submitButton(
                        onTap: () {
                          controller.signUpUser();
                        },
                        text: 'Register Now'.tr),
                    SizedBox(height: height * .02),
                    divider(),
                    //_googleSignInButton(controller.loginController),
                    loginAccountLabel(onTap: () {
                      Get.offAllNamed('/login');
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
