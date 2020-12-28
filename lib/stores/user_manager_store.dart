import 'package:XLO_mobX/models/user.dart';
import 'package:XLO_mobX/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';
part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStoreBase with _$UserManagerStore;

abstract class _UserManagerStoreBase with Store {

	_UserManagerStoreBase() {
		_getCurrenceUser();
	}

	@observable
	User user;

	@action
	void setUser(User value) => user = value;

	@computed
	bool get isLoggedIn => user != null;

	Future<void> _getCurrenceUser() async {
		final user = await UserRepository().currentUser();
		setUser(user);
	}

}