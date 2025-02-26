part of '_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().user;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.edit)
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(user?.email ?? '-'),
            subtitle: const Text('Email'),
          ),
          ListTile(
            title: Text(user?.profile.displayName ?? '-'),
            subtitle: const Text('Display name'),
          ),
          ListTile(
            title: Text(user?.profile.username ?? '-'),
            subtitle: const Text('Username'),
          ),
        ],
      ),
    );
  }
}