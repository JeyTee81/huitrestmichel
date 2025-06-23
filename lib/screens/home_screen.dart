import 'package:flutter/material.dart';
import '../widgets/fishing_form.dart';
import '../services/sync_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accueil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenue sur l\'application de pêche !'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Saisir une pêche'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text('Saisie de pêche')),
                    body: FishingForm(),
                  ),
                ));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Synchroniser avec le serveur'),
              onPressed: () async {
                await SyncService.syncEntries();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Synchronisation terminée')));
              },
            ),
          ],
        ),
      ),
    );
  }
}