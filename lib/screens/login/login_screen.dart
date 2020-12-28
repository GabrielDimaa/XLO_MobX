import 'package:XLO_mobX/components/error_box.dart';
import 'package:XLO_mobX/screens/signup/signup_screen.dart';
import 'package:XLO_mobX/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatelessWidget {

	final LoginStore loginStore = LoginStore();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Entrar"),
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
								crossAxisAlignment: CrossAxisAlignment.stretch,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text("Acessar com E-mail:",
									textAlign: TextAlign.center,
										style: TextStyle(
											fontSize: 16,
											color: Colors.grey[900]
										)
									),
									Observer(builder: (_) {
										return Padding(
											padding: const EdgeInsets.only(top: 8.0),
											child: ErrorBox(
												message: loginStore.error
											),
										);
									}),
									Padding(
										padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
										child: Text("E-mail",
											style: TextStyle(
												color: Colors.grey[800],
												fontSize: 16,
												fontWeight: FontWeight.w700
											)
										)
									),
									Observer(builder: (_) {
									   return TextField(
											enabled: !loginStore.loading,
											decoration: InputDecoration(
												border: const OutlineInputBorder(),
												isDense: true,
												errorText: loginStore.emailError
											),
											keyboardType: TextInputType.emailAddress,
											onChanged: loginStore.setEmail,
										);
									}),
									SizedBox(height: 16),
									Padding(
										padding: const EdgeInsets.only(left: 3, bottom: 4),
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: [
												Text("Senha",
													style: TextStyle(
														color: Colors.grey[800],
														fontSize: 16,
														fontWeight: FontWeight.w700
													)
												),
												GestureDetector(
													child: Text("Esqueceu sua senha?",
														style: TextStyle(
															decoration: TextDecoration.underline,
															color: Colors.purple,
															fontWeight: FontWeight.w700
														)
													),
													onTap: () {}
												)
											]
										)
									),
									Observer(builder: (_) {
									   return TextField(
										   enabled: !loginStore.loading,
											decoration: InputDecoration(
												border: const OutlineInputBorder(),
												isDense: true,
												errorText: loginStore.passwordError
											),
											obscureText: true,
											onChanged: loginStore.setPassword
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
												child: loginStore.loading ?
													CircularProgressIndicator(
														valueColor: AlwaysStoppedAnimation(Colors.white),
													) :
													Text("Entrar"),
												textColor: Colors.white,
												elevation: 0,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(20)
												),
												onPressed: loginStore.loginPressed
											)
										);
									}),
									Divider(color: Colors.grey),
									Padding(
										padding: const EdgeInsets.symmetric(vertical: 8),
										child: Wrap(
											alignment: WrapAlignment.center,
											children: [
												const Text("Não tem uma conta? ",
													style: TextStyle(fontSize: 16)
												),
												GestureDetector(
													onTap: () {
														Navigator.of(context).push(
															MaterialPageRoute(builder: (_) => SignupScreen())
														);
													},
													child: Text("Cadastre-se",
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