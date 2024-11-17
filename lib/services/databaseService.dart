import 'package:fund_management/models/balanceModel.dart';
import 'package:fund_management/models/depositdbModel.dart';
import 'package:fund_management/models/transferdbModel.dart';
import 'package:fund_management/models/withdrawdbModel.dart';
import 'package:fund_management/services/transactions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseService {
 static Database? _db;
 final String tableName='depositDetails';
 final String withdrawTable='WithdrawDetails';
 final String balanceTable='balanceDetails';
 final String balanceColumn='balanceAmount';
 final String nameColumn='accName';
 final String depositAmountColumn='depAmount'; 
 final String withdrawAmountColumn='withdraw';
 final String transferTable='transferDetails';
 final String transferAmountColumn='tranAmount';
 final String recNameColumn='recAccName';  
 
 static final DatabaseService databaseservice = DatabaseService._constructor(); 
 DatabaseService._constructor();

 Future<Database> get database async{
  if (_db!=null){
    return _db!;
  }
  else{
    _db=await getDatabase();
    return _db!;
  }
 }


 

 Future<Database> getDatabase() async{
   final databasePath=await getDatabasesPath();
   final databaseDir= join(databasePath,"fundmgt_db.db");
   final database=openDatabase(databaseDir,
   version: 6,
   onUpgrade: (Database db, int oldVersion, int newVersion) async {
        
        for (int version = oldVersion; version < newVersion; version++) {
          await _performDBUpgrade(db, version + 1);
        }
      }, 
   onCreate:( Database db, int newVersion) async {
        //
        //Start from version 1 to current version and create DB
        for (int version = 0; version < newVersion; version++) {
          await _performDBUpgrade(db, version + 1);
        }
      },);
    
   

   return database;
 }
 Future<void> _performDBUpgrade(Database db, int upgradeToVersion) async {
    switch (upgradeToVersion) {
      //Upgrade to V1 (initial creation)
      case 1:
        await _dbUpdatesVersion_1(db);
        break;

      //Upgrades for V2
      case 2:
        await _dbUpdatesVersion_2(db);
        break;
    case 3:
        await _dbUpdatesVersion_3(db);
        break;  
    case 4:
    await _dbUpdatesVersion_4(db);
    break;
    case 5:
    await _dbUpdatesVersion_5(db);
    break;
    case 6:
    await _dbUpdatesVersion_6(db);
    break;

    }
  }

  ///Database updates for Version 1 (initial creation)
   Future<void> _dbUpdatesVersion_1(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
  }
   Future<void> _dbUpdatesVersion_2(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
  }
   Future<void> _dbUpdatesVersion_3(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
  }
   Future<void> _dbUpdatesVersion_4(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
  }
 Future<void> _dbUpdatesVersion_5(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
    await db.execute('''CREATE TABLE $withdrawTable(
      $nameColumn TEXT ,
      $withdrawAmountColumn INTEGER
      )
''');
  }
Future<void> _dbUpdatesVersion_6(Database db) async {
      await db.execute('DROP TABLE IF EXISTS $tableName');
      await db.execute('''CREATE TABLE $tableName(
      $nameColumn TEXT ,
      $depositAmountColumn INTEGER
      )
''');
    await db.execute('DROP TABLE IF EXISTS $withdrawTable');
    await db.execute('''CREATE TABLE $withdrawTable(
      $nameColumn TEXT ,
      $withdrawAmountColumn INTEGER
      )
''');
 await db.execute('''CREATE TABLE $transferTable(
      $nameColumn TEXT ,
      $recNameColumn TEXT,
      $transferAmountColumn INTEGER
      )
''');

    await db.execute('''CREATE TABLE $balanceTable(
      $nameColumn TEXT PRIMARY KEY,
      $balanceColumn INTEGER
      )
''');
  }      
 void insertDeposit(String email, int depAmount)async{
  final db= await database;
  await db.insert(tableName, {
    nameColumn:email,
    depositAmountColumn:depAmount
    
  });
  
 }
 void insertWithdrawal(String email, int withdrawAmount)async{
  final db= await database;
  await db.insert(withdrawTable, {
    nameColumn:email,
    withdrawAmountColumn:withdrawAmount
    
  });
  
 }
  void insertTransfer(String email, String recAccName,int transferAmount)async{
  final db= await database;
  await db.insert(transferTable, {
    nameColumn:email,
    recNameColumn:recAccName,
    transferAmountColumn:transferAmount
    
  });
  
 }
  void insertBalance(String email, int balance)async{
  final db= await database;
  await db.insert(balanceTable, {
    nameColumn:email,
    balanceColumn:balance
  });
  
  }
void updateBalance(String email,int amount,String operation,Function changeState) async {
  int prevbalance=0;
  int finalbalance=0;
  List<Balancemodel> balance=await getBalanceDetails(email);
  for (Balancemodel index in balance){
   prevbalance=index.balanceAmount;
  }
  if (operation=="deposit"){
   finalbalance=prevbalance+amount;
  }
  if (operation=="withdraw"){
   finalbalance=prevbalance-amount;
  }
  if (operation=="transfer"){
   finalbalance=prevbalance-amount;
  }
  final db=await database;
  await db.update(balanceTable,{
    nameColumn:email,
    balanceColumn:finalbalance
  },
  where: "accName= ?",
  whereArgs:[email]
 
  );
changeState();  
}      

Future<List<Depositdbmodel>> getDepDetails(String email)async{
   final db=await database;
   final data = await db.query(tableName,
   where: "accName= ?",
   whereArgs: [email],);
   
   List<Depositdbmodel> deposits= data.map((e) =>Depositdbmodel(accName: e["accName"] as String, depAmount:e["depAmount"] as int,) ).toList();
   return deposits;
} 
Future<List<Withdrawdbmodel>> getWithdrawDetails(String email )async{
   final db=await database;
   final data = await db.query(withdrawTable,
   where: "accName= ?",
   whereArgs: [email],
   );
   
   List<Withdrawdbmodel> withdrawals= data.map((e) =>Withdrawdbmodel(accName: e["accName"] as String, withdrawAmount:e["withdraw"] as int,) ).toList();
   return withdrawals;
} 
Future<List<Transferdbmodel>> getTransferDetails(String email)async{
   final db=await database;
   final data = await db.query(transferTable ,
   where: "accName= ?",
   whereArgs: [email],
   );
   
   
   List<Transferdbmodel> transfers= data.map((e) =>Transferdbmodel(accName: e["accName"] as String,recName: e["recAccName"] as String ,tranAmount:e['tranAmount'] as int,) ).toList();
   return transfers;
} 
Future<List<Balancemodel>> getBalanceDetails(String email)async{
   final db=await database;
   final data = await db.query(balanceTable ,
   where: "accName= ?",
   whereArgs: [email],
   );
   
   
   List<Balancemodel> transfers= data.map((e) =>Balancemodel(accName: e["accName"] as String, balanceAmount:e['balanceAmount'] as int,) ).toList();
   for (Balancemodel index in transfers){
     print(index.balanceAmount);
   }
   return transfers;
} 

}
