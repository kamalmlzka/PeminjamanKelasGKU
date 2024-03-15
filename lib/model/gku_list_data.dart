class GkuListData {
  GkuListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.reviews = 80,
    this.rating = 4.5,
    this.kapasitas = 40,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double rating;
  int reviews;
  int kapasitas;

  static List<GkuListData> gkuList = <GkuListData>[
    GkuListData(
      imagePath: 'https://i.ibb.co/tc3VN4M/Auditorium.jpg',
      titleTxt: 'KU3.01.01',
      subTxt: 'GKU',
      reviews: 80,
      rating: 4.4,
      kapasitas: 40,
    ),
    GkuListData(
      imagePath: 'https://i.ibb.co/tc3VN4M/Auditorium.jpg',
      titleTxt: 'KU3.01.02',
      subTxt: 'GKU',
      reviews: 74,
      rating: 4.5,
      kapasitas: 40,
    ),
    GkuListData(
      imagePath: 'https://i.ibb.co/tc3VN4M/Auditorium.jpg',
      titleTxt: 'KU3.01.03',
      subTxt: 'GKU',
      reviews: 62,
      rating: 4.0,
      kapasitas: 40,
    ),
    GkuListData(
      imagePath: 'https://i.ibb.co/tc3VN4M/Auditorium.jpg',
      titleTxt: 'KU3.01.04',
      subTxt: 'GKU',
      reviews: 90,
      rating: 4.4,
      kapasitas: 40,
    ),
    GkuListData(
      imagePath: 'https://i.ibb.co/tc3VN4M/Auditorium.jpg',
      titleTxt: 'KU3.01.05',
      subTxt: 'GKU',
      reviews: 240,
      rating: 4.5,
      kapasitas: 40,
    ),
  ];
}
