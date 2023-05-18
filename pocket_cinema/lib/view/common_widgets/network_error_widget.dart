import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class NetworkErrorOccurred extends StatelessWidget {
  const NetworkErrorOccurred({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            HeroIcon(HeroIcons.wifi),
            SizedBox(height: 8),
            Text("Network error, check your network status.",
                style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
