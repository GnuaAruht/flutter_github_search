import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) onTextChanged;
  final String initText;
  const SearchWidget(
      {Key? key, required this.onTextChanged, this.initText = ''})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  bool clearEnabled = false;
  String _previousText = '';

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initText;
    _controller.addListener(_onTextChange);
  }

  void _onTextChange() {
    final text = _controller.text;
    if (_previousText != text) {
      widget.onTextChanged(text);
      _previousText = text;
    }
    clearEnabled = text.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      autofocus: true,
      textInputAction: TextInputAction.search,
      style: TextStyle(fontSize: 20.0),
      textAlign: TextAlign.start,
      controller: _controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: 'Search github repos',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: clearEnabled
              ? GestureDetector(
                  onTap: () {
                    _controller.text = '';
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              : SizedBox.shrink()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
