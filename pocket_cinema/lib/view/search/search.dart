import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  MySearchPageState createState() => MySearchPageState();
}

class MySearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    final inTheatersMedia = ref.watch(inTheaters);

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              autofocus: false,
              onTap: () => Navigator.pushNamed(context, '/search_results'),
              onSubmitted: (query) {},
              onChanged: (value) => {
                if(value.length > 2){
                  ref.read(searchQueryProvider.notifier).state = value
                }
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.magnifyingGlass),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(children: [
                    inTheatersMedia.when(
                        data: (data) => HorizontalMediaList(
                            name: 'In Theaters',
                            media: data),
                        loading: () => const Center(
                            child: CircularProgressIndicator()),
                        error: (error, stack) => const Center(
                            child: Text('Error loading data'))),
                    
                  ],)
              )
          )
        ],
      ),
    ));
  }
}
