import 'package:flutter/material.dart';

import '../common_widgets/add_button.dart';
import '../common_widgets/check_button.dart';

class MediaPage extends StatelessWidget {
  final String backgroundImage;
  final String cardImage;
  final String title;
  final String rating;
  final String nRatings;
  final String description;
  const MediaPage(
      {super.key,
      required this.backgroundImage,
      required this.cardImage,
      required this.title,
      required this.rating,
      required this.nRatings,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 310,
              color: Theme.of(context).cardColor,
              child: Stack(
                children: [
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage(backgroundImage),
                    ),
                  Positioned(
                    top: 60,
                    left: 40,
                    child: Container(
                      width: 108,
                      height: 188,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(cardImage),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 172,
                    left: 160,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 212,
                      left: 160,
                      child: Row(
                        children: [
                          const Image(
                            height: 16,
                            width: 16,
                            image: AssetImage('assets/images/star.png'),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(nRatings),
                          const SizedBox(width: 20),
                          const CheckButton(),
                          const AddButton(),
                        ],
                      )),
                  Positioned(
                    top: 262,
                    left: 40,
                    child: SizedBox(
                      width: 350,
                      height: 40,
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

