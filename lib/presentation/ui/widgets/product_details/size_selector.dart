import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.onChange,
  });

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes.last;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.sizes
          .map(
            (c) => InkWell(
              onTap: () {
                selectedSize = c;
                widget.onChange(c);
                if (mounted) {
                  setState(() {});
                  // log(selectedColor.toString());
                }
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                  color: selectedSize == c ? AppColors.primaryColor : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Text(
                  c,
                  style: TextStyle(
                    color: selectedSize == c ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
