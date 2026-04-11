import 'package:flutter/material.dart';
import 'package:unrouter/flutter.dart';

import '../../src/generated/api/models.dart';
import '../../src/generated/api/params.dart';
import '../api.dart';

final useUser = defineDataLoader<User>((context) async {
  final id = useRouteParams(context).required('id');
  return api.users.byId(params: UsersByIdParams(id: id));
});

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = useRouter(context);
    final request = useUser(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => router.replace('/'),
        ),
      ),
      body: request.when(
        context: context,
        idle: (_) => const Center(child: CircularProgressIndicator()),
        pending: (user) {
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return _DetailsBody(user: user);
        },
        success: (user) {
          if (user == null) {
            return const Center(child: Text('User not found.'));
          }
          return _DetailsBody(user: user);
        },
        error: (error) => Center(
          child: Padding(
            padding: const .all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Failed to load user',
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

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(16),
      children: [
        Card(
          child: Padding(
            padding: const .all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(user.email),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text(user.status)),
                    Chip(label: Text(user.team)),
                    Chip(label: Text(user.location)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(title: const Text('Role'), subtitle: Text(user.role)),
              ListTile(
                title: const Text('Joined'),
                subtitle: Text(user.joinedLabel),
              ),
              ListTile(
                title: const Text('Last active'),
                subtitle: Text(user.lastActiveLabel),
              ),
              ListTile(
                title: const Text('Open tickets'),
                subtitle: Text('${user.openTickets}'),
              ),
              ListTile(
                title: const Text('Projects'),
                subtitle: Text('${user.projects}'),
              ),
              ListTile(
                title: const Text('Tags'),
                subtitle: Text(user.tags.join(', ')),
              ),
              ListTile(title: const Text('Bio'), subtitle: Text(user.bio)),
            ],
          ),
        ),
      ],
    );
  }
}
