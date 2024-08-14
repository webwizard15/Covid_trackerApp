import 'package:covid_tracker/Services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: statesServices.fetchWorldStatsRecords(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                    );
                  }else {
                    return Column(
                      children: [
                        PieChart(
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width * 0.5,
                          legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          dataMap: {"Total": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                            "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ResuableRow(title: "Total", value:snapshot.data!.cases!.toString() ),
                                Divider(),
                                ResuableRow(title: "Recovered", value: snapshot.data!.recovered!.toString()),
                                Divider(),
                                ResuableRow(title: "Deaths", value:snapshot.data!.deaths!.toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1aa260),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                              child: const Text("Track Countries")
                          ),
                        )
                      ],
                    );
                  }
                },
            ),

          ],
        ),
      ),
    ));
  }
}

class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
