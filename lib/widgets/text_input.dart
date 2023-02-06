import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/app_styles.dart';

class TextInput extends StatefulWidget {
  final Size size;
  final String hint;
  final Widget? prefixIcon;
  final String? prefixIconAsset;
  final Widget? suffixIcon;
  final String? suffixIconAsset;
  final bool isVisible;
  final Function? onSuffixTap;
  final Function? validator;
  final String? Function(String?)? validate;
  final TextEditingController controller;
  final Function? onSubmitted;
  final bool autofocus;
  final Function? onChanged;

  const TextInput(
      {Key? key,
      required this.size,
      required this.hint,
      this.prefixIcon,
      this.prefixIconAsset,
      this.suffixIcon,
      this.suffixIconAsset,
      required this.isVisible,
      this.onSuffixTap,
      this.validator,
      this.validate,
      this.onSubmitted,
      this.autofocus = false,
      required this.controller,
      this.onChanged})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * 0.9,
      child: Focus(
        onFocusChange: (bool value) {
          setState(() {
            isFocused = value;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          onFieldSubmitted: (value) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted!();
            }
          },
          obscureText: !widget.isVisible,
          validator: widget.validate,
          style: AppStyles.inputText,
          textInputAction: TextInputAction.search,
          autofocus: widget.autofocus,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          // GoogleFonts.poppins(
          //   color: AppColors.textColor,
          //   fontSize: 14,
          //   fontWeight: FontWeight.w500,
          // ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
            prefixIcon: widget.prefixIconAsset != null
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(widget.prefixIconAsset!,
                        height: 10,
                        width: 10,
                        fit: BoxFit.contain,
                        color: isFocused
                            ? AppColors.primaryColor
                            : Colors.grey[500]))
                : null,
            suffixIcon: widget.suffixIconAsset != null
                ? InkWell(
                    onTap: () {
                      if (widget.onSuffixTap != null) {
                        widget.onSuffixTap!();
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(widget.suffixIconAsset!,
                            height: 10,
                            width: 10,
                            fit: BoxFit.contain,
                            color: isFocused
                                ? AppColors.primaryColor
                                : Colors.grey[500])),
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            // focusColor: Color(0xFFEBFAF1),
            fillColor:
                isFocused ? const Color(0xFFEBFAF1) : const Color(0xFFFAFAFA),
            filled: true,
            focusColor: Colors.red,
            // hoverColor: Color(0xFFFAFAFA),
          ),
        ),
      ),
    );
  }
}
