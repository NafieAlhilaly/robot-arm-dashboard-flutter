import 'package:flutter/material.dart';

class StyledButton extends StatefulWidget {
  final String text;
  final String? arabicText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isRTL;
  final bool isLoading;

  const StyledButton({
    Key? key,
    required this.text,
    this.arabicText,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.isRTL = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _StyledButtonState createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledButton> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: widget.padding,
          elevation: 2,
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: widget.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.arabicText != null) ...[
                    Text(
                      widget.arabicText!,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
