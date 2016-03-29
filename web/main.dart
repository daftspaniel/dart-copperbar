import 'dart:html';
import 'dart:async';

class copperBar {
  int y;
  int direction = 1;
  List barcolor = new List();
  List shade = [0, 0, 1];

  copperBar(this.y, this.shade) {
    List barcolor2 = new List();
    for (int i = 1; i < 64; i++) {
      barcolor2.add([i * 4, i * 4, i * 4]);
    }
    for (int i = 1; i < 64; i++) {
      barcolor2.add([255 - i * 4, 255 - i * 4, 255 - i * 4]);
    }

    barcolor2.forEach((col) => barcolor
        .add([shade[0] * col[0], shade[1] * col[1], shade[2] * col[2]]));
  }

  draw(CanvasRenderingContext2D c2d) {
    y += direction;

    int yy = y;
    barcolor.forEach((col) {
      c2d
        ..beginPath()
        ..setFillColorRgb(col[0], col[1], col[2], 1)
        ..fillRect(0, yy, 640, 1)
        ..closePath();
      yy++;
    });

    if (y > 711 || y < -70) direction *= -1;
  }
}

CanvasRenderingContext2D c2d;
CanvasElement ca;
copperBar cbGreen = new copperBar(10, [0, 0, 1]);
copperBar cbRed = new copperBar(200, [0, 1, 0]);
copperBar cbBlue = new copperBar(400, [1, 0, 0]);
int bannerX = 10;
int bannerDirection = 1;
int bannerSpeed = 1;

void main() {
  ca = querySelector("#surface");
  c2d = ca.getContext("2d");
  cbGreen.direction = 2;
  cbBlue.direction = 3;
  new Timer.periodic(new Duration(milliseconds: 20), (timer) => update());
}

update() {
  c2d.setFillColorRgb(0, 0, 0);
  c2d.clearRect(0, 0, 640, 580);
  cbGreen.draw(c2d);
  cbRed.draw(c2d);

  String text = "Dart is AWESOME!";
  bannerX = bannerX + bannerSpeed * bannerDirection;
  int x = bannerX;
  if (x < -50 || x > 635) bannerDirection *= -1;
  int y = 220;
  c2d
    ..font = "50px Sans-serif"
    ..strokeStyle = 'black'
    ..lineWidth = 8
    ..miterLimit = 2
    ..strokeText(text, x, y)
    ..fillStyle = 'yellow'
    ..fillText(text, x, y);

  cbBlue.draw(c2d);
}
