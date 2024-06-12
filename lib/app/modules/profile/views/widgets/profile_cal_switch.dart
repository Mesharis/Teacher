// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

class ProfileCallSwitch extends StatefulWidget {
  /// Icon data
  ProfileCallSwitch(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.onChanged,
      this.isAvailableForCall = false,
      this.description,
      this.hideArrowIcon = false});

  /// Icon data
  final IconData icon;

  /// Button text string
  final String text;

  /// Button description string
  final String? description;

  /// Hide arrow icon
  final bool hideArrowIcon;

  /// Hide arrow icon
  bool isAvailableForCall;

  final VoidCallback onTap;
  final void Function(bool)? onChanged;

  @override
  State<ProfileCallSwitch> createState() => _ProfileCallSwitchState();
}

class _ProfileCallSwitchState extends State<ProfileCallSwitch> {
  bool? available;
  @override
  void initState() {
    available = widget.isAvailableForCall;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
          onTap: widget.onTap,
          title: Text(
            widget.text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: widget.description != null
              ? Text(
                  widget.description ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400),
                )
              : Text(
                  "",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
          leading: Icon(
            widget.icon,
            size: 30,
            color: Styles.secondaryColor,
          ),
          trailing: Switch.adaptive(
            activeColor: Colors.green.shade300,
            inactiveTrackColor: Colors.orange.shade100,
            value: widget.isAvailableForCall,
            onChanged: widget.onChanged,
          )),
    );
  }
}
