import 'package:XLO_mobX/models/address.dart';
import 'package:XLO_mobX/repositories/cep_repository.dart';
import 'package:mobx/mobx.dart';
part 'cep_store.g.dart';

class CepStore = _CepStoreBase with _$CepStore;

abstract class _CepStoreBase with Store {

	_CepStoreBase() {
		autorun((_) {
			if(clearCep.length != 8) {
				_reset();
			} else {
				_searchCep();
			}
		});
	}

	@observable
	String cep = '';

	@action
	void setCep(String value) => cep = value;

	@computed
	String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

	@observable
	Address address;

	@observable
	String error;

	@observable
	bool loading = false;

	@action
	Future<void> _searchCep() async {
		loading = true;

		try {
			address = await CepRepository().getAddressFromApi(clearCep);
			error = null;
		} catch (e) {
			address = null;
			error = e;
		}

		loading = false;
	}

	@action
	void _reset() {
		address = null;
		error = null;
	}
  
}