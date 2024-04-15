import 'package:flutter/foundation.dart';
import '/screens/detail_ruangan.dart';
import 'gku_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/model/gku_list_data.dart';

class GkuListView extends StatelessWidget {
  const GkuListView(
      {super.key,
      this.gkuData,
      this.animationController,
      this.animation,
      this.callback});

  final VoidCallback? callback;
  final GkuListData? gkuData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRuangan(gkuData: gkuData)));},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                gkuData!.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: GkuAppTheme.buildLightTheme()
                                  .colorScheme
                                  .background,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            gkuData!.titleTxt,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                gkuData!.subTxt,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.locationDot,
                                                size: 12,
                                                color: GkuAppTheme
                                                        .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                              // Expanded(
                                              //   child: Text(
                                              //     'lantai ${gkuData!.dist.toStringAsFixed(1)}',
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     style: const TextStyle(
                                              //         fontSize: 14,
                                              //         color: Colors.black),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                RatingBar(
                                                  initialRating:
                                                      gkuData!.rating,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 24,
                                                  ratingWidget: RatingWidget(
                                                    full: Icon(
                                                      Icons.star_rate_rounded,
                                                      color: GkuAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    half: Icon(
                                                      Icons.star_half_rounded,
                                                      color: GkuAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    empty: Icon(
                                                      Icons.star_border_rounded,
                                                      color: GkuAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  itemPadding: EdgeInsets.zero,
                                                  onRatingUpdate: (rating) {
                                                    if (kDebugMode) {
                                                      print(rating);
                                                    }
                                                  },
                                                ),
                                                Text(
                                                  ' ${gkuData!.reviews} Reviews',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${gkuData!.kapasitas}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const Text(
                                          'mahasiswa',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: GkuAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
