class Rides {
  final String id;
  final String user_id;
  final String date;
  final String time;
  final String payment_type;
  final String seats;
  final String status;

  Rides(
      {required this.id,
      required this.user_id,
      required this.date,
      required this.time,
      required this.payment_type,
      required this.seats,
      required this.status});

  factory Rides.fromMap(Map<String, dynamic> map) {
    return Rides(
      id: map['id'].toString(),
      user_id: map['user_id'],
      date: map['date'],
      time: map['time'],
      payment_type: map['payment_type'],
      seats: map['seats'],
      status: map['status'],
    );
  }
}
