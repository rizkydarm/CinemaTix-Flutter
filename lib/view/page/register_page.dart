part of '_page.dart';

class RegisterPage extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

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
              child: GestureDetector(
                onDoubleTap: () {
                  context.push('/talker_screen');
                },
                child: Image.asset('assets/icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Register',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
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
            BlocListener<AuthCubit, BlocState>(
              listener: (context, state) {
                if (state is LoadingState) {
                  showLoadingHud(context);
                }
                if (state is ErrorState) {
                  hideLoadingHud(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is SuccessState) {
                  hideLoadingHud(context);
                  context.go('/home');
                }
              },
              child: ElevatedButton(
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
            
                  final cubit = context.read<AuthCubit>();
                  cubit.register(email, password);
                },
                child: const Text('Submit'),
              )
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    context.go('/login');
                  },
                  child: Text('Login',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}