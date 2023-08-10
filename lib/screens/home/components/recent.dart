import 'package:flutter/material.dart';

class Recent extends StatelessWidget {
  const Recent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Plastic Chair',
            style: TextStyle(
                fontSize: 15, color: Colors.grey.shade600),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                      color: Colors.grey.shade400, width: 2)),
              child: Icon(
                Icons.close_outlined,
                color: Colors.grey.shade600,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
