import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/yellow_list_component.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginView extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Insets.l * 2),
        child: Column(
          children: [
            const YellowList(),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      await authViewModel.signIn(
                          emailController.text, passwordController.text);
                      // Handle navigation or error message based on the authentication state
                      if (context.mounted) {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
              child: isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Não tem uma conta? Registre-se.'),
            ),
          ],
        ),
      ),
    );
  }
}
