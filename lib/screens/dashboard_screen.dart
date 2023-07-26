import 'package:flutter/material.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:nms/helpers/status_helper.dart';
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
    List<Map<String, dynamic>> journals = [];
    List<Status> statuses = [];
    Map<Status, int> sum = {};

    Future<void> getNotes() async {
      final data = await NoteHelper.getNotes();

      setState(() {
        journals = data;
      });
    }

    Future<Status> getStatus(int id) async {
      return await StatusHelper.getStatus(id);
    }

    getNotes();

    for (var i = 0; i < journals.length; i++) {
      Status data = getStatus(journals[i]['id_status']) as Status;
      sum[data] = (sum[data] ?? 0) + 1;
      if (!statuses.contains(data)) {
        statuses.add(data);
      }
    }

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SfCircularChart(
              palette: const [Colors.grey, Colors.redAccent, Colors.blueAccent],
              series: <CircularSeries>[
                PieSeries<Status, String>(
                  dataSource: statuses,
                  xValueMapper: (Status data, _) => data.name,
                  yValueMapper: (Status data, _) => ((sum[data] ?? 0) / journals.length * 100),
                  // Map the data label text for each point from the data source
                  dataLabelMapper: (Status data, _) => "${data.name} \n${((sum[data] ?? 0) / journals.length * 100)}%",
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

