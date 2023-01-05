
import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/plugin/asr_manager.dart';
import 'package:flutter_trip/util/navigator_util.dart';

class SpeakPage extends StatefulWidget {

  const SpeakPage({Key? key}) : super(key: key);

  @override
  _SpeakPageState createState() => _SpeakPageState();

}

class _SpeakPageState extends State<SpeakPage> with SingleTickerProviderStateMixin{

   String speakTips = "长按说话";
   String speakResult = "";
   late Animation<double> animation;
   late AnimationController controller;

   @override
  void initState() {
     controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
     ..addStatusListener((status) {
       if(status == AnimationStatus.completed){
         controller.reverse();
       } else if(status == AnimationStatus.dismissed){
         controller.forward();
       }
     });
    super.initState();
  }
  @override
  void dispose() {
     controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topItem(),
              _bottomItem(),
            ],
          ),
        ),
      ),
    );
  }
   _topItem(){
     return Column(
       children: [
         const Padding(
           padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
           child: Text("你可以这样说", style: TextStyle(fontSize: 16,color: Colors.black54)),
         ),
         const Text(
           "故宫门票\n背景一日游\n迪士尼乐园",
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 15,color: Colors.grey),
         ),
         Padding(
          padding: const EdgeInsets.all(20),
          child: Text(speakResult,style: const TextStyle(color: Colors.blue)),
         ),
       ],
     );
   }
  _bottomItem(){
    // 撑满屏幕宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (e){
              _speakStart();
            },
            onTapUp: (e){
              _speakStop();
            },
            onTapCancel: (){
              _speakStop();
            },
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(speakTips, style: const TextStyle(color: Colors.blue, fontSize: 12),),
                  ),
                  Stack(
                    children: [
                      const SizedBox(
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                      ),
                      Center(
                        child: AnimatedMic(
                          animation: animation,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
              bottom: 20,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close, size: 30, color: Colors.grey),
              )
          )
        ],
      ),
    );
  }

  _speakStart(){
    controller.forward();
    setState((){
      speakTips = "--识别中--";
    });
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //    Navigator.pop(context);
    //    NavigatorUtil.push(context, const SearchPage(keyword: "上海",));
    // });
    // 百度语音配额问题
    AsrManager.start().then((result){
      print("result:" + result);
      if(result.isNotEmpty){
        setState((){
          speakResult = result;
        });
        Navigator.pop(context);
        NavigatorUtil.push(context, SearchPage(keyword: speakResult,));
      }
    }).catchError((e){
      print("@@##识别出错：" + e);
    });
  }
  _speakStop(){
    controller.reset();
    controller.stop();
    setState((){
      speakTips = "长按说话";
    });
  }

}


const double MIC_SIZE = 80;
class AnimatedMic extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  const AnimatedMic({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable  as Animation<double>;
    return Opacity(
        opacity: _opacityTween.evaluate(animation),
            child: Container(
              height: _sizeTween.evaluate(animation),
              width: _sizeTween.evaluate(animation),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(MIC_SIZE / 2)
              ),
              child: const Icon(Icons.mic, color: Colors.white,size: 30,),
            )

    );
  }

}