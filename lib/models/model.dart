class Stock {
  final String stkId;
  final String partNo;

  Stock({required this.stkId, required this.partNo});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      stkId: json['STK_ID'],
      partNo: json['PART_NO'],
    );
  }
}
