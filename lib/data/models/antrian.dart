import 'dart:convert';

class Antrian {
  final int? id;
  final String nama;
  final String noAntrian;
  final bool isActive;
  Antrian({
    this.id,
    required this.nama,
    required this.noAntrian,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'noAntrian': noAntrian,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory Antrian.fromMap(Map<String, dynamic> map) {
    return Antrian(
      id: map['id']?.toInt(),
      nama: map['nama'],
      noAntrian: map['noAntrian'],
      isActive: map['isActive'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Antrian.fromJson(String source) =>
      Antrian.fromMap(json.decode(source));

  Antrian copyWith({
    int? id,
    String? nama,
    String? noAntrian,
    bool? isActive,
  }) {
    return Antrian(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      noAntrian: noAntrian ?? this.noAntrian,
      isActive: isActive ?? this.isActive,
    );
  }
}

var dataAntrian = [
  Antrian(id: 1, nama: 'Teller', noAntrian: 'A-1', isActive: true),
  Antrian(id: 2, nama: 'STNK', noAntrian: 'B-2', isActive: true),
  Antrian(id: 3, nama: 'SIM', noAntrian: 'C-3', isActive: true),
  Antrian(id: 1, nama: 'Teller', noAntrian: 'A-1', isActive: true),
  Antrian(id: 2, nama: 'STNK', noAntrian: 'B-2', isActive: true),
  Antrian(id: 3, nama: 'SIM', noAntrian: 'C-3', isActive: true),
  Antrian(id: 1, nama: 'Teller', noAntrian: 'A-1', isActive: true),
  Antrian(id: 2, nama: 'STNK', noAntrian: 'B-2', isActive: true),
  Antrian(id: 3, nama: 'SIM', noAntrian: 'C-3', isActive: true),
  Antrian(id: 1, nama: 'Teller', noAntrian: 'A-1', isActive: true),
  Antrian(id: 2, nama: 'STNK', noAntrian: 'B-2', isActive: true),
  Antrian(id: 3, nama: 'SIM', noAntrian: 'C-3', isActive: true),
];
