import 'package:flutter/material.dart';
import 'package:pare/utils/constant.dart';

// ignore: must_be_immutable
class RadioTypeAnswer extends StatefulWidget {
  int? selectedIndex;

  RadioTypeAnswer({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<RadioTypeAnswer> createState() => _RadioTypeAnswerState();
}

class _RadioTypeAnswerState extends State<RadioTypeAnswer> {
  @override
  Widget build(BuildContext context) {
    var q = questions[widget.selectedIndex!];
    var qo = q["options"];
    String value = q["value"];
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return RadioListTile(
          value: qo[index].toString().toUpperCase(),
          contentPadding: EdgeInsets.zero,
          activeColor: Constants.greenColor,
          groupValue: value,
          onChanged: (ind) {
            print(ind);
            setState(() {
              value = qo[index].toString().toUpperCase();
              q["value"] = value;
            });
          },
          title: Text(
            qo[index].toString().toUpperCase(),
            style:
                TextStyle(color: Colors.white, fontSize: Constants.ansFontSize),
          ),
        );
      },
      itemCount: qo.length,
    ));
  }
}
