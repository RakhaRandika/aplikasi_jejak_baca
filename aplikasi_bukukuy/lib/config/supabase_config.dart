// Alamat project dan publishable key Supabase.
class SupabaseConfig {
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://vrogqyihkwvskmayofed.supabase.co',
  );

  static const publishableKey = String.fromEnvironment(
    'SUPABASE_KEY',
    defaultValue: 'sb_publishable_GRxh_CehNdbLTfb9-oZW3Q_9YTgv5Zn',
  );
}
