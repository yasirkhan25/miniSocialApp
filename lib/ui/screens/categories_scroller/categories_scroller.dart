import 'package:flutter/material.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.26 - 35;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 135,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/babykids17.jpg",fit: BoxFit.cover,)),
              ),

              Container(
                width: 135,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/babykids14.jpg",fit: BoxFit.cover,)),
              ),

              Container(
                width: 135,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/babykids8.jpg",fit: BoxFit.cover,)),
              ),

              Container(
                width: 135,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/babykids13.jpg",fit: BoxFit.cover,)),
              ),

              Container(
                width: 135,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/babykids16.jpg",fit: BoxFit.cover,)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}