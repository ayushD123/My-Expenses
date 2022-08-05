import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function tx;
  NewTransaction(this.tx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final title=TextEditingController();
  late DateTime selectdate=DateTime(1000);

  final amnt=TextEditingController();
  // void acceptdata(){
  //   final entitle=title.text;
  //
  //   final enamnt=int.parse(amnt.text);
  //   if(enamnt<=0 || entitle.isEmpty){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Values Are Correct"),
  //     ));
  //
  //   }else{
  //     widget.tx(
  //       enamnt,entitle
  //     );
  //     Navigator.of(context).pop();
  //   }
  // }
  void datepicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now()).then((value){
      if(value==null){
        return;
      }
      setState((){
        selectdate=value;
      });

    });
  }
  Widget dateText(){
    if(selectdate==DateTime(1000)){
      return Text('No Date Choosen');
    }else{
      return Text('${DateFormat.yMd().format(selectdate)}' );
    }

  }



  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(textCapitalization: TextCapitalization.words,decoration: InputDecoration(
                labelText: 'Title',

              ),
                controller: title,),
              TextField(keyboardType: TextInputType.number,decoration: InputDecoration(
                  labelText: 'Amount'),
                onSubmitted: (val){
                  widget.tx(title.text,int.parse(amnt.text));
                  Navigator.of(context).pop();
                },
                controller: amnt,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dateText(),


                  Card(

                    child: FlatButton(onPressed: (){
datepicker();

                    },


                        child: Text("Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )),
                  ),

                ],
              ),
              Card(

                child: FlatButton(onPressed: (){



                  widget.tx(title.text,int.parse(amnt.text),selectdate);
                  Navigator.of(context).pop();
                },
                    height: 50,

                    color: Colors.blue,
                    child: Text("Add Transcation",
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),




              Container(
                height: 170,
                width: 350,
                child: Image.asset("assets/buy.png",
                ),
              )
            ],
          ),
        )
    );
  }
}
