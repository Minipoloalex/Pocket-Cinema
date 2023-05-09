import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/controller/validate.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/comment_and_list_form.dart';
import 'package:pocket_cinema/view/common_widgets/personal_lists.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';
import 'package:pocket_cinema/view/user_space/widgets/list_button.dart';
import 'package:pocket_cinema/view/user_space/widgets/to_watch_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserSpacePage extends ConsumerStatefulWidget {
  const UserSpacePage({super.key});

  @override
  MyUserSpacePageState createState() => MyUserSpacePageState();
}

class MyUserSpacePageState extends ConsumerState<UserSpacePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();
  bool _isFormVisible = false;
  
  @override
  void initState() {
    super.initState();
    ref.refresh(watchedListProvider).value;
    ref.refresh(toWatchListProvider).value;
    ref.refresh(listsProvider).value;
  }
  void _handleSubmit(String listName) {
    if (!Validate.listName(listName)) {
      Fluttertoast.showToast(msg: "List name must be between 2 and 20 characters long");
      return;
    }
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirestoreDatabase.createPersonalList(listName);
      Fluttertoast.showToast(msg: "Created a new list named '$listName'");
      toggleCreateListFormVisibility();
    }
    _controller.clear();
    _node.unfocus();
    ref.refresh(watchedListProvider).value;
  }

  void toggleCreateListFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchedList = ref.watch(watchedListProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            key: const Key("logoutButton"),
            icon: const HeroIcon(HeroIcons.arrowLeftOnRectangle,
                style: HeroIconStyle.solid),
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
      body: 
        RefreshIndicator(
      onRefresh: () async {
        ref.refresh(listsProvider).value;
        ref.refresh(toWatchListProvider).value;
      },
      child:
      ListView(
        children: <Widget>[
          const ToWatchList(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              watchedList.when(
                  data: (data) => ListButton(
                      icon: const HeroIcon(HeroIcons.checkCircle,
                          style: HeroIconStyle.solid),
                      labelText: "Watched",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MediaListPage(name: "Watched", mediaList: data),
                        ));
                      }),
                  loading: () => ListButton(
                        icon: const HeroIcon(HeroIcons.checkCircle,
                            style: HeroIconStyle.solid),
                        labelText: "Watched",
                        onPressed: () {},
                      ),
                  error: (error, stackTrace) {
                    Logger().e(error);
                    return const SizedBox();
                  }),
                  /*
              const SizedBox(width: 20),
              ListButton(
                icon: const HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                    style: HeroIconStyle.solid),
                labelText: "Watching",
                onPressed: () {},
              ),*/
            ],
          ),
          const PersonalList(),

          SizedBox(
            height: 100,
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
                    icon: const HeroIcon(HeroIcons.xMark),
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
                  hintText: "New list name",
                ),
              ),
            ),
          ),
      ],
      )),
      floatingActionButton: Visibility(
        visible: !_isFormVisible,
        child: AddButton(
          onPressed: () => {
            toggleCreateListFormVisibility(),
            _node.requestFocus(),
          },
          tooltip: "Create a new list",
        )
      ),
    );
  }
}
