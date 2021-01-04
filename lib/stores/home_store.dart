import 'package:XLO_mobX/models/category.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  
	@observable
	String search = "";

	@action
	void setSearch(String value) => search = value;

	@observable
	Category category;

	@action
	void setCategory(Category value) => category = value;

}