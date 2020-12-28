import 'package:XLO_mobX/components/error_box.dart';
import 'package:XLO_mobX/screens/signup/components/field_title.dart';
import 'package:XLO_mobX/stores/signup_store.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignupScreen extends StatelessWidget {

	final SignupStore signupStore = SignupStore();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Cadastro"),
				centerTitle: true
			),
			body: Container(
				alignment: Alignment.center,
				child: SingleChildScrollView(
					padding: EdgeInsets.symmetric(vertical: 20),
					child: Card(
						margin: const EdgeInsets.symmetric(horizontal: 32),
						shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(16)
						),
						elevation: 8,
						child: Padding(
							padding: const EdgeInsets.all(16),
							child: Column(
								mainAxisSize: MainAxisSize.min,
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									Observer(builder: (_) {
										return Padding(
											padding: const EdgeInsets.symmetric(vertical: 8.0),
											child: ErrorBox(
												message: signupStore.error
											)
										);
									}),
									FieldTitle(title: "Apelido", subtitle: "Como ele aparecerá em seus anúncios"),
									Observer(builder: (_) {
										return TextField(
											enabled: !signupStore.loading,
											decoration: InputDecoration(
												border: OutlineInputBorder(),
												hintText: "Exemplo: João S.",
												isDense: true,
												errorText: signupStore.nameError,
											),
											onChanged: signupStore.setName,
										);
									}),
									SizedBox(height: 16),
									FieldTitle(title: "E-mail", subtitle: "Enviaremos um e-mail de confirmação."),
									Observer(builder: (_) {
									   return TextField(
										   	enabled: !signupStore.loading,
											decoration: InputDecoration(
												border: OutlineInputBorder(),
												hintText: "Exemplo: João@gmail.com",
												isDense: true,
												errorText: signupStore.emailError
											),
											onChanged: signupStore.setEmail,
											keyboardType: TextInputType.emailAddress,
											autocorrect: false
										);
									}),
									SizedBox(height: 16),
									FieldTitle(title: "Celular", subtitle: "Proteja sua conta"),
									Observer(builder: (_) {
									   return TextField(
										   enabled: !signupStore.loading,
											decoration: InputDecoration(
												border: OutlineInputBorder(),
												hintText: "(99) 99999-9999",
												isDense: true,
												errorText: signupStore.phoneError
											),
											keyboardType: TextInputType.phone,
											onChanged: signupStore.setPhone,
											inputFormatters: [
												FilteringTextInputFormatter.digitsOnly,
												TelefoneInputFormatter()
											]
										);
									}),
									SizedBox(height: 16),
									FieldTitle(title: "Senha", subtitle: "Use letras, números e caracteres especiais"),
									Observer(builder: (_) {
									   return TextField(
										   enabled: !signupStore.loading,
											decoration: InputDecoration(
												border: const OutlineInputBorder(),
												isDense: true,
												errorText: signupStore.pass1Error
											),
											obscureText: true,
											onChanged: signupStore.setPass1
										);
									}),
									SizedBox(height: 16),
									FieldTitle(title: "Confirmar Senha", subtitle: "Repita a senha"),
									Observer(builder: (_) {
									   return TextField(
										   enabled: !signupStore.loading,
											decoration: InputDecoration(
												border: const OutlineInputBorder(),
												isDense: true,
												errorText: signupStore.pass2Error
											),
											obscureText: true,
											onChanged: signupStore.setPass2
										);
									}),
									SizedBox(height: 16),
									Observer(builder: (_) {
									   return Container(
											height: 40,
											margin: const EdgeInsets.only(top: 20, bottom: 12),
											child: RaisedButton(
												color: Colors.orange,
												disabledColor: Colors.orange.withAlpha(120),
												child: signupStore.loading ? CircularProgressIndicator(
													valueColor: AlwaysStoppedAnimation(Colors.white)
												) : Text("Cadastrar"),
												textColor: Colors.white,
												elevation: 0,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(20)
												),
												onPressed: signupStore.signupPressed
											)
										);
									}),
									Divider(color: Colors.grey),
									Padding(
										padding: const EdgeInsets.symmetric(vertical: 8),
										child: Wrap(
											alignment: WrapAlignment.center,
											children: [
												const Text("Já tem uma conta? ",
													style: TextStyle(fontSize: 16)
												),
												GestureDetector(
													onTap: Navigator.of(context).pop,
													child: Text("Entrar",
														style: TextStyle(
															fontSize: 16,
															color: Colors.purple,
															decoration: TextDecoration.underline,
															fontWeight: FontWeight.w700
														)
													)
												)
											]
										)
									)
								]
							)
						)
					)
				)
			)
		);
	}
}