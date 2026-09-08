import 'package:flutter/material.dart';
import 'app_colors.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  // Data riwayat transaksi/pesanan.
  // status: "selesai" | "diproses" | "batal"
  final List<Map<String, dynamic>> riwayat = [
    {
      "kantin": "Kantin Kak Adri",
      "item": "Nasi Ayam Geprek + Es Teh",
      "tanggal": "07 Sep 2026, 12.15",
      "total": 18000,
      "status": "selesai",
      "icon": Icons.restaurant,
    },
    {
      "kantin": "Kantin Bu Divina",
      "item": "Cireng + Bakso Goreng",
      "tanggal": "06 Sep 2026, 09.40",
      "total": 9000,
      "status": "selesai",
      "icon": Icons.fastfood,
    },
    {
      "kantin": "Kantin Bintang",
      "item": "Es Cendol",
      "tanggal": "05 Sep 2026, 13.05",
      "total": 6000,
      "status": "diproses",
      "icon": Icons.icecream,
    },
    {
      "kantin": "Kantin Bu Najla",
      "item": "Nasi Goreng Spesial",
      "tanggal": "04 Sep 2026, 12.30",
      "total": 15000,
      "status": "batal",
      "icon": Icons.local_drink,
    },
    {
      "kantin": "Kantin Pak Budi",
      "item": "Mie Ayam + Kerupuk",
      "tanggal": "02 Sep 2026, 11.50",
      "total": 12000,
      "status": "selesai",
      "icon": Icons.lunch_dining,
    },
    {
      "kantin": "kantin Mas Gusti",
      "item": "Es Jeruk + Roti Bakar",
      "tanggal": "01 Sep 2026, 15.20",
      "total": 11000,
      "status": "selesai",
      "icon": Icons.local_cafe,
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case "selesai":
        return AppColors.success;
      case "diproses":
        return AppColors.pending;
      case "batal":
        return AppColors.cancelled;
      default:
        return AppColors.textGrey;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case "selesai":
        return "Selesai";
      case "diproses":
        return "Diproses";
      case "batal":
        return "Dibatalkan";
      default:
        return status;
    }
  }

  String _formatRupiah(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromEnd = str.length - i;
      buffer.write(str[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(".");
    }
    return "Rp$buffer";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Riwayat Pesanan",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4, bottom: 12),
            child: Text(
              "${riwayat.length} transaksi tercatat",
              style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final trx = riwayat[index];
                final status = trx["status"] as String;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppColors.cardShadow],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      print("Klik riwayat ${trx["kantin"]}");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColors.softAt(index),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            trx["icon"] as IconData,
                            color: AppColors.primaryDark,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      trx["kantin"] as String,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _statusColor(status).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _statusLabel(status),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _statusColor(status),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                trx["item"] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    trx["tanggal"] as String,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Text(
                                    _formatRupiah(trx["total"] as int),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}