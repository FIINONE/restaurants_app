import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/common/cubit/text_cubit.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.errorCubit,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextCubit errorCubit;
  final String hintText;
  final bool isPassword;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _visibleOff;

  @override
  void initState() {
    super.initState();

    _visibleOff = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextCubit, String?>(
      bloc: widget.errorCubit,
      builder: (context, errorText) {
        return TextField(
          controller: widget.controller,
          obscureText: _visibleOff,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _visibleOff = !_visibleOff;
                        });
                      },
                      splashRadius: 30,
                      icon: Icon(_visibleOff ? Icons.visibility : Icons.visibility_off),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }
    );
  }
}
