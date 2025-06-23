import 'package:flutter/material.dart';
import '../models/fishing_entry.dart';
import '../services/local_db_service.dart';

class FishingForm extends StatefulWidget {
  @override
  State<FishingForm> createState() => _FishingFormState();
}

class _FishingFormState extends State<FishingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _boatController = TextEditingController();
  final _quantityController = TextEditingController();
  final _inseminatedController = TextEditingController();
  List<bool> _selectedCategories = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nom et prénom du pêcheur'),
            validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
          ),
          TextFormField(
            controller: _boatController,
            decoration: InputDecoration(labelText: 'Nom du bateau'),
            validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
          ),
          SizedBox(height: 16),
          Text('Catégories d\'huîtres :'),
          Wrap(
            spacing: 10,
            children: List.generate(4, (i) {
              return FilterChip(
                label: Text('Catégorie $i'),
                selected: _selectedCategories[i],
                onSelected: (selected) {
                  setState(() {
                    _selectedCategories[i] = selected;
                  });
                },
              );
            }),
          ),
          TextFormField(
            controller: _quantityController,
            decoration: InputDecoration(labelText: 'Quantité d\'huîtres pêchées'),
            keyboardType: TextInputType.number,
            validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
          ),
          TextFormField(
            controller: _inseminatedController,
            decoration: InputDecoration(labelText: 'Huîtres fécondées'),
            keyboardType: TextInputType.number,
            validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Enregistrer'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final entry = FishingEntry(
                  fishermanName: _nameController.text,
                  boatName: _boatController.text,
                  date: DateTime.now(),
                  categories: List.generate(4, (i) => i).where((i) => _selectedCategories[i]).toList(),
                  quantity: int.parse(_quantityController.text),
                  inseminated: int.parse(_inseminatedController.text),
                );
                await LocalDbService.insertEntry(entry);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donnée enregistrée localement')));
                _formKey.currentState!.reset();
                setState(() => _selectedCategories = [false, false, false, false]);
              }
            },
          ),
        ],
      ),
    );
  }
}