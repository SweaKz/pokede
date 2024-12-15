import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/filter_bloc.dart';
import '../bloc/filter_event.dart';
import '../model/filter_model.dart';

class CustomFilterPage extends StatefulWidget {
  const CustomFilterPage({super.key});

  @override
  _CustomFilterPageState createState() => _CustomFilterPageState();
}

class _CustomFilterPageState extends State<CustomFilterPage> {
  final TextEditingController nameController = TextEditingController();
  String? selectedType1;
  String? selectedType2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un filtre personnalisé")),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nom du filtre"),
          ),
          DropdownButton<String>(
            hint: const Text("Type 1"),
            value: selectedType1,
            items: ["Plante", "Poison", "Feu"].map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) => setState(() => selectedType1 = value),
          ),
          ElevatedButton(
            onPressed: () {
              final customFilter = FilterModel(
                name: nameController.text,
                backgroundImage: "",
                type1: selectedType1,
                type2: selectedType2,
              );
              context.read<FilterBloc>().add(ApplyFilter(customFilter));
              Navigator.pop(context);
            },
            child: const Text("Appliquer le filtre"),
          ),
        ],
      ),
    );
  }
}
