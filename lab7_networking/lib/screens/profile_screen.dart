import 'package:material_ui/material_ui.dart';

import '../models/random_user.dart';
import '../widgets/profile_image.dart';

/// Profile screen for the user currently shown on the Home screen.
///
/// It receives the exact [RandomUser] object passed from Home (no refetch), and
/// displays the non-authentication profile fields. Username and UUID are shown
/// as account identifiers; password and hash fields are never displayed.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final RandomUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ProfileImage(url: user.picture?.large, size: 160),
          ),
          const SizedBox(height: 16),
          Text(
            user.name?.full ?? 'Unknown',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          Text(
            'Generated sample data — not a real person',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          _DetailsCard(user: user),
        ],
      ),
    );
  }

}

/// "street, city, state, country" with postcode/timezone appended when
/// available, matching the profile layout of the lab reference.
String _locationText(RandomUser user) {
  final location = user.location;
  final parts = <String>[
    location?.street?.full ?? '',
    location?.cityStateCountry ?? '',
  ];
  final base = parts
      .where((p) => p.isNotEmpty)
      .join(', ')
      .trim();
  final postcode = location?.postcode;
  final timezone = location?.timezone?.full;
  final extras = <String>[
    if (postcode != null && postcode.isNotEmpty) postcode,
    if (timezone != null && timezone.isNotEmpty) timezone,
  ];
  if (extras.isEmpty) return base;
  return '$base (${extras.join(' · ')})';
}

/// "YYYY-MM-DD (Age N)", or just the date/age when one is missing.
String _dateWithAge(DateInfo? info) {
  if (info == null) return '';
  final date = _formatDate(info.date);
  if (info.age == null) return date;
  if (date.isEmpty) return 'Age ${info.age}';
  return '$date (Age ${info.age})';
}

/// "SSN: 123-45-6789" style combined ID type and value.
String _idText(UserId? id) {
  if (id == null) return '';
  return [id.name, id.value]
      .where((p) => p != null && p.trim().isNotEmpty)
      .join(': ')
      .trim();
}

/// Formats an ISO-8601 timestamp as a readable date, falling back to the
/// raw string if parsing fails.
String _formatDate(String? raw) {
  if (raw == null || raw.isEmpty) return '';
  final dt = DateTime.tryParse(raw);
  if (dt == null) return raw;
  final month = dt.month.toString().padLeft(2, '0');
  final day = dt.day.toString().padLeft(2, '0');
  return '${dt.year}-$month-$day';
}

/// A flat card of label/value rows. Empty values are hidden, and the whole
/// card is omitted if every value is empty.
class _DetailsCard extends StatelessWidget {
  _DetailsCard({required this.user}) {
    rows = [
      _InfoRow(label: 'Gender', value: user.gender),
      _InfoRow(label: 'Location', value: _locationText(user)),
      _InfoRow(label: 'Email', value: user.email),
      _InfoRow(label: 'Date of Birth', value: _dateWithAge(user.dob)),
      _InfoRow(label: 'Registered', value: _formatDate(user.registered?.date)),
      _InfoRow(label: 'Phone', value: user.phone),
      _InfoRow(label: 'Cell', value: user.cell),
      _InfoRow(label: 'ID', value: _idText(user.id)),
      _InfoRow(label: 'Nationality', value: user.nat),
      _InfoRow(label: 'Username', value: user.login?.username),
      _InfoRow(label: 'UUID', value: user.login?.uuid),
    ];
  }

  final RandomUser user;
  late final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    final visible = rows
        .where((r) => r.value != null && r.value!.trim().isNotEmpty)
        .toList();
    if (visible.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: visible,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final text = value ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
