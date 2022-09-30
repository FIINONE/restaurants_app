import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(String) onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String oldValue = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (oldValue != value) {
          oldValue = value;
          widget.onChanged.call(value);
        }
      },
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 42),
        hintText: 'Поиск',
        hintStyle: AppTextStyles.regular.copyWith(fontSize: 13, color: AppColors.grey_1),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: SvgPicture.asset(
          Assets.svgSearch,
          color: AppColors.grey_1,
          fit: BoxFit.scaleDown,
        ),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey_3, width: 1)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey_1, width: 1)),
      ),
    );
  }
}
