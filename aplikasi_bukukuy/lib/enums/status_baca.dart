enum StatusBaca {
  ingin('ingin_dibaca', 'Ingin Dibaca'),
  sedang('sedang_dibaca', 'Sedang Dibaca'),
  selesai('selesai', 'Selesai');

  const StatusBaca(this.value, this.label);

  final String value;
  final String label;

  static StatusBaca? fromValue(String? value) {
    for (final status in StatusBaca.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}
