import 'package:flutter/material.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation({Key? key}) : super(key: key);

  @override
  _MusicAnimationState createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation> with SingleTickerProviderStateMixin{
  Animation<double>? animation;
  AnimationController? animationController; 
  
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController!, curve: Curves.easeInOutCubic);
    animation = Tween<double>(begin: 0,end: 100).animate(curvedAnimation)..addListener((){
      setState(() {
        
      });
    });
    animationController!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

class MusicVisualizer extends StatelessWidget {
  MusicVisualizer({ Key? key }) : super(key: key);
  final List<Color> colors = [Colors.blueAccent, Colors.brown, Colors.red, Colors.green, Colors.yellow];
  final List<int> duration = [900, 700, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(15, (index) => MusicVisualComp(duration: duration[index % 5], color: colors[index % 5])),
    );
  }
}

class MusicVisualComp extends StatefulWidget {
  const MusicVisualComp({Key? key, this.duration, this.color}) : super(key: key);

  final int? duration;
  final Color? color;

  @override
  _MusicVisualCompState createState() => _MusicVisualCompState();
}

class _MusicVisualCompState extends State<MusicVisualComp> with SingleTickerProviderStateMixin{

  Animation<double>? animation;
  AnimationController? animationController;
  
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: widget.duration ?? 1000), vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController!, curve: Curves.easeInOutSine);
    animation = Tween<double>(begin: 0,end: 100).animate(curvedAnimation)..addListener((){
      setState(() {
        
      });
    });
    animationController!.repeat(reverse: true);
  }

  @override
  dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5)
      ),
      height: animation?.value,
    );
  }
}