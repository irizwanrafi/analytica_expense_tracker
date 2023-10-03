List<DataPoints> data() {
  List<DataPoints> myData = [];
  for (int i = 1; i < 10; i++) {
    myData.add(DataPoints(
        DateTime.now().add(Duration(days: i)),
        i * 100,
        i * 200,
        i * 300,
        i * 400,
        i * 500,
        i * 600,
        i * 700,
        i * 800,
        i * 900,
        i * 1000,
        i * 1100,
        i * 1200,
        i * 1300,
        i * 1400,
        i * 1500));
  }
  return myData;
}

class DataPoints {
  DataPoints(
    this.x,
    this.y1,
    this.y2,
    this.y3,
    this.y4,
    this.y5,
    this.y6,
    this.y7,
    this.y8,
    this.y9,
    this.y10,
    this.y11,
    this.y12,
    this.y13,
    this.y14,
    this.y15,
  );
  final DateTime x;
  final num y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;

  num getY(int index) {
    if (index == 0) {
      return y1;
    } else if (index == 1) {
      return y2;
    } else if (index == 2) {
      return y3;
    } else if (index == 3) {
      return y4;
    } else if (index == 4) {
      return y5;
    } else if (index == 5) {
      return y6;
    } else if (index == 6) {
      return y7;
    } else if (index == 7) {
      return y8;
    } else if (index == 8) {
      return y9;
    } else if (index == 9) {
      return y10;
    } else if (index == 10) {
      return y11;
    } else if (index == 11) {
      return y12;
    } else if (index == 12) {
      return y13;
    } else if (index == 13) {
      return y14;
    } else if (index == 14) {
      return y15;
    } else {
      return 0;
    }
  }
}
