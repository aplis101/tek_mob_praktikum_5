import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Praktikum5App());
}

class Praktikum5App extends StatelessWidget {
  const Praktikum5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 5',
      // تطبيق خط Poppins على التطبيق بالكامل
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainScreen(), // الشاشة الرئيسية التي تحتوي على شريط التنقل
    );
  }
}

// ==========================================
// الشاشة الرئيسية (تحتوي على BottomNavigationBar)
// ==========================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // متغير لحفظ رقم الصفحة المحددة

  // قائمة تحتوي على الصفحتين (صفحة البروفايل، وصفحة الحاسبة التي سنصنعها لاحقاً)
  final List<Widget> _pages = [const ProfilePage(), const CalculatorPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // عرض الصفحة بناءً على الزر المضغوط
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // استخدام setState لتحديث الشاشة عند تغيير الصفحة
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// المهمة 1: صفحة بطاقة التعريف (Profile Card)
// ==========================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // لجعل الكارد بحجم المحتوى فقط
              children: [
                // 1. الصورة الشخصية
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                ),
                const SizedBox(height: 16),

                // 2. الاسم
                const Text(
                  'Mohammed Rashed', // اكتب اسمك هنا
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // 3. التخصص
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Sistem Informasi',
                    style: TextStyle(
                      color: Colors.indigo[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Divider(),
                const SizedBox(height: 8),

                // 4. الوصف / الحالة
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.work_outline, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Flutter Developer Beginner',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// المهمة 2: صفحة الآلة الحاسبة (سنكملها في الخطوة القادمة)
// ==========================================
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // 1. وحدات التحكم لالتقاط الأرقام المكتوبة في الحقول
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  // 2. متغير الـ State الذي سيتغير ليحمل النتيجة أو رسالة الخطأ
  String _hasil = 'Hasil perhitungan akan muncul di sini';

  // 3. دالة الحساب والتحقق (الدماغ المفكر للحاسبة)
  void _hitung(String operasi) {
    String input1 = _angka1Controller.text;
    String input2 = _angka2Controller.text;

    // الشرط الإجباري الأول: التحقق من الحقول الفارغة (Validasi Input Kosong)
    if (input1.isEmpty || input2.isEmpty) {
      setState(() {
        _hasil = 'Error: Input tidak boleh kosong!';
      });
      return; // نوقف التنفيذ هنا
    }

    // تحويل النص إلى أرقام عشرية
    double angka1 = double.parse(input1);
    double angka2 = double.parse(input2);
    double hasilHitung = 0;

    // إجراء العملية الحسابية
    if (operasi == '+') {
      hasilHitung = angka1 + angka2;
    } else if (operasi == '-') {
      hasilHitung = angka1 - angka2;
    } else if (operasi == 'x') {
      hasilHitung = angka1 * angka2;
    } else if (operasi == '/') {
      // الشرط الإجباري الثاني: منع القسمة على صفر (Pembagian dengan nol)
      if (angka2 == 0) {
        setState(() {
          _hasil = 'Error: Tidak bisa dibagi dengan nol (0)!';
        });
        return; // نوقف التنفيذ
      }
      hasilHitung = angka1 / angka2;
    }

    // 4. دالة setState لتحديث الشاشة بالنتيجة النهائية
    setState(() {
      // إزالة الأصفار العشرية الزائدة إذا كان الرقم صحيحاً لتجميل النتيجة
      if (hasilHitung == hasilHitung.toInt()) {
        _hasil = 'Hasil: ${hasilHitung.toInt()}';
      } else {
        _hasil = 'Hasil: ${hasilHitung.toStringAsFixed(2)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      // SingleChildScrollView يمنع خطأ الشاشة عند ظهور الكيبورد
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // حقل الرقم الأول
                      TextField(
                        controller: _angka1Controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Angka Pertama',
                          prefixIcon: const Icon(Icons.looks_one, color: Colors.indigo),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // حقل الرقم الثاني
                      TextField(
                        controller: _angka2Controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Angka Kedua',
                          prefixIcon: const Icon(Icons.looks_two, color: Colors.indigo),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // أزرار العمليات الحسابية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOperationButton('+', Colors.green),
                  _buildOperationButton('-', Colors.orange),
                  _buildOperationButton('x', Colors.blue),
                  _buildOperationButton('/', Colors.red),
                ],
              ),
              const SizedBox(height: 32),
              
              // عرض النتيجة المتغيرة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _hasil.contains('Error') ? Colors.red[50] : Colors.indigo[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _hasil.contains('Error') ? Colors.red : Colors.indigo,
                    width: 2,
                  ),
                ),
                child: Text(
                  _hasil,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _hasil.contains('Error') ? Colors.red : Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء الأزرار بشكل مرتب وتقليل تكرار الكود
  Widget _buildOperationButton(String op, Color color) {
    return ElevatedButton(
      onPressed: () => _hitung(op),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        elevation: 4,
      ),
      child: Text(op == '/' ? '÷' : op, style: const TextStyle(fontSize: 24)),
    );
  }
}