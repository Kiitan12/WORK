import 'package:flutter/material.dart';
import 'package:volun_tek/src/features/home/presentation/widget/refactored/filter_tag.dart';

/// A widget that displays a list of selectable filter tags.
class SelectableFilterTag extends StatefulWidget {
  final List<String> titles; // List of titles for each oval
  final Function(int) onSelectionChanged; // Callback for selection change

  const SelectableFilterTag({
    super.key,
    required this.titles,
    required this.onSelectionChanged,
  });

  @override
  State<SelectableFilterTag> createState() => _SelectableFilterTagState();
}

class _SelectableFilterTagState extends State<SelectableFilterTag> {
  List<bool> _selected = []; // List to track selection state

  @override
  void initState() {
    super.initState();
    _selected = List.generate(
        widget.titles.length, (index) => false); // Initialize selection states
  }

  void _handleSelection(int index) {
    setState(() {
      for (int i = 0; i < _selected.length; i++) {
        _selected[i] = (i == index);
      }
      widget.onSelectionChanged(index); // Call callback with selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        children: widget.titles.asMap().entries.map((entry) {
          final index = entry.key;
          final String title = entry.value;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterTag(
              title: title,
              isSelected: _selected[index],
              onTap: () => _handleSelection(index),
            ),
          );
        }).toList(),
      ),
    );
  }
}
