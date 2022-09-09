import 'package:flutter/material.dart';
import 'package:pare/utils/constant.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class CardImageTypeAnswer extends StatefulWidget {
  int? selectedIndex;
  CardImageTypeAnswer({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<CardImageTypeAnswer> createState() => _CardImageTypeAnswerState();
}

class _CardImageTypeAnswerState extends State<CardImageTypeAnswer> {
  @override
  Widget build(BuildContext context) {
    var q = questions[widget.selectedIndex!];
    var qo = q["options"];
    List qso = q["selected_index"];
    List qsv = q["selected_value"];

    var selectedIndex = [];
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2, crossAxisSpacing: 16),
      children: List.generate(
          qo.length,
          (index) => GestureDetector(
              onTap: () {
                setState(() {
                  if (qso.contains(index)) {
                    qso.removeAt(qso.indexOf(index));
                    // qsv.removeAt(qsv.indexOf(qo[index]["title"]));
                  } else {
                    qso.add(index);
                    // qsv.add(qo[index]["title"]);
                  }
                  q["value"] = qso.join(",");
                  // ontap of each card, set the defined int to the grid view index
                  // selectedCard = index;
                });
                print(qso);
                print(q["value"]);
              },
              child: Container(
                color:
                    qso.contains(index) ? Constants.greenColor : Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      // elevation: 3.0,
                      child: Image.network(
                        qo[index]["img"],
                        fit: BoxFit.fitWidth,
                        height: 130,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          qo[index]["title"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: qso.contains(index)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    )
        //      [
        //   Image.network('https://picsum.photos/250?image=1'),
        //   Image.network('https://picsum.photos/250?image=2'),
        //   Image.network('https://picsum.photos/250?image=3'),
        // ]

        // Row(
        //   children: [
        //     Expanded(
        //         child: cardImage(
        //             "Contempory", "@iuxuryhomes_decor", Constants.imgCard1)),
        //     Expanded(
        //         child: cardImage(
        //             "Mediterranen", "@bryantreiching", Constants.imgCard2))
        //   ],
        // ),
        // GridView.builder(
        //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //         maxCrossAxisExtent: 150,
        //         crossAxisSpacing: 10,
        //         childAspectRatio: 0.75,
        //         mainAxisSpacing: 20),
        //     itemCount: qo.length,
        //     itemBuilder: (BuildContext ctx, index) {
        //       var qq = qo[index];
        //       return Card(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(30),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             ClipRRect(
        //               borderRadius: BorderRadius.circular(30), // Image border
        //               child: SizedBox.fromSize(
        //                 // size: Size.fromRadius(48), // Image radius
        //                 child: Image.asset(
        //                   Constants.imgCard1,
        //                   height: 100,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //                 padding: const EdgeInsets.only(
        //                     top: 20, left: 5, right: 5, bottom: 10),
        //                 child: Center(
        //                     child: Text(
        //                   qq["title"].toUpperCase(),
        //                   style:
        //                       const TextStyle(fontSize: 20, letterSpacing: 1.5),
        //                 ))),
        //             Padding(
        //                 padding: const EdgeInsets.only(
        //                     left: 5, right: 5, bottom: 20),
        //                 child: Center(
        //                     child: Text(
        //                   qq["title"].toUpperCase(),
        //                   style: const TextStyle(fontSize: 12),
        //                 ))),
        //           ],
        //         ),
        //       );
        //       // Container(
        //       //   alignment: Alignment.center,
        //       //   child: Text(index.toString()),
        //       //   decoration: BoxDecoration(
        //       //       color: Colors.amber,
        //       //       borderRadius: BorderRadius.circular(15)),
        //       // );
        //     })
        );
  }

  Widget cardImage(String title, String subTitle, String imgName) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30), // Image border
          //   child: SizedBox.fromSize(
          //     // size: Size.fromRadius(48), // Image radius
          //     child:
          Image.asset(
            imgName,
            width: 100,
            fit: BoxFit.fill,
          ),
          //   ),
          // ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
              child: Center(
                  child: Text(
                title.toUpperCase(),
                style: const TextStyle(fontSize: 20, letterSpacing: 1.5),
              ))),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0),
              child: Center(
                  child: Text(
                subTitle,
                style: const TextStyle(fontSize: 12),
              ))),
        ],
      ),
    );
  }
}
