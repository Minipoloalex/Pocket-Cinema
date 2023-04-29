import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/view/common_widgets/poster_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/user_space/widgets/list_button.dart';
import 'package:pocket_cinema/view/common_widgets/comment_and_list_form.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';

class UserSpacePage extends StatefulWidget {
  const UserSpacePage({super.key});

  @override
  State<UserSpacePage> createState() => _MyUserSpacePageState();
}

class _MyUserSpacePageState extends State<UserSpacePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();
  bool _isFormVisible = false;
  void _handleSubmit(String listName) {
    if (listName.length < 2 || listName.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("List name must be between 2 and 20 characters long."))
      );
      return;
    }
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirestoreDatabase.createPersonalList(listName);
      toggleCreateListFormVisibility();
    }
    _controller.clear();
    _node.unfocus();
  }
  void toggleCreateListFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            key: const Key("logoutButton"),
            icon: const HeroIcon(
                HeroIcons.arrowLeftOnRectangle,
                style: HeroIconStyle.solid
            ),
            iconSize: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            onPressed: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Authentication.signOut();
              }
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const ToWatchList(),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListButton(
                  icon: const HeroIcon(HeroIcons.checkCircle,
                      style: HeroIconStyle.solid),
                  labelText: "Watched",
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                ListButton(
                  icon: const HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                      style: HeroIconStyle.solid),
                  labelText: "Watching",
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: Visibility(
              visible: _isFormVisible,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CommentAndListForm(
                    controller: _controller,
                    focusNode: _node,
                    handleSubmit: _handleSubmit,
                    maxLines: 1,
                    prefixIcon: IconButton(
                      color: Colors.white,
                      icon: const HeroIcon(HeroIcons.minus),
                      onPressed: () {
                        toggleCreateListFormVisibility();
                        _controller.clear();
                      },
                    ),
                    suffixIcon: IconButton(
                      color: Colors.white,
                      icon: const HeroIcon(HeroIcons.plus),
                      onPressed: () {
                        _handleSubmit(_controller.text);
                      },
                    ),
                    hintText: "Create a new list",
                  )
              ),
            ),
            )
          ],
      ),
      floatingActionButton: Visibility (
          visible: !_isFormVisible,
          child: AddButton(
            onPressed: () {
              toggleCreateListFormVisibility();
            }
    )
    ),
    );
  }
}

class ToWatchList extends ConsumerWidget {
  const ToWatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Media>> toWatchList = ref.watch(toWatchListProvider);

    return toWatchList.when(
      data: (data) => HorizontalMediaList(
        name: "In your pocket to Watch",
        media: data,
      ),
      // a list of 10 PosterShimmer widgets
      loading: () => Shimmer.fromColors(
              period: const Duration(milliseconds: 1000),
              baseColor: Theme.of(context).highlightColor,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child:  SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: 7,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PosterShimmer(),
                ),
              ))
              ),
      error: (error, stack) => Text(error.toString()),
    );
  }
}
