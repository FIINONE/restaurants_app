import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
  }) : super(key: key);

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
    return TextField(
      obscureText: _visibleOff,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
}
