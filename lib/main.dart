import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/new_transaction.dart';
import 'models/activity.dart';
import 'package:intl/intl.dart';
import './widgets/transcation_list.dart';
import 'dart:math';
import './widgets/chart.dart';
import './widgets/dismissible_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  String getdate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return formattedDate;
  }

  List<Activity> l=[

  ];


  final List<Activity> usertranscatiions=[
     Activity('1', 'Petrol', 250, DateTime.now()),
    Activity('2', 'Snacks', 550, DateTime.now().subtract(Duration(days: 2))),
    Activity('3', 'Rent', 350, DateTime.now().subtract(Duration(days: 3))),
    Activity('4', 'Diesal', 200, DateTime.now().subtract(Duration(days: 4))),
    // Activity('3', 'GF', 2250,DateTime.now()),
    // Activity('1', 'Petrol', 250, DateTime.now()),
    // Activity('2', 'Snacks', 550, DateTime.now()),
    // Activity('3', 'GF', 2250,DateTime.now()),
    // Activity('1', 'Petrol', 250, DateTime.now()),
    // Activity('2', 'Snacks', 550, DateTime.now()),
    // Activity('3', 'GF', 2250,DateTime.now())

  ];

  List<Activity> get recentTransactions {
    return usertranscatiions.where((tx) {
      assert(tx != null);
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void addTransaction(String activity_name,int amnt,DateTime dt){
    final newTx=Activity(Random().toString(), activity_name, amnt, dt);
    setState((){
      usertranscatiions.add(newTx);
    });
  }

  Widget openingscreen(){
    if(usertranscatiions.isEmpty){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(child: Image.asset("assets/empty.png"),
          margin: EdgeInsets.all(10),
          width: 350,),
          Text("No Expenses Yet",
          style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          SizedBox(
            height: 350,
              width: double.infinity,
              child: Chart(recentTransactions)),
          TranscationList(usertranscatiions,deletetrans),

        ],
      );
    }

  }
  void deletetrans(String id){
    setState((){
      usertranscatiions.removeWhere((element) => element.id==id);
    });
  }


  void showdialog(BuildContext cntx){
    showModalBottomSheet(context: cntx, builder: (_){
        return NewTransaction(addTransaction);
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            showdialog(context);
          }, icon: Icon(Icons.add,color: Colors.black,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Expenses',style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black
        ),),
      ),
      body:
      openingscreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showdialog(context);
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}
