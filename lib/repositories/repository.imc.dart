import 'package:imccalc/Repositories/SQLite/database.dart';
import 'package:imccalc/models/model.imc.dart';

class IMCRepo {
  Future<List<IMCModel>> read() async {
    var db = await SQLiteDataBase().getDatabase();
    List<IMCModel> history = [];

    var result = await db.rawQuery('SELECT * FROM history');

    for (var e in result) {
      history.add(IMCModel(
        int.parse(e["id"].toString()),
        double.parse(e["mass"].toString()),
        double.parse(e["height"].toString()),
        e["classification"].toString(),
      ));
    }

    return history;
  }

  Future<void> create(IMCModel history) async {
    var db = await SQLiteDataBase().getDatabase();

    db.rawInsert('INSERT INTO history(mass, height, classification) VALUES(?,?,?)', [history.mass, history.height, history.classification]);
  }
  Future<void> delete(IMCModel history) async {
    var db = await SQLiteDataBase().getDatabase();

    db.rawDelete('DELETE FROM history WHERE id = ?', [history.id]);
  }


}
