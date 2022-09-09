import 'package:flutter/material.dart';
import 'package:pare/pages/questions.dart';
import 'package:pare/utils/model.dart';
import 'package:pare/pages/tabbar.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../services/api_service.dart';
import '../utils/constant.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({Key? key}) : super(key: key);

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  List<bool> isLike = [];
  bool like = false;
  bool nope = false;
  List<bool> isNope = [];
  int selectedIndex = 0;

  List<ImgData>? imgData = [];
  bool isLoadingData = true;

  final List<SwipeItem> _swipeItems = [];
  MatchEngine? _matchEngine;

  getDataFrmServer() {
    print("getIntroFromServer");
    setState(() {
      // isDataLoading = true;
    });

    callAPI(context, ApiConstant.images + "buyer", ApiConstant.getMethod, {},
            false)
        .then((response) {
      print(response);
      setState(() {});

      if (response != null) {
        ImagesData imgsResponse = ImagesData.fromJson(response);
        if (imgsResponse.status == 1) {
          setState(() {
            imgData = imgsResponse.data;
          });
          setImages();
        } else {
          showSnackBar(
              context, response["message"], "", SnackBarType.Error, () {});
          List errors = response["errors"];
          if (errors.isNotEmpty) {
            // showFlusBar(context, "Errors!", errors[0]["133"]);
          }
        }
      }
      setState(() {
        isLoadingData = false;
      });
    });
  }

  setImages() {
    isLike = List.filled((imgData?.length) ?? 0, false);
    isNope = List.filled((imgData?.length) ?? 0, false);
    if (imgData?.isNotEmpty ?? false) {
      for (int i = 0; i < imgData!.length; i++) {
        _swipeItems.add(SwipeItem(
            content: Content(
                text: imgData![i].title!,
                subText: imgData![i].title!,
                images: imgData![i].image!),
            likeAction: () {
              sendDataToServer(imgData![i].id!.toString());
              // scaffoldKey.currentState?.showSnackBar(SnackBar(
              //   content: Text("Liked ${imgData![i].title!}"),
              //   duration: const Duration(milliseconds: 500),
              // ));
            },
            nopeAction: () {
              // scaffoldKey.currentState?.showSnackBar(SnackBar(
              //   content: Text("Nope ${imgData![i].title!}"),
              //   duration: const Duration(milliseconds: 500),
              // ));
            },
            superlikeAction: () {
              sendDataToServer(imgData![i].id!.toString());
            },
            onSlideUpdate: (SlideRegion? region) async {
              print("Region $region");
              if (region == SlideRegion.inLikeRegion) {
                setState(() {
                  isLike[i] = true;
                  isNope[i] = false;
                  like = true;
                  nope = false;
                });
              } else if (region == SlideRegion.inNopeRegion) {
                setState(() {
                  isNope[i] = true;
                  isLike[i] = false;
                  like = false;
                  nope = true;
                });
              } else {
                setState(() {
                  isLike[i] = false;
                  isNope[i] = false;
                  like = false;
                  nope = false;
                });
              }
            }));
      }

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    }
  }

  @override
  void initState() {
    getDataFrmServer();
  }

  sendDataToServer(String id) {
    print("getIntroFromServer");
    Map<String, String> p = {"image_id": id};
    setState(() {
      // isDataLoading = true;
    });

    callAPI(context, ApiConstant.imageLike, ApiConstant.postMethod, p, true)
        .then((response) {
      print(response);
      setState(() {});

      if (response != null) {
        if (response["status"] == 1) {
          for (var i = 0; i < questions.length; i++) {
            questions[i]["value"] = "";
          }

          showSnackBar(
              context, response["message"], "", SnackBarType.Sueecss, () {});
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ThankYouPage(
          //             isSellerQuiz: false,
          //           )),
          // );
        } else {
          showSnackBar(
              context, response["message"], "", SnackBarType.Error, () {});
          List errors = response["errors"];
          if (errors.isNotEmpty) {
            // showFlusBar(context, "Errors!", errors[0]["133"]);
          }
        }
      }
    }).onError((error, stackTrace) {
      print("ERRRR");
      print(error);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingData
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : imgData?.isNotEmpty ?? false
            ? Column(
                children: [
                  Expanded(
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const QuestionsPage()),
                              // );
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: const EdgeInsets.only(
                                    top: 30, left: 10, right: 10, bottom: 20),
                                child: cardImage(
                                    imgData![index].title!,
                                    imgData![index].address!,
                                    imgData![index].image!,
                                    isLike[index],
                                    isNope[index])));
                      },
                      onStackFinished: () {},
                      itemChanged: (SwipeItem item, int index) {
                        print("item: ${item.content.text}, index: $index");
                      },
                      upSwipeAllowed: true,
                      fillSpace: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _matchEngine!.currentItem?.nope();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.close,
                                size: 50,
                                color: nope ? Colors.red : Colors.black)),
                      ),
                      like
                          ? const Icon(Icons.favorite,
                              size: 50, color: Colors.green)
                          : InkWell(
                              onTap: () {
                                _matchEngine!.currentItem?.like();
                              },
                              child: const Icon(Icons.favorite_border,
                                  size: 50, color: Colors.black),
                            ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              )
            : const Center(
                child: Text("No, any data available"),
              );

    // TinderSwapCard(swipeEdgeVertical: 50,
    //   swipeUp: true,
    //   swipeDown: true,
    //   orientation: AmassOrientation.top,allowVerticalMovement: false,
    //   totalNum: 5,
    //   stackNum: 3,
    //   swipeEdge: 4.0,
    //   maxWidth: MediaQuery.of(context).size.width * 1,
    //   maxHeight: MediaQuery.of(context).size.width * 5,
    //   minWidth: MediaQuery.of(context).size.width * 0.8,
    //   minHeight: MediaQuery.of(context).size.width * 0.9,
    //   cardBuilder: (context, i) {
    //     return InkWell(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => const QuestionsPage()),
    //           );
    //         },
    //         child: Card(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(30),
    //             ),
    //             margin: const EdgeInsets.only(
    //                 top: 30, left: 10, right: 10, bottom: 80),
    //             child: cardImage(
    //                 "Contempory",
    //                 "@iuxuryhomes_decor",
    //                 i == 0
    //                     ? Constants.imgCard1
    //                     : i == 1
    //                     ? Constants.bedroom1
    //                     : i == 2
    //                     ? Constants.bathroom1
    //                     : Constants.kitchen1)));
    //   },
    //
    //   //  Card(
    //   //   child: Image.asset('${welcomeImages[index]}'),
    //   // ),
    //   cardController: controller = CardController(),
    //   swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
    //     /// Get swiping card's alignment
    //     if (align.x < 0) {
    //       print('Card is LEFT swiping');
    //       //Card is LEFT swiping
    //     } else if (align.x > 0) {
    //       print('Card is RIGHT swiping');
    //       //Card is RIGHT swiping
    //     }else if(align.y<0){
    //       print('Card is up swiping');
    //       //Card is up swiping
    //     }
    //   },
    //   swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
    //     /// Get orientation & index of swiped card!
    //   },
    // )

    /* CarouselSlider(
      options: CarouselOptions(
          height: double.infinity, viewportFraction: 0.85, reverse: false),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionsPage()),
                  );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.only(
                        top: 30, left: 10, right: 10, bottom: 80),
                    child: Container(
                        width: MediaQuery.of(context).size.width,

                        // decoration: BoxDecoration(
                        //   color: Colors.amber
                        // ),
                        child: cardImage(
                            "Contempory",
                            "@iuxuryhomes_decor",
                            i == 0
                                ? Constants.imgCard1
                                : i == 1
                                    ? Constants.bedroom1
                                    : i == 2
                                        ? Constants.bathroom1
                                        : Constants.kitchen1))));
          },
        );
      }).toList(),
    ); */
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        buildChip('Living room', 0),
        buildChip('Bedroom', 1),
        buildChip('Bathroom', 2),
        buildChip('Kitchen', 3),
      ],
    );
  }

  Widget buildChip(String label, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Chip(
          labelPadding: const EdgeInsets.all(2.0),
          label: Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
              selectedIndex == index ? Constants.greenColor : Colors.white,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: const EdgeInsets.all(8.0),
        ));
  }

  Widget cardImage(
      String title, String subTitle, String imgName, bool isLike, bool isNope) {
    return
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        //   child:
        SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30), // Image border
                child: Image.network(
                  imgName,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width * 1.2,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              isLike
                  ? Positioned(
                      left: 10,
                      top: 20,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.green),
                          child: const Text('Like',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  : const SizedBox(),
              isNope
                  ? Positioned(
                      right: 10,
                      top: 20,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.red),
                          child: const Text('Nope',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
              child: Center(
                  child: Text(
                title.toUpperCase(),
                style: const TextStyle(fontSize: 20, letterSpacing: 1.5),
              ))),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: Center(
                  child: Text(
                subTitle,
                style: const TextStyle(fontSize: 12),
              ))),
        ],
        // ),
      ),
    );
  }
}

class Content {
  final String text;
  final String subText;
  final String images;

  Content({required this.text, required this.subText, required this.images});
}
