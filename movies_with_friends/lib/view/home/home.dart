import 'package:flutter/material.dart';
import 'package:movies_with_friends/view/home/widgets/news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: const [
            NewsCard(
                img: "assets/images/idrisElba.png",
                date: "Fri, 10 Mar 2023 15:04",
                description:
                    "Idris Elba reveals if he’d be interested in playing a brand new character in James Gunn’s DCU",
                content:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Volutpat blandit aliquam etiam erat velit scelerisque. Proin fermentum leo vel orci porta non pulvinar neque. Nunc aliquet bibendum enim facilisis gravida. In tellus integer feugiat scelerisque varius morbi enim. Dui ut ornare lectus sit amet. Eget sit amet tellus cras adipiscing enim eu turpis egestas. Bibendum at varius vel pharetra vel turpis nunc. Interdum posuere lorem ipsum dolor sit amet consectetur. Sed sed risus pretium quam vulputate dignissim suspendisse in. Mi proin sed libero enim sed faucibus turpis in eu. Scelerisque in dictum non consectetur. Faucibus interdum posuere lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Bibendum arcu vitae elementum curabitur vitae nunc sed velit. Lacus vestibulum sed arcu non odio.Purus semper eget duis at tellus at urna condimentum mattis. In arcu cursus euismod quis viverra nibh cras pulvinar mattis. Urna et pharetra pharetra massa massa. Ac orci phasellus egestas tellus rutrum tellus pellentesque. Justo eget magna fermentum iaculis eu non. Odio euismod lacinia at quis risus sed. Quam nulla porttitor massa id neque. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Blandit aliquam etiam erat velit. Vitae suscipit tellus mauris a. Turpis tincidunt id aliquet risus feugiat in. Cursus metus aliquam eleifend mi in. Laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean. Maecenas sed enim ut sem viverra aliquet. Porta lorem mollis aliquam ut porttitor leo a diam sollicitudin. In hac habitasse platea dictumst. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. In arcu cursus euismod quis viverra."),
            NewsCard(
              img: "assets/images/turtle.png",
              date: "Fri, 10 Mar 2023 15:00",
              description:
                  "EENAGE MUTANT NINJA TURTLE: MUTANT MAYHEM Artist Talks About Its Cool Spider-Verse Style...",
              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Volutpat blandit aliquam etiam erat velit scelerisque. Proin fermentum leo vel orci porta non pulvinar neque. Nunc aliquet bibendum enim facilisis gravida. In tellus integer feugiat scelerisque varius morbi enim. Dui ut ornare lectus sit amet. Eget sit amet tellus cras adipiscing enim eu turpis egestas. Bibendum at varius vel pharetra vel turpis nunc. Interdum posuere lorem ipsum dolor sit amet consectetur. Sed sed risus pretium quam vulputate dignissim suspendisse in. Mi proin sed libero enim sed faucibus turpis in eu. Scelerisque in dictum non consectetur. Faucibus interdum posuere lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Bibendum arcu vitae elementum curabitur vitae nunc sed velit. Lacus vestibulum sed arcu non odio.Purus semper eget duis at tellus at urna condimentum mattis. In arcu cursus euismod quis viverra nibh cras pulvinar mattis. Urna et pharetra pharetra massa massa. Ac orci phasellus egestas tellus rutrum tellus pellentesque. Justo eget magna fermentum iaculis eu non. Odio euismod lacinia at quis risus sed. Quam nulla porttitor massa id neque. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Blandit aliquam etiam erat velit. Vitae suscipit tellus mauris a. Turpis tincidunt id aliquet risus feugiat in. Cursus metus aliquam eleifend mi in. Laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean. Maecenas sed enim ut sem viverra aliquet. Porta lorem mollis aliquam ut porttitor leo a diam sollicitudin. In hac habitasse platea dictumst. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. In arcu cursus euismod quis viverra.",
            ),
            NewsCard(
              img: "assets/images/jennaOrtega.png",
              date: "Fri, 10 Mar 2023 14:48",
              description: "Wednesday's Jenna Ortega May Star in Beetlejuice 2",
              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Volutpat blandit aliquam etiam erat velit scelerisque. Proin fermentum leo vel orci porta non pulvinar neque. Nunc aliquet bibendum enim facilisis gravida. In tellus integer feugiat scelerisque varius morbi enim. Dui ut ornare lectus sit amet. Eget sit amet tellus cras adipiscing enim eu turpis egestas. Bibendum at varius vel pharetra vel turpis nunc. Interdum posuere lorem ipsum dolor sit amet consectetur. Sed sed risus pretium quam vulputate dignissim suspendisse in. Mi proin sed libero enim sed faucibus turpis in eu. Scelerisque in dictum non consectetur. Faucibus interdum posuere lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Bibendum arcu vitae elementum curabitur vitae nunc sed velit. Lacus vestibulum sed arcu non odio.Purus semper eget duis at tellus at urna condimentum mattis. In arcu cursus euismod quis viverra nibh cras pulvinar mattis. Urna et pharetra pharetra massa massa. Ac orci phasellus egestas tellus rutrum tellus pellentesque. Justo eget magna fermentum iaculis eu non. Odio euismod lacinia at quis risus sed. Quam nulla porttitor massa id neque. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Blandit aliquam etiam erat velit. Vitae suscipit tellus mauris a. Turpis tincidunt id aliquet risus feugiat in. Cursus metus aliquam eleifend mi in. Laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean. Maecenas sed enim ut sem viverra aliquet. Porta lorem mollis aliquam ut porttitor leo a diam sollicitudin. In hac habitasse platea dictumst. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. In arcu cursus euismod quis viverra.",
            ),
            NewsCard(
              img: "assets/images/dungeonsDragons.png",
              date: "Fri, 10 Mar 2023 14:09",
              description:
                  "Dungeons & Dragons: Honor Among Thieves' Directors on Helming The Role Playing Game",
              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Volutpat blandit aliquam etiam erat velit scelerisque. Proin fermentum leo vel orci porta non pulvinar neque. Nunc aliquet bibendum enim facilisis gravida. In tellus integer feugiat scelerisque varius morbi enim. Dui ut ornare lectus sit amet. Eget sit amet tellus cras adipiscing enim eu turpis egestas. Bibendum at varius vel pharetra vel turpis nunc. Interdum posuere lorem ipsum dolor sit amet consectetur. Sed sed risus pretium quam vulputate dignissim suspendisse in. Mi proin sed libero enim sed faucibus turpis in eu. Scelerisque in dictum non consectetur. Faucibus interdum posuere lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Bibendum arcu vitae elementum curabitur vitae nunc sed velit. Lacus vestibulum sed arcu non odio.Purus semper eget duis at tellus at urna condimentum mattis. In arcu cursus euismod quis viverra nibh cras pulvinar mattis. Urna et pharetra pharetra massa massa. Ac orci phasellus egestas tellus rutrum tellus pellentesque. Justo eget magna fermentum iaculis eu non. Odio euismod lacinia at quis risus sed. Quam nulla porttitor massa id neque. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Blandit aliquam etiam erat velit. Vitae suscipit tellus mauris a. Turpis tincidunt id aliquet risus feugiat in. Cursus metus aliquam eleifend mi in. Laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean. Maecenas sed enim ut sem viverra aliquet. Porta lorem mollis aliquam ut porttitor leo a diam sollicitudin. In hac habitasse platea dictumst. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. In arcu cursus euismod quis viverra.",
            ),
          ],
        ),
      ),
    );
  }
}