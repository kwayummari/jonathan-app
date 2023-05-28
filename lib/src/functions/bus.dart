class Bus {
  final int id;
  final String number;
  final String status;
  final String liveLocation;

  Bus({required this.id, required this.number, required this.status, required this.liveLocation});

  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      id: map['id'],
      number: map['number'],
      status: map['status'],
      liveLocation: map['live_location'],
    );
  }
}
