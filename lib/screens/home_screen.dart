import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '/widgets/button.dart';
import '/widgets/ddm.dart';
import 'gku/ruangan_screen.dart';

final List<String> imgList = [
  'https://i.ibb.co/qsSrkqy/14052609-611006929102219-627606034613010432-n.jpg',
  'https://i.ibb.co/qsSrkqy/14052609-611006929102219-627606034613010432-n.jpg',
  'https://i.ibb.co/qsSrkqy/14052609-611006929102219-627606034613010432-n.jpg',
  'https://i.ibb.co/qsSrkqy/14052609-611006929102219-627606034613010432-n.jpg',
  'https://i.ibb.co/qsSrkqy/14052609-611006929102219-627606034613010432-n.jpg'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DDM(
      title: 'Home',
      child: Column(children: [
        Expanded(
          // flex: 3,
          child: Stack(alignment: Alignment.center, children: [
            CarouselSlider(
              items: imgList
                  .map((item) => Center(
                        child: Stack(
                          children: [
                            Image.network(item,
                                height: size.height,
                                fit: BoxFit.cover,
                                width: size.width),
                            Container(
                                height: size.height,
                                width: size.width,
                                color: Colors.black.withOpacity(0.3)),
                          ],
                        ),
                      ))
                  .toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  height: size.height,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Positioned(
                right: size.width / 10,
                left: size.width / 10,
                child: const Column(
                  children: [
                    Text(
                      'Welcome To',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Peminjaman',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Kelas GKU',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Positioned(
                top: size.height / 1.35,
                bottom: size.height / 30,
                left: size.width / 5,
                right: size.width / 5,
                child: Button(
                  actionOnButton: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RuanganScreen()));
                  },
                  buttonText: 'Mulai',
                )),
            Positioned(
              top: size.height / 1.175,
              left: size.width / 5,
              right: size.width / 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInCubic,
                      width: _current == entry.key ? 17.0 : 10,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          //shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.white)
                              .withOpacity(_current == entry.key ? 1.0 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ]),
        ),
        // Expanded(
        //     flex: 7,
        //     child: GestureDetector(
        //       child: Container(
        //         height: 100,
        //         width: 100,
        //         decoration: const BoxDecoration(
        //             shape: BoxShape.circle, color: Colors.grey),
        //         child: GestureDetector(
        //           child: !isClicked
        //               ? GestureDetector(
        //                   onTap: () {
        //                     isClicked = !isClicked;
        //                     setState(() {});
        //                   },
        //                   child: const Icon(
        //                     Icons.home,
        //                     size: 35,
        //                   ),
        //                 )
        //               : Center(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       IconButton(
        //                         icon: const Icon(Icons.add),
        //                         onPressed: () {
        //                           //setState(() {});
        //                         },
        //                       ),
        //                       const Icon(Icons.manage_accounts)
        //                     ],
        //                   ),
        //                 ),
        //         ),
        //       ),
        //     ))
      ]),
    );
  }
}
