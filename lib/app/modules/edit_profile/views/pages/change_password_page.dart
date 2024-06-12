import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../controllers/edit_profile_controller.dart';
import '../../../login/views/widgets/submit_button.dart';
import '../../../../styles/styles.dart';

class ChangePasswordPage extends GetView<EditProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();

  ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Change Password'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: GetBuilder<EditProfileController>(
                builder: (controller) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: FormBuilderTextField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "passwordValidation".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Curren Password'.tr,
                              labelStyle: TextStyle(
                                  fontSize: 15, color: Colors.black87),
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
                            name: 'currentPassword',
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: () => node.nextFocus(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: FormBuilderTextField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "passwordValidation".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'New Password'.tr,
                              labelStyle: TextStyle(
                                  fontSize: 15, color: Colors.black87),
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
                            name: 'newPassword',
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (value) =>
                                controller.newPassword.value = value.toString(),
                            onSubmitted: (value) =>
                                controller.newPassword.value = value!,
                            onEditingComplete: () => node.nextFocus(),
                          ),
                        ),
                        GetBuilder<EditProfileController>(
                            builder: (controller) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: FormBuilderTextField(
                                // Handles Form Validation for First Name
                                validator: (value) {
                                  if (controller.newPassword.value != value &&
                                      value != null) {
                                    return "passwordDon'tMatch".tr;
                                  } else if (value == null || value.isEmpty) {
                                    return "passwordValidation".tr;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm New Password'.tr,
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black87),
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
                                name: 'confirmNewPassword',
                                keyboardType: TextInputType.visiblePassword,
                                onEditingComplete: () {
                                  _formKey.currentState!.save();
                                  _formKey.currentState!.validate();
                                  node.nextFocus();
                                },
                              ));
                        }),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: submitButton(
                              onTap: () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  // controller.updateEmail(
                                  //     _formKey.currentState!.value['email']);
                                  controller.changePassword(
                                      _formKey.currentState!
                                          .value['currentPassword'],
                                      _formKey.currentState!
                                          .value['confirmNewPassword']);
                                } else {
                                  print("validation failed");
                                }
                              },
                              text: 'Save'.tr),
                        )
                      ],
                    )),
          ),
        ));
  }
}
