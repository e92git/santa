import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '85.193.83.218',
      user = 'gen_user',
      password = 'i9tbl4odk',
      db = 'default_db';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db
    );
    return await MySqlConnection.connect(settings);
  }
}