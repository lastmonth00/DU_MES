import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddLocPage extends StatefulWidget {
  @override
  _AddLocPageState createState() => _AddLocPageState();
}

class _AddLocPageState extends State<AddLocPage> {
  final _formKey = GlobalKey<FormState>();
  final _stkLocCdController = TextEditingController();
  final _stkIdController = TextEditingController();

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      String stkLoccd = _stkLocCdController.text;
      String stkId = _stkIdController.text;

      // 데이터 서버로 전송
      try {
        Map<String, Object?> dic = {
          'STK_NM': stkLoccd,
          'STK_ID': stkId,
        };

        // 프로시저 호출을 위한 데이터 구성
        Map<String, dynamic> sendData = {
          'procName': 'DBM1.ADD_LOC',
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
            SnackBar(content: Text('위치가 성공적으로 추가되었습니다.')),
          );
          Navigator.pop(context); // 창고 추가 페이지 닫기
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('위치 추가 실패: ${response.data["ReturnString"]}')),
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
        title: Text('위치 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _stkLocCdController,
                decoration: InputDecoration(labelText: '위치명'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '위치명을 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stkIdController,
                decoration: InputDecoration(labelText: '위치코드'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '위치코드를 입력하세요';
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
