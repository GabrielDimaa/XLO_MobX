import 'package:XLO_mobX/models/category.dart';
import 'package:mobx/mobx.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {

	ObservableList images = ObservableList();

	@observable
	Category category;
	
	@action
	void setCategory(Category value) => category = value;
  
}