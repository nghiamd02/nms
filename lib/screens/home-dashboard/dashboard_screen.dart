import 'package:flutter/material.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:nms/helpers/status_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/note.dart';
import '../../models/status.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> _journals = [];
  List<Status> statuses = [];
  Map<Status, int> sum = {};

  Future<void> getNotes() async {
    final data = await NoteHelper.getNotes();
    setState(() {
      _journals = data;
      for (var i = 0; i < data.length; i++) {
        int id = Note.fromJson(_journals[i]).status ?? 0;
        final status = statuses.firstWhere((element) => (element.id == id));
        sum[status] = (sum[status] ?? 0) + 1;
        if (i == data.length - 1) {
          sum.removeWhere((key, value) => (value == 0));
          statuses.removeWhere((e) => (sum[e] == 0 || sum[e] == null));
        }
      }
    });
  }

  Future<void> getListStatus() async {
    final data = await StatusHelper.getStatusList();

    setState(() {
      for (var i = 0; i < data.length; i++) {
        statuses.add(Status.fromJson(data[i]));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListStatus();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return _journals.isEmpty
        ? const Center(
            child: Text('Empty'),
          )
        : Scaffold(
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SfCircularChart(palette: const [
                  Colors.grey,
                  Colors.redAccent,
                  Colors.blueAccent
                ], series: <CircularSeries>[
                  PieSeries<Status, String>(
                    dataSource: statuses,
                    xValueMapper: (Status data, _) => data.name,
                    yValueMapper: (Status data, _) =>
                        ((sum[data] ?? 0) / _journals.length * 100),
                    dataLabelMapper: (Status data, _) =>
                        "${data.name} \n${((sum[data] ?? 0) / _journals.length * 100).toStringAsFixed(2)}%",
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        color: Colors.black,
                        opacity: 0.3,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                    radius: '100%',
                    startAngle: -80,
                    endAngle: -80,
                  )
                ])),
          );
  }
}
