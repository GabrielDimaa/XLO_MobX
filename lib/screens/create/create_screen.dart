import 'package:XLO_mobX/components/custom_drawer/custom_drawer.dart';
import 'package:XLO_mobX/screens/create/components/category_field.dart';
import 'package:XLO_mobX/screens/create/components/cep_field.dart';
import 'package:XLO_mobX/screens/create/components/images_field.dart';
import 'package:XLO_mobX/stores/create_store.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateScreen extends StatelessWidget {

	final CreateStore createStore = CreateStore();

	@override
	Widget build(BuildContext context) {

		final labelStyle = TextStyle(
			fontWeight: FontWeight.w800,
			color: Colors.grey,
			fontSize: 18
		);

		final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

		return Scaffold(
			appBar: AppBar(
				title: Text("Criar Anúncio"),
				centerTitle: true
			),
			drawer: CustomDrawer(),
			body: Center(
				child: Card(
					clipBehavior: Clip.antiAlias,
					margin: const EdgeInsets.symmetric(horizontal: 16),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(16)
					),
					elevation: 8,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							ImagesField(createStore),
							TextFormField(
								decoration: InputDecoration(
									labelText: "Título *",
									labelStyle: labelStyle,
									contentPadding: contentPadding
								),
							),
							TextFormField(
								decoration: InputDecoration(
									labelText: "Descrição *",
									labelStyle: labelStyle,
									contentPadding: contentPadding
								),
								maxLines: null,
							),
							CategoryField(createStore),
							Divider(height: 0.1, color: Colors.grey[800]),
							CepField(),
							TextFormField(
								decoration: InputDecoration(
									labelText: "Preço *",
									labelStyle: labelStyle,
									contentPadding: contentPadding,
									prefixText: 'R\$ ',
								),
								keyboardType: TextInputType.number,
								inputFormatters: [
									FilteringTextInputFormatter.digitsOnly,
									RealInputFormatter(centavos: true)
								]
							)
						]
					)
				)
			)
		);
	}
}