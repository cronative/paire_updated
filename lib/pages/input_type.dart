import 'package:flutter/material.dart';
import 'package:pare/utils/constant.dart';

// ignore: must_be_immutable
class InputTypeAnswer extends StatefulWidget {
  int? selectedIndex;
  final String? username;
  final String? useremail;

  InputTypeAnswer({Key? key, this.selectedIndex, this.useremail, this.username})
      : super(key: key);

  @override
  State<InputTypeAnswer> createState() => _InputTypeAnswerState();
}

class _InputTypeAnswerState extends State<InputTypeAnswer> {
  @override
  Widget build(BuildContext context) {
    var q = questions[widget.selectedIndex!];
    TextEditingController txtCtrl = TextEditingController();
    txtCtrl.text = q["value"] != ""
        ? q["value"]
        : widget.selectedIndex == 0
            ? widget.username
            : widget.selectedIndex == 2
                ? widget.useremail
                : "";
    // q["txtctrl"].text = q["value"];
    print(q);
    return CustomTextField(
      title: q["hint"],
      isPasswordField: false,
      textEditingController: txtCtrl,
      onChange: (v) {
        print(v);
        q["value"] = v;
        print(q);
      },
    );
  }
}
