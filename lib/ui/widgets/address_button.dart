import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool isSelected;

  const AddressButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple.shade700 : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.deepPurple.shade700 : Colors.grey.shade300,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.deepPurple,
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 9,
                      color: isSelected ? Colors.white70 : Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}