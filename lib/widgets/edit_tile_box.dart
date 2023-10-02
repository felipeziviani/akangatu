import 'package:flutter/material.dart';

class EditTileBox extends StatelessWidget {
  final IconData icon;
  final String sectionName;
  final String text;
  final void Function()? tocFunction;

  const EditTileBox({
    super.key,
    required this.icon,
    required this.sectionName,
    required this.text,
    required this.tocFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(-1, -1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        icon,
                        color: Colors.deepPurple.shade800,
                      ),
                    ),
                    Text(
                      sectionName,
                      style: TextStyle(
                        color: Colors.deepPurple.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    tocFunction;
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 22,
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
