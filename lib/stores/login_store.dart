import 'package:XLO_mobX/repositories/user_repository.dart';
import 'package:XLO_mobX/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:XLO_mobX/helpers/extensions.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {

	/* Email */

	@observable
	String email;

	@action
	void setEmail(String value) => email = value;
	
	@computed
	bool get emailValid => email != null && email.isEmailValid();
	String get emailError =>
		email == null || emailValid ? null : "E-mail inválido";


	/* Senha */

	@observable
	String password;

	@action
	void setPassword(String value) => password = value;

	@computed
	bool get passwordValid => password != null && password.length >= 4;
	String get passwordError =>
		password == null || passwordValid ? null : "Senha inválida";

		
	/* Validação do formulário */

	@computed
	Function get loginPressed => emailValid && passwordValid && !loading ? _login : null;

	@observable
	bool loading = false;

	@observable
	String error;

	@action
	Future <void> _login() async {
		loading = true;

		try {
			final user =  await UserRepository().loginWithEmail(email, password);
			GetIt.I<UserManagerStore>().setUser(user);
		} catch(e) {
			error = e;
		}

		loading = false;
	}

}