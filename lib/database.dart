import 'package:mysql1/mysql1.dart';

class Database {
  Database._privateConstructor();

  ConnectionSettings? settings;
  MySqlConnection? conn;

  static final Database _instance = Database._privateConstructor();

  factory Database() {
    return _instance;
  }

  Future<void> getConnection(
      String url, int port, String user, String password, String db) async {
    settings = ConnectionSettings(
      host: url,
      port: port,
      user: user,
      password: password,
      db: db,
    );

    conn = await MySqlConnection.connect(settings!);
  }
}
