import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBarLogo extends StatelessWidget {
  const TopBarLogo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        SvgPicture.asset(
          "assets/logo/logo.svg",
          color: Theme.of(context).primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("Pocket Cinema",
            textScaleFactor: 3,
          ),
        ),
      ]);
  }
}