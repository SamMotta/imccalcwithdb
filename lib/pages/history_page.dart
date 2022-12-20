import 'package:flutter/material.dart';
import 'package:imccalc/Repositories/repository.imc.dart';
import 'package:imccalc/models/model.imc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  IMCRepo imcRepo = IMCRepo();
  var history = <IMCModel>[];

  void getHistory() async {
    history = await imcRepo.read();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico")),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        itemCount: history.length,
        itemBuilder: (context, index) {
          IMCModel hist = history[index];
          return Dismissible(
            key: Key(hist.id.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              padding: const EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            onDismissed: (direction) {
              imcRepo.delete(hist);
              getHistory();
            },
            child: Column(
              children: [
                Text(
                  "Massa: ${hist.mass}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  "Altura: ${hist.height}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  "IMC: ${hist.imc}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  hist.classification,
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.9,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
