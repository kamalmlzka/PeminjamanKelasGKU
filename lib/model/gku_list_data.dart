class GkuListData {
  String titleTxt;
  String subTxt;
  double rating;
  int reviews;
  int kapasitas;

  GkuListData({
    required this.titleTxt,
    required this.subTxt,
    required this.reviews,
    required this.rating,
    required this.kapasitas,
  });

  Map<String, dynamic> toMap() {
    return {
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'rating': rating,
      'reviews': reviews,
      'kapasitas': kapasitas,
    };
  }

  factory GkuListData.fromMap(Map<String, dynamic> map) {
    return GkuListData(
      titleTxt: map['titleTxt'],
      subTxt: map['subTxt'],
      rating: map['rating'],
      reviews: map['reviews'],
      kapasitas: map['kapasitas'],
    );
  }

  
}
