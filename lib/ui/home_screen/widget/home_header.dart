import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String username;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeHeader({
    super.key,
    required this.username,
    required this.isDarkMode,
    required this.onToggleTheme, required Null Function() onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF017CFD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// ✅ Welcome + Username
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome ✨",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  username,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),

            /// ✅ زر الوضع الليلي
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: onToggleTheme,
            ),
          ],
        ),
      ),
    );
  }
}