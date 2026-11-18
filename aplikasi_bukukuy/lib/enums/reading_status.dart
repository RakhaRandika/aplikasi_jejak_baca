enum ReadingStatus {
  wantToRead('ingin_dibaca', 'Ingin Dibaca'),
  reading('sedang_dibaca', 'Sedang Dibaca'),
  finished('selesai', 'Selesai');

  const ReadingStatus(this.value, this.label);

  final String value;
  final String label;

  static ReadingStatus? fromValue(String? value) {
    for (final status in ReadingStatus.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}
