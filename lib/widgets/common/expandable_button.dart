import 'package:basic_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandableButton extends StatefulWidget {

  final VoidCallback onBtn1;
  final VoidCallback onBtn2;
  final VoidCallback onBtn3;

  const ExpandableButton({
    Key? key,
    required this.onBtn1,
    required this.onBtn2,
    required this.onBtn3,
  }) : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableButton> {
  bool _isExpanded = false;

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {

    final markerAddMode = context.watch<AppState>().markerAddMode;
    
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _isExpanded
          ? Row(
              key: ValueKey(1),
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption(markerAddMode ? Icons.add_location : Icons.add_location_alt, widget.onBtn1),
                _buildOption(Icons.route_outlined, widget.onBtn2),
                _buildOption(Icons.menu, widget.onBtn3),
                FloatingActionButton(
                  backgroundColor: Colors.grey,
                  onPressed: _toggle,
                  child: Icon(Icons.close),
                ),
              ],
            )
          : FloatingActionButton(
              key: ValueKey(2),
              onPressed: _toggle,
              backgroundColor: Colors.purple,
              child: Icon(Icons.add),
            ),
    );
  }

  Widget _buildOption(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FloatingActionButton(
        mini: true,
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
