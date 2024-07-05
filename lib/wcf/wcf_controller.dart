import 'package:dio/dio.dart';
import 'wcf_return_data.dart';

class WcfController {
  static Future<ReturnData> postHttp(
      String procName, int overLoad, Map<String, Object?> dic) async {
    ReturnData res;
    try {
      String args = dic.isEmpty ? "[]" : '["${dic.keys.join('","')}"]';
      String vals = dic.isEmpty
          ? "[]"
          : '["${dic.values.join('","')}"]'.replaceAll('"null"', 'null');

      String sendData =
          '{"procName":"$procName","overload":1,"arguments":$args,"values":$vals,"serviceName":"IDAT_EDU","userID":"IDATMES","password":"yEMe7felBs7Wjg+BCJMKTOYdp/N3TMtXIssgEWBeDRU="}';

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

      response.data["ReturnString"] =
          Uri.decodeComponent(response.data["ReturnString"]);

      res =
          response.data["ReturnInt"] == 0 || response.data["ReturnInt"] == 9999
              ? ReturnData(response.data)
              : ReturnData.error(
                  response.data["ReturnInt"], response.data["ReturnString"]);
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      res = ReturnData.error(-999, e.message!);
    }

    return res;
  }
}
