import 'package:flutter/material.dart';
import 'package:pare/utils/constant.dart';

// ignore: must_be_immutable
class RoundButtonTypeAnswer extends StatefulWidget {
  int? selectedIndex;
  RoundButtonTypeAnswer({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<RoundButtonTypeAnswer> createState() => _RoundButtonTypeAnswerState();
}

class _RoundButtonTypeAnswerState extends State<RoundButtonTypeAnswer> {
  int? btnSelected;
  String? selecteText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnSelected = null;
  }

  @override
  Widget build(BuildContext context) {
    double w = 60;
    var q = questions[widget.selectedIndex!];
    var qo = q["options"];
    selecteText = q["value"];
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: List.generate(qo.length, (index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        btnSelected = index;
                        selecteText = qo[index];
                        q["value"] = selecteText;
                        print(qo[index]);
                        print(selecteText);
                        print(selecteText == qo[index]);
                      });
                    },
                    child: Container(
                        width: w,
                        height: w,
                        // padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selecteText == qo[index]
                                ? Constants.greenColor
                                : null,
                            border: Border.all(
                              width: 2,
                              color: Constants.greenColor,
                              style: BorderStyle.solid,
                            )),

                        // borderRadius: BorderRadius.all(Radius.circular(w / 2))),
                        child: Center(
                            child: Text(
                          qo[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Constants.ansFontSize),
                        ))));
                ;
              }),
            )));
  }
}
