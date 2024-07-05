import '../main.dart';

class ReturnData {
  final int returnInt;
  final String returnString;
  late final List<Map<String, Object?>> returnJson1;
  late final List<Map<String, Object?>> returnJson2;
  late final List<Map<String, Object?>> returnJson3;

  ReturnData(Map<String, dynamic> json)
      : returnInt = json["ReturnInt"],
        returnString = json["ReturnString"] {
    returnJson1 = json.containsKey('ReturnJson1') && json["ReturnJson1"] != null
        ? castListMap(json["ReturnJson1"])
        : [];
    returnJson2 = json.containsKey('ReturnJson2') && json["ReturnJson2"] != null
        ? castListMap(json["ReturnJson2"])
        : [];
    returnJson3 = json.containsKey('ReturnJson3') && json["ReturnJson3"] != null
        ? castListMap(json["ReturnJson3"])
        : [];
  }

  ReturnData.error(int rtnInt, String rtnString)
      : returnInt = rtnInt,
        returnString = rtnString;
}
