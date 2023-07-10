import 'package:flutter/material.dart';
import 'package:minha_estante/services/user_library_service.dart';

abstract class ProfileState<T extends StatefulWidget> extends State<T> {
  final UserLibraryService _userLibraryService = UserLibraryService();
  int booksReadCount = -1;
  int booksToReadCount = -1;
  int booksAbandonedCount = -1;
  int booksBeingReadCount = -1;
  int totalBooksCount = -1;

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      String userId = await _userLibraryService.getUserId();
      booksReadCount = await _userLibraryService.getBooksReadCount(userId);
      booksToReadCount = await _userLibraryService.getBooksToReadCount(userId);
      booksAbandonedCount =
          await _userLibraryService.getBooksAbandonedCount(userId);
      booksBeingReadCount =
          await _userLibraryService.getBooksBeingReadCount(userId);
      totalBooksCount = await _userLibraryService.getTotalBooksCount(userId);
      setState(() {});
    } catch (e) {
      print('Erro ao carregar as estatísticas: $e');
    }
  }
}