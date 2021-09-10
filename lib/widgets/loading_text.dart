import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({Key? key}) : super(key: key);

  @override
  _LoadingTextState createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {

  var _loadingText = "Loading";

  var _totalLoop = 0;

  @override
  void initState() {
    super.initState();
    _startLoadingLoop();
  }

  void _startLoadingLoop() async{
    while(this.mounted){
      print(_totalLoop == 3);
      if(_totalLoop == 4) {
        _loadingText = "Loading";
        _totalLoop = 0;
      }
      await Future.delayed(const Duration(seconds: 1));
      _loadingText += " .";
      _totalLoop++;
      if(this.mounted){
        setState(() {

        });
      }
      print(_loadingText);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      _loadingText,
      style: TextStyle(
        color: ThemeColors.primaryOne,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }


}
