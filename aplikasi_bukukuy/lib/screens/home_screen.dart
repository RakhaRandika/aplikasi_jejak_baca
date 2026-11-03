import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/load_state.dart';
import '../models/book.dart';
import '../routes/app_routes.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../widgets/app_button_nav.dart';
import '../widgets/book_card.dart';
import 'book_detail_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  LoadState _booksState = LoadState.loading;
  String _booksError = '';
  List<Book> _books = [];
  String _search = '';
  Timer? _debounce;

  LoadState _favState = LoadState.loading;
  String _favError = '';
  List<Book> _favorites = [];
  // id buku yang sedang dikirim ke server, supaya tap ganda diabaikan
  final Set<String> _pendingFavorites = {};

  @override
  void initState() {
    super.initState();
    _loadBooks();
    _loadFavorites();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadBooks({bool showSpinner = true}) async {
    final search = _search;
    if (showSpinner) setState(() => _booksState = LoadState.loading);
    try {
      final books = await ApiService.getBooks(search: search);
      // Abaikan hasil pencarian lama kalau kata kuncinya sudah berubah
      if (!mounted || search != _search) return;
      setState(() {
        _books = books;
        _booksState = books.isEmpty ? LoadState.empty : LoadState.success;
      });
    } catch (e) {
      if (!mounted || search != _search) return;
      setState(() {
        _booksError = e.toString();
        _booksState = LoadState.error;
      });
    }
  }

  Future<void> _loadFavorites() async {
    setState(() => _favState = LoadState.loading);
    try {
      final favorites = await ApiService.getFavorites();
      if (!mounted) return;
      setState(() {
        _favorites = favorites;
        _favState = favorites.isEmpty ? LoadState.empty : LoadState.success;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _favError = e.toString();
        _favState = LoadState.error;
      });
    }
  }

  Future<void> _refresh() =>
      Future.wait([_loadBooks(showSpinner: false), _loadFavorites()]);

  void _retry() {
    _loadBooks();
    _loadFavorites();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search = value.trim();
      _loadBooks();
    });
  }

  bool _isFavorite(Book book) => _favorites.any((f) => f.idBuku == book.idBuku);

  // true = berhasil disimpan ke server
  Future<bool> _toggleFavorite(Book book) async {
    if (_pendingFavorites.contains(book.idBuku)) return false;
    _pendingFavorites.add(book.idBuku);

    final wasFavorite = _isFavorite(book);
    try {
      if (wasFavorite) {
        await ApiService.hapusFavorite(book.idBuku);
      } else {
        await ApiService.tambahFavorite(book.idBuku);
      }
      if (mounted) {
        setState(() {
          _favorites = wasFavorite
              ? _favorites.where((f) => f.idBuku != book.idBuku).toList()
              : [book, ..._favorites];
          _favState = _favorites.isEmpty ? LoadState.empty : LoadState.success;
        });
      }
      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: const Color(0xFFDC2626),
            ),
          );
      }
      return false;
    } finally {
      _pendingFavorites.remove(book.idBuku);
    }
  }

  void _openDetail(Book book) {
    Get.to(
      () => BookDetailScreen(
        book: book,
        isFavorite: _isFavorite(book),
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final yakin = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text('Kamu perlu login lagi untuk masuk.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Keluar',
              style: TextStyle(color: Color(0xFFDC2626)),
            ),
          ),
        ],
      ),
    );
    if (yakin != true) return;

    await AuthService.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _currentIndex = 0);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildBeranda(),
            FavoriteScreen(
              state: _favState,
              errorMessage: _favError,
              favorites: _favorites,
              onRetry: _loadFavorites,
              onRemove: _toggleFavorite,
              onOpen: _openDetail,
            ),
          ],
        ),
        bottomNavigationBar: AppButtonNav(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }

  Widget _buildBeranda() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Container(
            color: const Color(0xFFFAF8F3),
            child: SafeArea(
              top: false,
              bottom: false,
              child: _buildBody(),
            ),
          ),
        ),
      ],
    );
  }

  // Header navy: warna penuh sampai pinggir layar, SafeArea di dalam Container
  Widget _buildHeader() {
    if (MediaQuery.orientationOf(context) == Orientation.landscape) {
      // Landscape: sapaan, kolom cari, dan tombol keluar dalam satu baris
      return Container(
        color: const Color(0xFF1E1A4D),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildGreeting()),
                const SizedBox(width: 16),
                Expanded(flex: 3, child: _buildSearchBox()),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFF1E1A4D),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildGreeting()),
                  _buildLogoutButton(),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildSearchBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Selamat Pembaca 👋',
                style: TextStyle(color: Color(0xFFC7D2FE), fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                AuthService.currentUser?.nama ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      tooltip: 'Keluar',
      onPressed: _confirmLogout,
      icon: const Icon(Icons.logout, color: Color(0xFFC7D2FE)),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2560),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: Color(0xFFA5B4FC)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Cari judul buku',
                hintStyle: TextStyle(color: Color(0xFFA5B4FC), fontSize: 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_booksState) {
      case LoadState.initial:
      case LoadState.loading:
        return _buildMessage(
          const CircularProgressIndicator(color: Color(0xFF1E1A4D)),
        );
      case LoadState.empty:
        return _buildMessage(const Text('Buku tidak ditemukan'));
      case LoadState.error:
        return _buildMessage(
          Column(
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Color(0xFF9E9E9E)),
              const SizedBox(height: 12),
              Text(_booksError, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1A4D),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        );
      case LoadState.success:
        break;
    }
    return _buildGrid();
  }

  // Spacer - Widget - Spacer di tengah area (vertikal + horizontal)
  Widget _buildMessage(Widget child) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(children: [const Spacer(), child, const Spacer()]),
        ),
        const Spacer(),
      ],
    );
  }

  // Grid dibuat dari baris Row: tiap baris = Row [kartu, Spacer, kartu, Spacer, kartu]
  Widget _buildGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const padding = 16.0;
        const spacing = 12.0;
        final columns = (constraints.maxWidth / 130).floor().clamp(3, 8);
        final cardWidth =
            ((constraints.maxWidth - padding * 2 - spacing * (columns - 1)) /
                    columns)
                .floorToDouble();
        final rowCount = (_books.length / columns).ceil();

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(padding),
            itemCount: rowCount,
            separatorBuilder: (context, index) =>
                const SizedBox(height: spacing),
            itemBuilder: (context, row) =>
                _buildGridRow(row, columns, cardWidth),
          ),
        );
      },
    );
  }

  Widget _buildGridRow(int row, int columns, double cardWidth) {
    final children = <Widget>[];
    for (var col = 0; col < columns; col++) {
      if (col > 0) children.add(const Spacer());
      final index = row * columns + col;
      if (index < _books.length) {
        final book = _books[index];
        children.add(
          BookCard(
            book: book,
            width: cardWidth,
            isFavorite: _isFavorite(book),
            onTap: () => _openDetail(book),
            onFavoriteTap: () => _toggleFavorite(book),
          ),
        );
      } else {
        // Baris terakhir yang belum penuh diisi kotak kosong
        children.add(SizedBox(width: cardWidth));
      }
    }
    return Row(children: children);
  }
}
