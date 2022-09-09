import 'package:flutter/material.dart';
import 'package:pare/utils/constant.dart';

// ignore: must_be_immutable
class ButtonTypeAnswer extends StatefulWidget {
  int? selectedIndex;
  List? objQuestions;
  bool? isSellerQuiz;
  ButtonTypeAnswer(
      {Key? key, this.selectedIndex, this.objQuestions, this.isSellerQuiz})
      : super(key: key);

  @override
  State<ButtonTypeAnswer> createState() => _ButtonTypeAnswerState();
}

class _ButtonTypeAnswerState extends State<ButtonTypeAnswer> {
  int? btnSelected;
   String? selecteText;
  @override
  Widget build(BuildContext context) {
    var q = widget.objQuestions![widget.selectedIndex!];
    var qo = q["options"];
    selecteText =  q["value"];
    return Column(
      children: List.generate(
          qo.length,
          (index) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomButton1(
                title: qo[index],
                backColor: qo[index] == selecteText ? Constants.greenColor : null,
                textColor: !widget.isSellerQuiz!
                    ? null
                    : qo[index] == selecteText
                        ? Colors.white
                        : Colors.black,
                onClickCallBack: () {
                  setState(() {
                    // btnSelected = index;
                    selecteText = qo[index];
                    q["value"] = selecteText;
                  });
                },
              ))),
    );
  }
}
