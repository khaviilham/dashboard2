import 'package:flutter/material.dart';
import 'app_colors.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> kategori = [
    {"label": "Makanan", "icon": Icons.rice_bowl},
    {"label": "Minuman", "icon": Icons.local_drink},
    {"label": "Fastfood", "icon": Icons.fastfood},
    {"label": "Snack", "icon": Icons.cookie},
    {"label": "Baju", "icon": Icons.checkroom},
    {"label": "Celana", "icon": Icons.dry_cleaning},
  ];

  final List<Map<String, dynamic>> kantinFavorit = [
    {
      "nama": "Kantin Kak Adri",
      "kategori": "Makanan Berat",
      "rating": 4.8,
      "icon": Icons.restaurant,
    },
    {
      "nama": "Kantin Bu Divina",
      "kategori": "Aneka Jajanan",
      "rating": 4.9,
      "icon": Icons.fastfood,
    },
    {
      "nama": "Kantin Bintang",
      "kategori": "Es & Minuman",
      "rating": 5.0,
      "icon": Icons.icecream,
    },
    {
      "nama": "Kantin Pak Budi",
      "kategori": "Nasi & Lauk",
      "rating": 4.3,
      "icon": Icons.lunch_dining,
    },
  ];

  // Daftar kantin yang sudah difilter berdasarkan kata kunci pencarian.
  // Mencocokkan nama kantin ATAU kategori, tidak case-sensitive.
  List<Map<String, dynamic>> get _filteredKantin {
    if (_searchQuery.trim().isEmpty) return kantinFavorit;
    final query = _searchQuery.trim().toLowerCase();
    return kantinFavorit.where((item) {
      final nama = (item["nama"] as String).toLowerCase();
      final kategoriItem = (item["kategori"] as String).toLowerCase();
      return nama.contains(query) || kategoriItem.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildSearchBar(),
              const SizedBox(height: 22),

              // Saat sedang mencari, sembunyikan kategori & banner
              // supaya fokus ke hasil pencarian saja.
              if (_searchQuery.trim().isEmpty) ...[
                _buildKategori(),
                const SizedBox(height: 22),
                _buildPromoBanner(),
                const SizedBox(height: 24),
                _buildSectionTitle("Kantin Favorit"),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${_filteredKantin.length} hasil untuk \"$_searchQuery\"",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              _buildKantinList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo, Selamat Datang Khavi 👋",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Mau jajan apa hari ini?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              boxShadow: [AppColors.cardShadow],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppColors.cardShadow],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            // setState memicu build ulang -> _filteredKantin ikut ter-update
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Cari kantin atau menu...",
            hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
            suffixIcon: _searchQuery.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = "";
                      });
                    },
                  ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildKategori() {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          final item = kategori[index];
          return Container(
            margin: const EdgeInsets.only(right: 14),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.softAt(index),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    item["icon"] as IconData,
                    color: AppColors.primaryDark,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item["label"] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Diskon Spesial Hari Ini!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Dapatkan potongan harga di kantin pilihan",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_offer_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Text(
            "Lihat semua",
            style: TextStyle(fontSize: 13, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildKantinList() {
    final data = _filteredKantin;

    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 42, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            Text(
              "Tidak ada kantin yang cocok dengan \"$_searchQuery\"",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [AppColors.cardShadow],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.softAt(index),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: AppColors.primaryDark,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["nama"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item["kategori"] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          "${item["rating"]}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ],
          ),
        );
      },
    );
  }
}