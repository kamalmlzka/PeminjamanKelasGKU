class ModelPinjam{
  late String pinjamId;
  late String tokenNumber;
  late String name;
  late String week;
  late String kodeRuangan;
  late String date;
  late List<String> slots;
  late String slotKey;

  ModelPinjam({
    required this.pinjamId,
    required this.tokenNumber,
    required this.name,
    required this.week,
    required this.kodeRuangan,
    required this.date,
    required this.slots,
    required this.slotKey
  });

  Map<String, dynamic> getModelPinjam() {
    return {
      'pinjamId':pinjamId,
      'tokenNumber': tokenNumber,
      'week': week,
      'name': name,
      'kodeRuangan': kodeRuangan,
      'date': date,
      'slots': slots,
      'slotKey': slotKey
    };
  }
}