import 'package:conversor/home_page/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //depois de 3 segundos carrega a proxima pagina

    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Column(
          children: [
            Expanded(child: _getLogo()),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 40,
              width: 40,
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Versão 0.01",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  _getLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ("assets/img/image.png"),
          height: 200,
          width: 299,
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Conversor\nde\nMoedas",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
