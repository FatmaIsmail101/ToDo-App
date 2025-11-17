import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/size_config/size_config.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.onChange,
    this.onTap,
    this.isObsecure = false,
    this.validator,
    this.controller,
    this.keyboardType
  });

  final Function(String)? onChange;
  final bool isEnabled;
  final String text;
  final VoidCallback? onTap;
  final bool isObsecure;
final String? Function (String?)?validator;
final TextInputType? keyboardType;
final TextEditingController ?controller;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _obsecure;

  @override
  void initState() {
    super.initState();
    _obsecure = widget.isObsecure;
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType:widget.keyboardType ,
      controller:widget.controller ,
      validator:widget.validator ,
      style: GoogleFonts.lato(
        color: Colors.white,
        fontSize: SizeConfig.widthRatio(18),
        fontWeight: FontWeight.w500,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixIcon: widget.isObsecure
            ? IconButton(
          icon: Icon(size: SizeConfig.widthRatio(15),
                  _obsecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _obsecure = !_obsecure;
                  });
                },
              )
            : null,
        hintText: widget.text,
        hintStyle: GoogleFonts.lato(
          color: Colors.white,
          fontSize: SizeConfig.widthRatio(16),
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Color(0xff1D1D1D),
        enabledBorder: widget.isEnabled
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
                borderSide: BorderSide(color: Color(0xff979797)),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          borderSide: BorderSide(color: Color(0xff979797)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onChanged: widget.onChange,
      onTap: widget.onTap,
      obscureText: _obsecure,
      obscuringCharacter: '•',
    );
  }
}
