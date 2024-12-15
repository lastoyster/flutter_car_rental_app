final List<Map<String, dynamic>> carList = [
  {
    'image': 'assets/car1.png',
    'title': 'Supercar',
    'desc': '2 vehicles available'
  },
  {'image': 'assets/car2.png', 'title': 'SUV', 'desc': '5 vehicles available'},
  {
    'image': 'assets/car3.png',
    'title': 'Compact',
    'desc': '3 vehicles available'
  }
];

final List<Map<String, dynamic>> carList1 = [
  {
    'image': 'assets/car1.png',
    'title': 'Supercar',
    'reg': 'REGNOXXX',
    'avail': 'Available @ 2:00',
    "lat": "--ENTER LATITUDE HERE IN DOUBLE TYPE--",
    "long": "--ENTER LONGITUDE HERE IN DOUBLE TYPE--"
  },
  {
    'image': 'assets/car2.png',
    'title': 'SUV',
    'reg': 'REGNOZZZ',
    'avail': 'Available Now',
    "lat": "--ENTER LATITUDE HERE IN DOUBLE TYPE--",
    "long": "--ENTER LONGITUDE HERE IN DOUBLE TYPE--"
  },
  {
    'image': 'assets/car3.png',
    'title': 'Compact',
    'reg': 'REGNOYYY',
    'avail': 'Available @ 12:00',
    "lat": "--ENTER LATITUDE HERE IN DOUBLE TYPE--",
    "long": "--ENTER LONGITUDE HERE IN DOUBLE TYPE--"
  }
];

const String FONT_FAMILY = 'Poppins';
const String APP_TITLE = 'Car Booking App';
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const String googleAPIKey = "ENTER KEY HERE";
const String MAP_STYLE = 'assets/map_style.txt';
const String SOURCE_ICON = 'assets/driving_pin.png';
const String DEST_ICON = 'assets/destination_map_marker.png';