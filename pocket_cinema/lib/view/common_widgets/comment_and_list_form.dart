import 'package:flutter/material.dart';

class CommentAndListForm extends StatelessWidget {
  const CommentAndListForm(
      {super.key,
      required this.focusNode,
      required this.controller,
      required this.handleSubmit,
      required this.onTapOutside,
      this.suffixIcon,
      this.prefixIcon,
      this.maxLines = 1,
      this.hintText,
      this.paddingLeft = 0});
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String) handleSubmit;
  final void Function(PointerDownEvent) onTapOutside;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final int maxLines;
  final String? hintText;
  final double paddingLeft;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
      child: TextField(
        minLines: 1,
        maxLines: maxLines,
        focusNode: focusNode,
        controller: controller,
        onSubmitted: handleSubmit,
        onTapOutside: onTapOutside,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.fromLTRB(paddingLeft, 5, 0, 5),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
