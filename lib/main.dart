import 'package:ccd/DataLayer/Aimodels_path.dart';
import 'package:ccd/services/AI%20Services/tfliteHelper.dart';
import 'package:ccd/views/credit_cards_screen.dart';
import 'package:ccd/views/login_page.dart';
import 'package:ccd/views/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import Screens
import 'views/dashboard_page.dart';
import 'views/credit_cards_page.dart';
import 'views/transactions_screen.dart';
import 'views/realtime_check_screen.dart';
import 'views/fraud_alert_screen.dart';
import 'views/profile_screen.dart';
import 'views/generate_report_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");
  String path;
  for (var i = 0; i < modelPaths.length; i++) {
    path = modelPaths[i];
    await FraudDetector().loadModel(path);
  }

  List<double> transaction = [0.5, -1.2, 300.0, 0.0, 1.0];
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Credit Card Fraud Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/dashboard', page: () => const DashboardPage()),
        GetPage(name: '/addcards', page: () => const CreditCardsPage()),
        GetPage(
            name: '/freezeunfreeze', page: () => const FreezeUnfreezeScreen()),
        GetPage(name: '/transactions', page: () => const TransactionsScreen()),
        GetPage(
            name: '/realtimecheck', page: () => const RealtimeCheckScreen()),
        GetPage(name: '/fraudalerts', page: () => const FraudAlertScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(
            name: '/generate_report', page: () => const GenerateReportPage()),
      ],
    );
  }
}
