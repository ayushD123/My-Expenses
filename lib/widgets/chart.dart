import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import 'package:fl_chart/fl_chart.dart';



class Chart extends StatelessWidget {

  final List<Activity> recentact;
  Chart(this.recentact);
  List<Map<String,dynamic>> get groupedactvalues{
    return List.generate(7, (index)
    {
      final weekday = DateTime.now().subtract(
          Duration(days: index)
      );
      double totalsum=0;
      for(var i=0;i<recentact.length;i++){
        if(recentact[i].date.day==weekday.day){
          totalsum+=recentact[i].price;
        }

      }
      print(totalsum);
      return {
        'day':DateFormat.E().format(weekday),
        'amount':totalsum,

      };
    });

  }
  int weekday(String s){
    if(s=='Mon'){
    return 0;
    }
    if(s=='Tue'){
      return 1;
    }
    if(s=='Wed'){
      return 2;
    }
    if(s=='Thu'){
      return 3;
    }
    if(s=='Fri'){
      return 4;
    }
    if(s=='Sat'){
      return 5;
    }else{
        return 6;
      }
    }
  Color colours(String s){
    if(s=='Mon'){
      return Colors.yellow.shade300;
    }
    if(s=='Tue'){
      return Colors.lightBlueAccent;
    }
    if(s=='Wed'){
      return Colors.pinkAccent;
    }
    if(s=='Thu'){
      return Colors.greenAccent;
    }
    if(s=='Fri'){
      return Colors.deepPurpleAccent;
    }
    if(s=='Sat'){
      return Colors.white;
    }else{
      return Colors.orangeAccent;
    }
  }
int netspending(){
    return groupedactvalues.fold(0, (sum, item) {
      return (sum + item['amount']).toInt();
    });
}





  @override
  Widget build(BuildContext context) {
    int amount=netspending();
    print(groupedactvalues);
    return Column(
      children: [
        Text('This Week Total Spent'),
        Text('₹$amount',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 50),),
        Flexible(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            color: Color(0xff020227),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.only(top:16,right: 10),
              child: BarChart(
                BarChartData(
                    gridData: FlGridData(show: false),
                  alignment: BarChartAlignment.center,
                  maxY: 1000,
                  minY: 0,

                  groupsSpace: 30,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 35,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                  barGroups: groupedactvalues.map((e) =>
                  BarChartGroupData(x: weekday(e['day']),barRods: [BarChartRodData(toY: e['amount'],color: colours(e['day']))])).toList()

                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 100) {
    text = '100';
  } else if (value == 500) {
    text = '500';
  } else if (value == 1000) {

    text = '>1K';
  } else if (value == 5000){
  text='5K';
  }else{
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Mon', style: style);
      break;
    case 1:
      text = const Text('Tue', style: style);
      break;
    case 2:
      text = const Text('Wed', style: style);
      break;
    case 3:
      text = const Text('Thu', style: style);
      break;
    case 4:
      text = const Text('Fri', style: style);
      break;
    case 5:
      text = const Text('Sat', style: style);
      break;
    case 6:
      text = const Text('Sun', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 5, //margin top
    child: text,
  );
}

