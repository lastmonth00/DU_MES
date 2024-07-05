import 'package:flutter/material.dart';

import '../models/model.dart';

class StockManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> rawData = fetchData();
    List<Stock> stock = parseStock(rawData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock List'),
      ),
      body: ListView.builder(
        itemCount: stock.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('창고명: ${stock[index].stkId}'),
            subtitle: Text('창고코드: ${stock[index].partNo}'),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> fetchData() {
    return [
      {"STK_ID": "IDIFA", "PART_NO": "123"},
      {"STK_ID": "IDIFB", "PART_NO": "SNACK"},
      {"STK_ID": "TEST1", "PART_NO": "SNACK"},
      {"STK_ID": "IDIFA", "PART_NO": "SNACK"},
      {"STK_ID": "TEST1", "PART_NO": "TEST"},
    ];
  }

  List<Stock> parseStock(List<Map<String, dynamic>> rawData) {
    return rawData.map((item) => Stock.fromJson(item)).toList();
  }
}
