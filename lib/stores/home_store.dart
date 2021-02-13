import 'package:XLO_mobX/models/ad.dart';
import 'package:XLO_mobX/models/category.dart';
import 'package:XLO_mobX/repositories/ad_repository.dart';
import 'package:XLO_mobX/stores/filter_store.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  _HomeStoreBase() {
    autorun((_) async {
      // quando qualquer um dos observable serem alterados, o autorun roda novamente
      try {
        setLoading(true);

        final newAds = await AdRepository().getHomeAdList(
          filter: filterStore,
          search: search,
          category: category,
          page: page,
        );

        addNewAds(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e);
      }
    });
  }

  @observable
  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String search = "";

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get clonedFilter => filterStore.clone();

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() => page++;

  @action
  void addNewAds(List<Ad> newAds) {
    if(newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
