import 'package:flutter/material.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';

class GenderDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({required this.onChanged, required this.value});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Gender must required';
        }
        return null;
      },
      isDense: true,
      style: text14,
      onChanged: onChanged,
      isExpanded: true,
      icon: Icon(
        Icons.expand_more,
        color: AppColor.blackFont,
      ),
      decoration: InputDecoration(
        hintStyle: textGray14,
        hintText: 'Gender',
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      items: [
        DropdownMenuItem(
          value: 'male',
          child: Text(
            'Male',
            style: text14,
          ),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text(
            'Female',
            style: text14,
          ),
        ),
        DropdownMenuItem(
          value: 'nothing',
          child: Text(
            'Prefer Not to Say',
            style: text14,
          ),
        ),
      ],
    );
  }
}
