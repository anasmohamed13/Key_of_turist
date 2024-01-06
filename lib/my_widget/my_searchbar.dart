import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) onSubmitted;
  final Function(String) onChanged;

  const MySearchBar({
    required this.hintText,
    required this.onSubmitted,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onChanged() {
    widget.onChanged(_textController.text);
  }

  void _onSubmitted() {
    widget.onSubmitted(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: TextField(
        controller: _textController,
        onChanged: (text) {
          _onChanged();
        },
        onSubmitted: (text) {
          _onSubmitted();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12), isDense: true,
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
