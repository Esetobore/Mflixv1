import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/utils/colours.dart';
import 'package:mflix/widgets/default-carousel.dart';
import 'package:mflix/widgets/main-carousel.dart';
import 'package:mflix/widgets/series-carousel.dart';
import '../controller/home-screen-controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => homeScreenController.isLoading.value
          ? const Center(
          child: SpinKitWave(
            color: Colours.palletRed,
            size: 50.0,
          ) )
          : const _BuildScreen()),
    );
  }

}

class _BuildScreen extends StatelessWidget {
  const _BuildScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Welcome!', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 17,
                            color: Colours.palletWhite
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Movie Magic Awaits', style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 13,
                            color: Colours.palletWhite
                        ),),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getTrendingMoviesDay(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return  MainCarousel(snapshot: snapshot,);
                  } else {
                    return const Center(child: SpinKitWave(
                      color: Colours.palletRed,
                      size: 50.0,
                    ));
                  }
                },
              ),
            ),

            //Trending Movies Carousel
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Movies', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletWhite
                ),),
                Text('See all', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletBlue
                ),),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getTrendingMoviesWeekly(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if (snapshot.hasData){
                    return CarouselWidget(snapshot: snapshot);
                  } else {
                    return const Center(child: SpinKitWave(
                      color: Colours.palletRed,
                      size: 50.0,
                    ),);
                  }

                }
              ),
            ),
            //Latest Moves Carousel
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Movies', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletWhite
                ),),
                Text('See all', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletBlue
                ),),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getUpcomingMovies(),
                builder: (context, snapshot){
                  if (snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }else if (snapshot.hasData){
                    return CarouselWidget(snapshot: snapshot);
                  } else{
                    return const Center(child: SpinKitWave(
                      color: Colours.palletRed,
                      size: 50.0,
                    ),);
                  }
                }
              ),
            ),
            //Latest Series Carousel
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Latest Series', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletWhite
                ),),
                Text('See all', style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colours.palletBlue
                ),),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                  future: HomeScreenController().getLatestTvSeries(),
                  builder: (context, snapshot){
                    if (snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }else if (snapshot.hasData){
                      return SeriesCarouselWidget(snapshot: snapshot);
                    } else{
                      return const Center(child: SpinKitWave(
                        color: Colours.palletRed,
                        size: 50.0,
                      ),);
                    }
                  }
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}