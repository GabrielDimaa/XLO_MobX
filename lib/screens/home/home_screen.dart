import 'package:XLO_mobX/components/custom_drawer/custom_drawer.dart';
import 'package:XLO_mobX/screens/home/components/ad_tile.dart';
import 'package:XLO_mobX/screens/home/components/create_ad_button.dart';
import 'package:XLO_mobX/screens/home/components/search_dialog.dart';
import 'package:XLO_mobX/screens/home/components/top_bar.dart';
import 'package:XLO_mobX/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeStore homeStore = GetIt.I<HomeStore>();

  final ScrollController scrollController = ScrollController();

  openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(currentSearch: homeStore.search));
    if (search != null) homeStore.setSearch(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Observer(builder: (_) {
              if (homeStore.search.isEmpty) {
                return Container();
              }
              return GestureDetector(
                  onTap: () => openSearch(context),
                  child: LayoutBuilder(builder: (_, constraints) {
                    return Container(
                        width: constraints.biggest.width,
                        child: Text(homeStore.search));
                  }));
            }),
            actions: [
              Observer(builder: (_) {
                if (homeStore.search.isEmpty) {
                  return IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        openSearch(context);
                      });
                }
                return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      homeStore.setSearch("");
                    });
              })
            ]),
        drawer: CustomDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopBar(),
            Expanded(
              child: Stack(
                children: [
                  Observer(builder: (_) {
                    if (homeStore.error != null) {
                      return Column(
                        children: [
                          Icon(Icons.error, color: Colors.white, size: 100),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Ocorreu um erro",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      );
                    }
                    if (homeStore.showProgress) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ));
                    }
                    if (homeStore.adList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.border_clear,
                                color: Colors.white, size: 100),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Nenhum anúncio encontrado!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: homeStore.adList.length,
                      itemBuilder: (_, index) {
                        if (index < homeStore.adList.length) {
                          return AdTile(homeStore.adList[index]);
                        }

                        homeStore.loadNextPage();
                        return Container(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      },
                    );
                  }),
                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child: CreateAdButton(scrollController),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
