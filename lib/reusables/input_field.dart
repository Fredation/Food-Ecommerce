import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  String? Function(String?)? validator;
  String? errorText;
  bool isEnabled;
  bool isPassword;
  bool hidePass;
  InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.errorText,
    this.isEnabled = true,
    this.isPassword = false,
    this.hidePass = false,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      _focusNode.unfocus();
      _isFocused = true;
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false && widget.controller.text.isEmpty) {
        _isFocused = false;
      } else {
        _isFocused = true;
      }
      setState(() {});
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 100));
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isFocused = true;
              _focusNode.requestFocus();
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 60,
                padding: _isFocused
                    ? const EdgeInsets.only(top: 10, left: 16, right: 16)
                    : const EdgeInsets.only(top: 22, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: widget.isEnabled
                      ? const Color.fromRGBO(250, 250, 250, 1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isFocused
                        ? widget.errorText == null
                            ? _focusNode.hasFocus
                                ? const Color.fromRGBO(0, 0, 0, 1)
                                : const Color.fromRGBO(0, 0, 0, 0.05)
                            : Colors.red
                        : const Color.fromRGBO(0, 0, 0, 0.05),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hintText,
                            style: TextStyle(
                              fontSize: _isFocused ? 12 : 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          _isFocused
                              ? SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    obscureText: widget.hidePass,
                                    focusNode: _focusNode,
                                    autofocus: true,
                                    cursorColor:
                                        const Color.fromRGBO(0, 0, 0, 1),
                                    cursorWidth: 0.5,
                                    cursorHeight: 18,
                                    decoration: const InputDecoration(
                                      //errorText: (value.i),
                                      errorStyle: TextStyle(
                                          height: 0,
                                          fontSize: 0,
                                          color: Colors.transparent),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                    ),
                                    enabled: widget.isEnabled,
                                    controller: widget.controller,
                                    validator: widget.validator,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    widget.isPassword
                        ? GestureDetector(
                            onTap: () {
                              widget.hidePass = !widget.hidePass;
                              setState(() {});
                            },
                            child: Icon(
                              widget.hidePass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ))
                        : const SizedBox(),
                  ],
                ),
              ),
              widget.errorText == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        widget.errorText.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
