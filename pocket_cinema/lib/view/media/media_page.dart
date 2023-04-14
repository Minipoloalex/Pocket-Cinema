import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';

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

class MediaPage extends ConsumerWidget {
  final String id;
  const MediaPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaInfo = ref.watch(mediaProvider(id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const GoBackButton(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 310,
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                mediaInfo.when(
                  data: (data) => Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(data.backgroundImage),
                  ),
                  error: (error, stack) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
                Positioned(
                  top: 60,
                  left: 40,
                  child: mediaInfo.when(
                    data: (data) => Container(
                      width: 108,
                      height: 188,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(data.posterImage),
                        ),
                      ),
                    ),
                    error: (error, stack) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
                Positioned(
                  top: 172,
                  left: 160,
                  child: mediaInfo.when(
                    data: (data) => Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    error: (error, stack) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
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
                        mediaInfo.when(
                            data: (data) => Text(
                                data.rating,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            error: (error, stack) => Text(error.toString()),
                            loading: () => const CircularProgressIndicator(),
                        ),
                        const SizedBox(width: 6),
                        mediaInfo.when(
                            data: (data) => Text(
                              data.nRatings,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            error: (error, stack) => Text(error.toString()),
                            loading: () => const CircularProgressIndicator(),
                        ),
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
                    child: mediaInfo.when(
                      data: (data) => Text(
                        data.description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      error: (error, stack) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: NoCommentsButton()
          ),
        ],
      ),
    );
  }
}
