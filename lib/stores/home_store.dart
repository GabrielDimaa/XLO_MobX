import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/repositories/ad_repository.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {

  _HomeStoreBase() {
    autorun((_) async { // quando qualquer um dos observable serem alterados, o autorun roda novamente
      final newAds = await AdRepository().getHomeAdList(
        filter: filterStore,
        search: search,
        category: category
      );
      print(newAds);
    });
  }
  
	@observable
	String search = "";

	@action
	void setSearch(String value) => search = value;

	@observable
	Category category;

	@action
	void setCategory(Category value) => category = value;

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get clonedFilter => filterStore.clone();

  @action
  void setFilter(FilterStore value) => filterStore = value;

}