import 'package:flutter/material.dart';
import 'package:nms/screens/side_menu.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/status.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final List<Status> statusData = [
      Status(status: StatusType.pending),
      Status(status: StatusType.pending),
      Status(status: StatusType.pending),
      Status(status: StatusType.pending),
      Status(status: StatusType.done),
      Status(status: StatusType.done),
      Status(status: StatusType.done),
      Status(status: StatusType.done),
      Status(status: StatusType.done),
      Status(status: StatusType.done),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
      Status(status: StatusType.processing),
    ];

    Map<StatusType, int> sum = {};

    for (Status element in statusData) {
      sum[element.status] = (sum[element.status] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
        ),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: const SideMenu("Home"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SfCircularChart(
            palette: const [Colors.grey, Colors.redAccent, Colors.blueAccent],
            series: <CircularSeries>[
              PieSeries<StatusType, String>(
                  dataSource: StatusType.values,
                  xValueMapper: (StatusType data, _) => data.title,
                  yValueMapper: (StatusType data, _) => ((sum[data] ?? 0) / statusData.length * 100),
                  // Map the data label text for each point from the data source
                  dataLabelMapper: (StatusType data, _) => "${data.title} \n${((sum[data] ?? 0) / statusData.length * 100)}%",
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      color: Colors.black,
                      opacity: 0.3,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )
                  ),
                  radius: '100%',
                  startAngle: -80,
                  endAngle: -80,
              )
            ]
        )
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.text);
  final String x;
  final double y;
  final String text;
}