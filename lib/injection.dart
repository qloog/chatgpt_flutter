import 'package:chatgpt/data/database.dart';
import 'package:chatgpt/services/chatgpt.dart';
import 'package:chatgpt/services/local_store.dart';
import 'package:chatgpt/services/record.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

final chatgpt = ChatGPTService();

final logger = Logger(level: kDebugMode ? Level.verbose : Level.info);

const uuid = Uuid();

late AppDatabase db;

setupDatabase() async {
  db = await initDatabase();
}

final recorder = RecordService();

final localStorage = LocalStoreService();
