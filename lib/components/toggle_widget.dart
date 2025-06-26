import 'package:flutter/material.dart';
class DrinkToggle extends StatelessWidget {
  final bool isIced;
  final ValueChanged<bool> onChanged;

  const DrinkToggle({
    Key? key,
    required this.isIced,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          _buildToggleOption("Hot", !isIced, false),
          _buildToggleOption("Iced", isIced, true),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String label, bool selected, bool icedValue) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(icedValue),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeIn,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Color(0xFF1E3932) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white :Color(0xFF1E3932)  ,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton("-", () {
            if (quantity > 1) onChanged(quantity - 1);
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "$quantity",
              style: TextStyle(fontSize: 18),
            ),
          ),
          _buildButton("+", () {
            onChanged(quantity + 1);
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      ),
    );
  }
}
