import 'package:XLO_mobX/models/ad.dart';
import 'package:XLO_mobX/models/address.dart';
import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/repositories/ad_repository.dart';
import 'package:XLO_mobX/stores/cep_store.dart';
import 'package:XLO_mobX/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {

		// Imagens

	ObservableList images = ObservableList();

	@computed
	bool get imagesValid => images.isNotEmpty;
	String get imagesError {
		if(!showErrors || imagesValid) return null;
		else return "Insira uma Imagem";
	}

		// Título

	@observable
	String title = "";

	@action 
	void setTitle(String value) => title = value;

	@computed
	bool get titleValid => title.length >= 6;
	String get titleError {
		if(!showErrors || titleValid) return null;
		else if(title.isEmpty) return "Campo obrigatório!";
		else return "Título muito curto";
	}

		// Descrição

	@observable
	String description = "";

	@action
	void setDescription(String value) => description = value;

	@computed
	bool get descriptionValid => description.length >= 10;
	String get descriptionError {
		if(!showErrors || descriptionValid) return null;
		else if(description.isEmpty) return "Campo obrigatório!";
		else return "Descrição muito curta";
	}

		// Categoria

	@observable
	Category category;
	
	@action
	void setCategory(Category value) => category = value;

	@computed
	bool get categoryValid => category != null;
	String get categoryError {
		if(!showErrors || categoryValid) return null;
		else return "Campo obrigatório!";
	}

		// CEP

	CepStore cepStore = CepStore();

	@computed
	Address get address => cepStore.address;
	bool get addressValid => address != null;
	String get addressError {
		if(!showErrors || addressValid) return null;
		else return "Campo obrigatório!";
	}

		//Preço

	@observable
	String priceText = "";

	@action
	void setPrice(String value) => priceText = value;

	@computed
	num get price {
		if(priceText.contains(',')) {
			return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
		} else {
			return num.tryParse(priceText);
		}
	}
	bool get priceValid => price != null && price <= 9999999;
	String get priceError {
		if(!showErrors || priceValid) return null;
		else if(priceText.isEmpty) return "Campo obrigatório!";
		else return "Preço inválido"; 
	}

	// Telefone

	@observable
	bool hidePhone = false;

	@action
	void setHidePhone(bool value) => hidePhone = value;

	// Validação do formulário

	@computed
	bool get formValid => 
		imagesValid && titleValid && descriptionValid && 
		categoryValid && addressValid && priceValid;

	@computed
	Function get sendPressed => formValid ? _send : null;

	@observable
	bool loading = false;

	@observable
	String error;

	@observable
	bool savedAd = false;

	@observable
	bool showErrors = false;

	@action 
	void invalidSendPressed() => showErrors = true;

	@action
	Future<void> _send() async {
		final ad = Ad();

		ad.title = title;
		ad.description = description;
		ad.category = category;
		ad.price = price;
		ad.hidePhone = hidePhone;
		ad.images = images;
		ad.address = address;
		ad.user = GetIt.I<UserManagerStore>().user;

		loading = true;

		try {
			await AdRepository().save(ad);
			savedAd = true;
		} catch (e) {
			error = e;
		}

		loading = false;
	}
}