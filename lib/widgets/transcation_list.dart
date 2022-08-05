import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import 'dismissible_widget.dart';
class TranscationList extends StatelessWidget {

  TranscationList(this.transcatiions,this.deletetx);
  final List<Activity> transcatiions;
  final Function deletetx;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx,index){
            return DismissibleWidget(
              item: transcatiions[index],
              //onDismissed: (){},

              onDismissed: (direction)=>{
                deletetx(transcatiions[index].id)
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(

                                padding:EdgeInsets.only(left: 10,right: 10),
                                child: Image.asset("assets/money.png"),
                              ),
                              Container(
                                child: Text(transcatiions[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20
                                  ),),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                            ,
                            children: [

                              Text("₹${transcatiions[index].price}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20

                                ),),
                              Text(DateFormat.MMMEd().format(transcatiions[index].date)),


                            ],
                          )
                        ],
                      ),
                    )
                ),
              ),
            );
        },
          itemCount: transcatiions.length
          ,


      ),
    );
  }
}
