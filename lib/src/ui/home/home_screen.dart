import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/popular/popular_bloc.dart';
import 'package:movie_app/src/model/movie_popular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    popularBloc.getMoviePopular();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
         SizedBox(
           height:
           200,
           child: StreamBuilder<PopularModel>(
             stream: popularBloc.getPopular,
             builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data!.popularResults;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (ctx,index){
                      return  Container(
                        margin: EdgeInsets.only(right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network("https://image.tmdb.org/t/p/w500/${data[index].knownFor[0].backdropPath}"),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
             }
           ),
         ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: Text("Pouplar Movies",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 30)),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 0.77,
                  child: StreamBuilder<PopularModel>(
                    stream: popularBloc.getPopular,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return PageView.builder(
                            itemCount: snapshot.data!.popularResults.length,
                            physics: const ClampingScrollPhysics(),
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              return carouselView(index,snapshot.data);
                            });
                      }return Container();
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget carouselView(int index,PopularResult popularModel) {
    return AnimatedBuilder(
      animation: _pageController!,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController!.position.haveDimensions) {
          value = index.toDouble() - (_pageController!.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          print("value $value index $index");
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(popularModel[index]),
        );
      },
    );
  }

  Widget carouselCard(PopularModel data) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: data.popularResults[0].knownFor[0].backdropPath!,
              child: GestureDetector(
                onTap: () {
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black26)
                      ]),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            data.popularResults[0].name,
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$}",
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
class DataModel {
  final String title;
  final String imageName;
  final double price;
  DataModel(
      this.title,
      this.imageName,
      this.price,
      );
}

List<DataModel> dataList = [
  DataModel("Short Dress", "assets/images/fashion2.jpeg", 300.8),
  DataModel("Office Formals", "assets/images/fashion1.jpeg", 245.2),
  DataModel("Casual Jeans", "assets/images/fashion4.png", 168.2),
  DataModel("Jeans Skirt", "assets/images/fashion3.jpg", 136.7),
];
