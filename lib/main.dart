import 'package:flutter/material.dart';
import 'package:paint_experiments/home.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
    ));
//void main() => runApp(MaterialApp(
//      home: MaterialApp(home: Home()),
//      debugShowCheckedModeBanner: false,
//    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _points = <Offset>[];
  bool isClipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isClipped == false
          ? Stack(
              children: [
//          ClipPath(
//            clipper: MyClipper(offsets: _points),
//            child:
                Image.network(
                  "https://picsum.photos/id/1/200/300",
                  fit: BoxFit.contain,
                  height: double.infinity,
                  width: double.infinity,
                ),
//          ),
                Container(
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
//                    details.
                      setState(() {
                        RenderBox object = context.findRenderObject();
                        Offset _localPosition =
                            object.globalToLocal(details.globalPosition);
                        _points = List.from(_points)..add(_localPosition);
//                  _points.add(details.globalPosition);
                      });
                    },
                    onPanEnd: (DragEndDetails details) => _points.add(null),
                    child: CustomPaint(
                      painter: MyPainter(points: _points),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ],
            )
          : ClipPath(
              clipper: MyClipper(
                offsets: _points,
              ),
              child: Image.network(
                "https://picsum.photos/id/1/200/300",
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            isClipped = !isClipped;
          });
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  List<Offset> points;

  MyPainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => oldDelegate.points != points;
}

class MyClipper extends CustomClipper<Path> {
  List<Offset> offsets;

  MyClipper({this.offsets});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(offsets.first.dx, offsets.first.dy);
    if (offsets != null && offsets.isNotEmpty) {
      for (int i = 0; i < offsets.length - 1; i++) {
        if (offsets[i] != null && offsets[i + 1] != null) {
          path.lineTo(offsets[i].dx, offsets[i + 1].dy);
        }
      }
      return path;
    }
    return null;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
