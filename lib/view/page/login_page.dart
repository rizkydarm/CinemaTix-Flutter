part of '_page.dart';

class LoginPage extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 0, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/icon.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 100.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.2),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            StatefulValueBuilder<bool>(
              initialValue: true,
              builder: (context, value, setState) {
                return TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.2),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        value! ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                      ),
                      onPressed: () {
                        setState(!value);
                      },
                    ),
                  ),
                  obscureText: value,
                );
              }
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email and password cannot be empty')),
                    );
                    return;
                  }

                  String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
                  RegExp regex = RegExp(emailPattern);
                  if (!regex.hasMatch(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid email address')),
                    );
                    return;
                  }

                  if (password.length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password must be at least 8 characters long')),
                    );
                    return;
                  }

                  context.go('/home');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}