import 'package:delta/wcf/wcf_controller.dart';
import 'package:delta/wcf/wcf_return_data.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class StockManagementPage extends StatefulWidget {
  @override
  _StockManagementPageState createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  late Future<ReturnData> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<ReturnData> fetchData() async {
    Map<String, Object?> dic = {};
    //dic['A_STK_ID'] = 'TEST1';
    ReturnData result = await WcfController.postHttp('DBM1.GET_STK_ID', 1, dic);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('창고관리'),
      ),
      body: Center(
        child: FutureBuilder<ReturnData>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return DataDisplay(data: snapshot.data!);
            } else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}

class DataDisplay extends StatelessWidget {
  final ReturnData data;

  DataDisplay({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ReturnInt: ${data.returnInt}'),
        Text('ReturnString: ${data.returnString}'),
        Expanded(
          child: ListView.builder(
            itemCount: data.returnJson1.length,
            itemBuilder: (context, index) {
              Map<String, Object?> item = data.returnJson1[index];
              String stkId = item['STK_ID']?.toString() ?? 'N/A';
              String partNo = item['PART_NO']?.toString() ?? 'N/A';

              return Card(
                child: ListTile(
                  title: Text('창고명: $stkId'),
                  subtitle: Text('창고코드: $partNo'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
