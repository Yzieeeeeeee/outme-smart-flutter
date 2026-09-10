import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText:
                  'Search by products or Shops',
                  prefixIcon: Icon(Icons.search_rounded),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
    );
  }
}