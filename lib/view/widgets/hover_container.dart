import 'package:bloatware_buster/view/widgets/container_shadow.dart';
import 'package:flutter/material.dart';

class HoverContainer extends StatefulWidget {
  final Widget child;
  final bool isFocused;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color color;
  final Color? hoverColor;
  final bool shadowOnHover;
  final BorderRadius? borderRadius;
  final BorderRadius? hoverBorderRadius;
  const HoverContainer(
      {super.key,
      required this.child,
      this.padding,
      this.margin,
      this.color = Colors.white,
      this.hoverColor,
      this.shadowOnHover = true,
      this.borderRadius,
      this.hoverBorderRadius,
      this.isFocused = false});

  @override
  State<HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    isHover = (widget.isFocused || isHover);
    if (widget.shadowOnHover == false) {
      isHover = !isHover;
    }
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHover = true;
      }),
      onExit: (_) => setState(() {
        isHover = false;
      }),
      child: AnimatedContainer(
          padding: widget.padding,
          margin: widget.margin,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHover ? widget.hoverColor ?? widget.color : widget.color,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            boxShadow: isHover ? [containerShadow] : null,
          ),
          child: widget.child),
    );
  }
}
