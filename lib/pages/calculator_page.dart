import 'package:flutter/material.dart';
import 'package:imccalc/Repositories/repository.imc.dart';
import 'package:imccalc/models/model.imc.dart';
import 'package:imccalc/pages/history_page.dart';

class IMCCalculatorPage extends StatefulWidget {
  const IMCCalculatorPage({super.key});

  @override
  State<IMCCalculatorPage> createState() => IMCCalculatorPageState();
}

class IMCCalculatorPageState extends State<IMCCalculatorPage> {
  TextEditingController massController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  IMCRepo imcRepo = IMCRepo();
  IMCModel imcModel = IMCModel.empty();

  void _calculateImc() {
    String heightString = heightController.text.replaceAll(",", "");
    imcModel.height = double.tryParse(heightString) ?? 0;

    String massString = massController.text.replaceAll(",", "");
    imcModel.mass = double.tryParse(massString) ?? 0;

    if (massController.text.isNotEmpty && massController.text.isNotEmpty) {
      imcRepo.create(imcModel);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.only(bottom: 8),
              child: const DrawerHeader(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Calculadora IMC",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IMCCalculatorPage(),));
              },
              child: const ListTile(
                leading: Icon(Icons.calculate),
                title: Text("Calculadora"),
              ),
            ),
            const Divider(color: Colors.black, thickness: 0.8),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage(),));
              },
              child: const ListTile(
                leading: Icon(Icons.history),
                title: Text("Histórico"),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Digite sua massa:', style: TextStyle(fontSize: 18)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: TextField(
                cursorColor: Colors.orange,
                controller: massController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "56.4",
                    hintStyle: TextStyle(color: Colors.black26)),
                keyboardType: TextInputType.number,
              ),
            ),
            const Text('Digite sua altura:', style: TextStyle(fontSize: 18)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              child: TextField(
                cursorColor: Colors.orange,
                controller: heightController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "1.72",
                    hintStyle: TextStyle(color: Colors.black26)),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextButton.icon(
                onPressed: _calculateImc,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                ),
                label: const Text(
                  "Calcular IMC",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.calculate, color: Colors.white),
              ),
            ),
            Container(
              child: imcModel.imc > 0
                  ? Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                            child: Text(imcModel.classification,
                                style: const TextStyle(fontSize: 26))),
                        Text(imcModel.imc.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 24)),
                      ],
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
