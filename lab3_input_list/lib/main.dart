import 'package:material_ui/material_ui.dart';

void main() => runApp(const Lab3App());

class Lab3App extends StatelessWidget {
  const Lab3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3: Input & List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const InputListScreen(),
    );
  }
}

/// Screen with a [TextField], an ADD button and a live-updating list.
class InputListScreen extends StatefulWidget {
  const InputListScreen({super.key});

  @override
  State<InputListScreen> createState() => _InputListScreenState();
}

class _InputListScreenState extends State<InputListScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> items = <String>[];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _addItem() {
    final value = controller.text.trim();
    if (value.isEmpty) {
      // Blank or whitespace-only input adds nothing.
      return;
    }
    setState(() {
      items.add(value);
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 3: Input & List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Item',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('ADD'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Item List',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('${items.length}'),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: items.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) =>
                          _ItemTile(index: index, text: items[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A styled, readable row for a single item.
class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.index, required this.text});

  final int index;
  final String text;

  static const List<Color> _colors = [
    Color(0xFF26A69A),
    Color(0xFF5C6BC0),
    Color(0xFFEF5350),
    Color(0xFFFFA726),
    Color(0xFF66BB6A),
    Color(0xFFEC407A),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[index % _colors.length];
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          foregroundColor: Colors.white,
          child: Text('${index + 1}'),
        ),
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.check_circle_outline, color: Colors.green),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.list_alt, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'No items yet',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Type an item and press ADD',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
