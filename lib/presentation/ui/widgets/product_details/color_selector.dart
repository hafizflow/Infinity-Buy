import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.colors,
    required this.onChange,
  });

  final List<Color> colors;
  final Function(Color) onChange;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.colors
          .map(
            (c) => InkWell(
              onTap: () {
                selectedColor = c;
                widget.onChange(c);
                if (mounted) {
                  setState(() {});
                }
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: c,
                  radius: 14,
                  child: selectedColor == c
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
