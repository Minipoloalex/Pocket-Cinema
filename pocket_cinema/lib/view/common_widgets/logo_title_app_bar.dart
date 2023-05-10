import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoTitleAppBar extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const LogoTitleAppBar(
      {super.key, this.mainAxisAlignment = MainAxisAlignment.center});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            SvgPicture.asset(
              "assets/logo/logo.svg",
              width: 45,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: const Text('Pocket Cinema'),
            )
          ],
        ));
  }
}
