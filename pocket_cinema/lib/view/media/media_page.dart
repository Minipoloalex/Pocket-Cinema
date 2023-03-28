import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';

class NoCommentsButton extends StatefulWidget {
  const NoCommentsButton({super.key});

  @override
  NoCommentsButtonState createState() => NoCommentsButtonState();
}

class NoCommentsButtonState extends State<NoCommentsButton> {
  bool _showContent = true;

  @override
  Widget build(BuildContext context) {
    return _showContent
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("No comments yet..."),
              const SizedBox(height: 2),
              const Text("Begin the first discussion"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showContent = false;
                  });
                },
                child: const Text('Start discussion'),
              ),
            ],
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
              child: Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 1,
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class MediaPage extends StatelessWidget {
  final Media media;
  const MediaPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 310,
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: AssetImage(media.backgroundImage),
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
                        image: NetworkImage(media.posterImage),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 172,
                  left: 160,
                  child: Text(
                    media.name,
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
                          media.rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(media.nRatings),
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
                      media.description,
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
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: NoCommentsButton(),
            ),
          ),
        ],
      ),
    );
  }
}
