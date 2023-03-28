import 'package:flutter/material.dart';

class NewsCardShimmer extends StatelessWidget {

  const NewsCardShimmer(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children:[Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 115,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: 
                            List.generate(4, (index) => Container(
                              height: 10,
                              color: Colors.black,
                            )),
                      )),
                )),
              ]),]
            )));
  }
}
