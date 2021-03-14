import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          child: Image.network(
            "https://picsum.photos/id/1/200/300",
        fit: BoxFit.cover,
          ),
          clipper: MyClipper(),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    print("-----size: $size");
    /*
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height);
    path.close(); */
    return null;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
