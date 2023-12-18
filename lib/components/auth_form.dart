// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chat_firebase/components/user_image_picker.dart';
import 'package:flutter/material.dart';

import 'package:chat_firebase/core/models/auth_form_date.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  void _submit() {
    final isValid = _formkey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_formData.image == null && _formData.isSinup) {
      print(_formData.image.toString());
      return _showError('Imagem não selecionada');
    }
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              if (_formData.isSinup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_formData.isSinup)
                TextFormField(
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  key: ValueKey('name'),
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (_value) {
                    final name = _value ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no minimo 5 caracters';
                    }
                    return null;
                  },
                ),
              TextFormField(
                initialValue: _formData.email,
                onChanged: (value) => _formData.email = value,
                key: ValueKey('email'),
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (_value) {
                  final email = _value ?? '';
                  if (!email.contains('@')) {
                    return 'Email informado não é válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (value) => _formData.password = value,
                key: ValueKey('password'),
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                validator: (_value) {
                  final password = _value ?? '';
                  if (password.trim().length < 6) {
                    return 'Nome deve ter no minimo 6 caracters';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? "Entrar" : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? "Criar uma nova conta?"
                    : 'Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
