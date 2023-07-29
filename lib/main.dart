import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// Kullanıcı Modeli
class User {
  final String username;
  final String password;
  final bool isAdmin;

  User({required this.username, required this.password, this.isAdmin = false});
}

List<User> users = [
  User(username: 'musteri', password: '123'),
  User(username: 'admin', password: 'admin123', isAdmin: true),
];

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String _username = '';
  String _password = '';
  String _errorMessage = '';
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.forward();
  }

  void _login() {
    User? user = users.firstWhereOrNull(
        (user) => user.username == _username && user.password == _password);
    if (user != null) {
      if (user.isAdmin) {
        // Yönetici girişi
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPanel()));
      } else {
        // Normal kullanıcı girişi
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserPanel()));
      }
    } else {
      setState(() {
        _errorMessage = 'Kullanıcı adı veya şifre hatalı.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Ekranı'),
        backgroundColor: Color.fromARGB(255, 121, 126, 73),
      ),
      body: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return Container(
            color: Colors.blue.shade100,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Hoşgeldiniz ',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' _AlperYuzgec ',
                      style: 
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),                        
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      decoration: InputDecoration(hintText: 'Kullanıcı Adı'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Şifre'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Giriş Yap'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Yönetici Paneli Widget'ı
class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yönetici Paneli')),
      body: Container(
        color: Colors.orange.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Yöneticiye özel menü seçeneği 1
                },
                child: Text('Yönetici Menü 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Yöneticiye özel menü seçeneği 2
                },
                child: Text('Yönetici Menü 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Yöneticiye özel menü seçeneği 3
                },
                child: Text('Yönetici Menü 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Normal Kullanıcı Paneli Widget'ı
class UserPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kullanıcı Paneli')),
      body: Container(
        color: Colors.green.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Normal kullanıcı için menü seçeneği 1
                },
                child: Text('Kullanıcı Menü 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Normal kullanıcı için menü seçeneği 2
                },
                child: Text('Kullanıcı Menü 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Normal kullanıcı için menü seçeneği 3
                },
                child: Text('Kullanıcı Menü 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ana Uygulama
void main() {
  runApp(MaterialApp(home: LoginScreen()));
}
