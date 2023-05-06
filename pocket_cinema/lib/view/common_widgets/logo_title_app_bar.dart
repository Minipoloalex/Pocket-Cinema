import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoTitleAppBar extends StatelessWidget {
  const LogoTitleAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/logo/logo.svg",
            width: 50,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 8),
        const Text('Pocket Cinema'),
      ],
    );
  }
}
