import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final _formKey = GlobalKey<FormState>();
  final _stkNmController = TextEditingController();
  final _stkIdController = TextEditingController();

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      String stkNm = _stkNmController.text;
      String stkId = _stkIdController.text;

      // 데이터 서버로 전송
      try {
        Map<String, Object?> dic = {
          'STK_NM': stkNm,
          'STK_ID': stkId,
        };

        // 프로시저 호출을 위한 데이터 구성
        Map<String, dynamic> sendData = {
          'procName': 'DBM2.ADD_STK',
          'overload': 1,
          'arguments': dic.keys.toList(),
          'values': dic.values.toList(),
          'serviceName': 'IDAT_EDU',
          'userID': 'IDATMES',
          'password': 'yEMe7felBs7Wjg+BCJMKTOYdp/N3TMtXIssgEWBeDRU=',
        };

        String url = 'http://100.100.100.43:59820/IDAT_EDU/ExecProcPost';
        var response = await Dio().post(
          url,
          data: sendData,
          options: Options(
            method: 'POST',
            headers: {
              Headers.contentTypeHeader: Headers.jsonContentType,
              Headers.acceptHeader: 'application/json'
            },
            contentType: 'application/json',
          ),
        );

        if (response.data["ReturnInt"] == 0) {
          // 성공적으로 추가되었음을 사용자에게 알림
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('창고가 성공적으로 추가되었습니다.')),
          );
          Navigator.pop(context); // 창고 추가 페이지 닫기
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('창고 추가 실패: ${response.data["ReturnString"]}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류 발생: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('창고 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _stkNmController,
                decoration: InputDecoration(labelText: '창고명'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '창고명을 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stkIdController,
                decoration: InputDecoration(labelText: '창고코드'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '창고코드를 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('추가'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
