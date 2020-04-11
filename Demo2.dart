import 'package:flutter/material.dart';


class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {

  var colors = [Colors.orange, Colors.lightGreen, Colors.red, Colors.purple, Colors.blue, Colors.pink];
  double currentPage = 0;
  List<Widget> get containers {
    List<Widget> containers = List();
  this.colors.forEach((i){
    containers.add(Container());
  });
  return containers;
  }
  @override
  Widget build(BuildContext context) {

    PageController controller = PageController();

    controller.addListener((){
      setState(() {
        currentPage = controller.page;
      });
    });
    
    return Scaffold(
      body: Container(
        margin:EdgeInsets.only(top:200),
        height: 400,
        width: double.infinity,
        child: Stack(children:<Widget>[
          CardsStacked(currentPage,colors),
          PageView(children: this.containers,controller: controller,)

        ])
      ),
      
    );
  }
}

class CardsStacked extends StatelessWidget{
  final double currentPage;
  final List<Color> colors;
  final padding = 20.0;
  final verticalInset = 20.0;

  const CardsStacked( this.currentPage, this.colors);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context,constraints){
          List<Widget> cards = List();
          var primaryCardHeight = constraints.maxHeight * 0.9;
        var primaryCardWidth = primaryCardHeight * 0.7;

        for (int i = colors.length -1 ; i>=0;i--){
          var temp = i - currentPage;
          var isOnRight = temp >= 0;


          var item = Positioned.directional(textDirection: TextDirection.ltr,top: 20,
          
           
             start: temp * (primaryCardWidth / 6)  + 40 - (isOnRight? 0 : (400 * -temp)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20 - temp * 2.2)),
                color: colors[i]
              ),  
              height: primaryCardHeight - (primaryCardHeight * temp * 0.1),
              width: primaryCardWidth - (primaryCardWidth * temp * 0.1),        
           ),
          );
          cards.add(item);
        }
          return Stack(children: cards,);
        }
      ),
    );
  }

}
