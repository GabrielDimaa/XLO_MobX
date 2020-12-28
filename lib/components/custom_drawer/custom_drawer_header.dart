import 'package:XLO_mobX/screens/login/login_screen.dart';
import 'package:XLO_mobX/stores/page_store.dart';
import 'package:XLO_mobX/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CustomDrawerHeader extends StatelessWidget {

	final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () {
				Navigator.of(context).pop();
				
				if(userManagerStore.isLoggedIn) {
					GetIt.I<PageStore>().setPage(4);
				} else {
					Navigator.of(context).push(
						MaterialPageRoute(builder: (_) => LoginScreen())
					);
				}
			},
			child: Container(
				color: Colors.purple,
				height: 95,
				padding: const EdgeInsets.symmetric(horizontal: 20),
				child: Row(
					children: [
						Icon(Icons.person, color: Colors.white, size: 35),
						SizedBox(width: 20),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Text(userManagerStore.isLoggedIn ?
										userManagerStore.user.name :
										"Acesse sua Conta Agora!",
										style: TextStyle(
											color: Colors.white,
											fontSize: 16,
											fontWeight: FontWeight.w500
										)
									),
									Text(userManagerStore.isLoggedIn ?
										userManagerStore.user.email :
										"Clique aqui",
										style: TextStyle(
											color: Colors.white,
											fontSize: 14,
											fontWeight: FontWeight.w400
										)
									)
								]
							)
						)
					]
				)
			),
		);
	}
}