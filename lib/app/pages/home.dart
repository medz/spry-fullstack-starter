import 'package:flutter/material.dart';
import 'package:unrouter/flutter.dart';

import '../../src/generated/api/models.dart';
import '../api.dart';

final useUsers = defineDataLoader<List<User>>((context) async {
  final response = await api.users.get();
  return response.data;
}, defaults: () => const []);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = useRouter(context);
    final request = useUsers(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: () => router.push('/users/new'),
              icon: const Icon(Icons.add),
              label: const Text('Create'),
            ),
          ),
        ],
      ),
      body: request.when(
        context: context,
        idle: (_) => const Center(child: CircularProgressIndicator()),
        pending: (users) =>
            _UsersList(users: users ?? const [], onRefresh: request.refresh),
        success: (users) =>
            _UsersList(users: users ?? const [], onRefresh: request.refresh),
        error: (error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_outlined, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Failed to load users',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('${error?.error}', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: request.refresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  const _UsersList({required this.users, required this.onRefresh});

  final List<User> users;
  final Future<List<User>?> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final router = useRouter(context);

    if (users.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: const [
            SizedBox(height: 240),
            Center(child: Text('No users yet.')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(user.name),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('${user.email}\n${user.role}'),
              ),
              isThreeLine: true,
              trailing: Chip(label: Text(user.status)),
              onTap: () => router.push('/users/${user.id}'),
            ),
          );
        },
      ),
    );
  }
}
