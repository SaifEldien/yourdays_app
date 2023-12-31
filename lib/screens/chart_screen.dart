
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../bloC/app_theme_bloc/app_theme_cubit.dart';
import '../const/functions.dart';

import '../models/day.dart';



class ChartScreen extends StatefulWidget {
  final List<Day> days;
  ChartScreen({Key? key, required this.days}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int date = 1;

  @override
   Widget build(BuildContext context) {
      List<Day> days =widget.days ;
     if (date!=1) {
       days=days.where((element) =>
       DateTime.parse(element.date!).month==DateTime.now().month&&
           DateTime.parse(element.date!).year==DateTime.now().year).toList();
     }
     List <Color> colors = [];
     Map<String,double> dataMap = {};
     for (int i=0;i<days.length;i++) {
       dataMap[days[i].mood!.title] = numberOfOccurence(days,days[i].mood!.id) ;
       if (!colors.contains(days[i].mood!.color.withOpacity(0.8))) colors.add(days[i].mood!.color.withOpacity(0.8));
     }
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill, image:AssetImage(BlocProvider.of<AppThemeCubit>(context).wallpaper),
            )),
        child: Scaffold(
         backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Days Overview",style: TextStyle(color: Colors.white),),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
         body: Center(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Container(
                   decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Colors.white),
                       borderRadius:
                       const BorderRadius.all(Radius.circular(50))),
                   margin: const EdgeInsets.all(15),
                   padding: const EdgeInsets.all(8.0),
                   child: DropdownButton(
                     iconEnabledColor: Colors.white,
                       dropdownColor: Colors.transparent,
                       underline: const SizedBox(),
                       value: dropDownItemsDates.where((element) => element.value == date).first.value,
                       items: dropDownItemsDates,
                       onChanged: (value) {
                         date = value;
                         setState(() {});
                       }),
                 ),
               ),

               Container(
                 margin: const EdgeInsets.only(top: 80),
                 padding: const EdgeInsets.all(15.0),
                 child: PieChart(
                   centerText: "Your Days",
                   dataMap:  dataMap,
                   chartType: ChartType.ring,
                   chartValuesOptions: const ChartValuesOptions(
                     showChartValuesInPercentage: true,
                   ),
                   legendOptions: LegendOptions(
                     legendTextStyle: TextStyle(color: Colors.white)
                   ),
                   colorList: colors,
                   totalValue: double.parse(days!.length.toString(),
                 ),
               )),
             ],
           ),
         ),
       ),
     );
   }
}
List<DropdownMenuItem> dropDownItemsDates = [
  const DropdownMenuItem(
      value: 0,
      child: Text("This Month",style: TextStyle(color: Colors.white),)
  ),
  const DropdownMenuItem(
      value: 1,
      child: Center(child: Text("All",style: TextStyle(color: Colors.white),))
  ),
];

