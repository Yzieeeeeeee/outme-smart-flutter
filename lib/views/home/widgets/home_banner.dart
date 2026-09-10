import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF812F),
            Color(0xFFF56D26),
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Now\ndelivering\ngroceries\nand more',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '🛍️',
                  style: TextStyle(fontSize: 65),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}