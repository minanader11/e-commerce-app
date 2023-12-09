import 'package:e_commerce/providers/email_provider.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends ConsumerStatefulWidget {
  AuthScreen({super.key});
  @override
  ConsumerState<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _hasAccount = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';

  void _submit() async {
    final _isValid = _form.currentState!.validate();
    if (_isValid) {
      _form.currentState!.save();
      if (!_hasAccount) {
        try {
          final userCredential = await _firebase.createUserWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(_enteredEmail)
              .set({
            'email': _enteredEmail,
            'username': _enteredUserName,
          });
        } on FirebaseAuthException catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message ??
                    'Authentication failed please try to create an email',
              ),
            ),
          );
        }
      } else {
        try {
          final userCredential = await _firebase.signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
        } on FirebaseAuthException catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message ??
                    'Authentication failed please try to create an email',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              height: 100,
              width: double.infinity,
              child: Icon(
                Icons.shopping_basket,
                size: 200,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        if (!_hasAccount)
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your UserName',
                                labelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 4) {
                                return 'User Name must be more than 4 Characters ';
                              }
                              return null;
                            },
                            onSaved: (value) => _enteredUserName = value!,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Email',
                                labelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please Enter a Valid Email Address';
                              }
                              ref.watch(emailProvider.notifier).onLogin(value);
                              return null;
                            },
                            onSaved: (value) => _enteredEmail = value!),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Password',
                                labelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 6) {
                                return 'Password characters must be more than 6 characters ';
                              }
                              return null;
                            },
                            onSaved: (value) => _enteredPassword = value!),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _submit,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.primary)),
                              child: Text(
                                  _hasAccount ? 'Sign In ' : 'Create Account',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _hasAccount = !_hasAccount;
                                });
                              },
                              child: Text(
                                _hasAccount ? 'Create An Account' : 'Log In',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
