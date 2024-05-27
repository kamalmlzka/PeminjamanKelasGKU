class FilterData {
  FilterData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<FilterData> popularFList = <FilterData>[
    FilterData(
      titleTxt: 'Proyektor',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Air Conditioner',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Speaker & Mic',
      isSelected: true,
    ),
    FilterData(
      titleTxt: 'Whiteboard',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Wifi',
      isSelected: false,
    ),
  ];

  static List<FilterData> accomodationList = [
    FilterData(
      titleTxt: 'All',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Apartment',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Home',
      isSelected: true,
    ),
    FilterData(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
    FilterData(
      titleTxt: 'Resort',
      isSelected: false,
    ),
  ];
}
