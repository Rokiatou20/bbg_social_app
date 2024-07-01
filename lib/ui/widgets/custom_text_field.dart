import 'package:flutter/material.dart';
import 'package:test_drive/configuration/colors.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final FocusNode? focusNode;
  final TextInputType inputType;
  final String placeholder;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;

  const CustomTextField({super.key,
    required this.textController,
    required this.placeholder,
    required this.prefixIcon,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.focusNode,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focusNode = FocusNode();
  bool _obscureText = false;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    super.initState();
    if(mounted){
      _focusNode.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.2.w,
          color: _focusNode.hasFocus ? AppColors.secondary : AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(1.h),
      ),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.inputType,
        obscureText: _obscureText,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          icon: Icon(
            widget.prefixIcon,
            color: _focusNode.hasFocus ? AppColors.primary : AppColors.secondary,
          ),
          suffixIcon: widget.obscureText ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child:  Icon(
              widget.suffixIcon,
              color: _focusNode.hasFocus ? AppColors.primary : AppColors.secondary,
            ),
          ) : null ,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
