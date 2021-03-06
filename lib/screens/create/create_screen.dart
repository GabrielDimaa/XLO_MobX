import 'package:XLO_mobX/components/custom_drawer/custom_drawer.dart';
import 'package:XLO_mobX/components/error_box.dart';
import 'package:XLO_mobX/screens/create/components/category_field.dart';
import 'package:XLO_mobX/screens/create/components/cep_field.dart';
import 'package:XLO_mobX/screens/create/components/hide_phone_field.dart';
import 'package:XLO_mobX/screens/create/components/images_field.dart';
import 'package:XLO_mobX/stores/create_store.dart';
import 'package:XLO_mobX/stores/page_store.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class CreateScreen extends StatefulWidget {
	@override
	_CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

	final CreateStore createStore = CreateStore();

	@override
	void initState() { 
		super.initState();

		when((_) => createStore.savedAd == true, () {
			GetIt.I<PageStore>().setPage(0);
		});
	}

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
			body: Container(
				alignment: Alignment.center,
				child: SingleChildScrollView(
					child: Observer(builder: (_) {
						if(createStore.loading) {
							return Container(
								padding: const EdgeInsets.all(16),
								color: Colors.white,
								child: Column(
									children: [
										Text("Salvando Anúncio",
											style: TextStyle(
												fontSize: 16,
												color: Colors.purple
											)
										),
										const SizedBox(height: 16),
										CircularProgressIndicator(
											valueColor: AlwaysStoppedAnimation(Colors.purple)
										)
									]
								)
							);
						} else {
							return Card(
								clipBehavior: Clip.antiAlias,
								margin: const EdgeInsets.symmetric(horizontal: 16),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(16)
								),
								elevation: 8,
								child: Column(
									mainAxisSize: MainAxisSize.min,
									crossAxisAlignment: CrossAxisAlignment.stretch,
									children: [
										ImagesField(createStore),
										Observer(builder: (_) {
										return TextFormField(
												decoration: InputDecoration(
													labelText: "Título *",
													labelStyle: labelStyle,
													contentPadding: contentPadding,
													errorText: createStore.titleError
												),
												onChanged: createStore.setTitle
											);
										}),
										Observer(builder: (_) {
										return TextFormField(
												decoration: InputDecoration(
													labelText: "Descrição *",
													labelStyle: labelStyle,
													contentPadding: contentPadding,
													errorText: createStore.descriptionError
												),
												onChanged: createStore.setDescription,
												maxLines: null,
											);
										}),
										CategoryField(createStore),
										CepField(createStore),
										Observer(builder: (_) {
										return TextFormField(
												decoration: InputDecoration(
													labelText: "Preço *",
													labelStyle: labelStyle,
													contentPadding: contentPadding,
													prefixText: 'R\$ ',
													errorText: createStore.priceError
												),
												onChanged: createStore.setPrice,
												keyboardType: TextInputType.number,
												inputFormatters: [
													FilteringTextInputFormatter.digitsOnly,
													RealInputFormatter(centavos: true)
												]
											);
										}),
										HidePhoneField(),
										Observer(builder: (_) {
										   return ErrorBox(message: createStore.error);
										}),
										Observer(builder: (_) {
										return SizedBox(
												height: 50,
												child: GestureDetector(
													onTap: createStore.invalidSendPressed,
													child: RaisedButton(
														child: Text("Enviar",
															style: TextStyle(
																fontSize: 18
															)
														),
														textColor: Colors.white,
														color: Colors.orange,
														disabledColor: Colors.orange.withAlpha(120),
														materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
														onPressed: createStore.sendPressed
													),
												),
											);
										})
									]
								)
							);
						}
					})
				)
			)
		);
	}
}