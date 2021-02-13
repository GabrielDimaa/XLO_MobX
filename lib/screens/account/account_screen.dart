import 'package:XLO_mobX/components/custom_drawer/custom_drawer.dart';
import 'package:XLO_mobX/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Conta"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Observer(builder: (_) {
                            return Text(
                              GetIt.I<UserManagerStore>().user.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple,
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          }),
                          Text(
                            GetIt.I<UserManagerStore>().user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        textColor: Colors.purple,
                        onPressed: () {},
                        child: Text("EDITAR"),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Meus Anúncios",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  "Favoritos",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
