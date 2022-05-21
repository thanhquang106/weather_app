import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  String dat = DateFormat('MMM d, yyyy | EEEE').format(DateTime.now());// prints Tuesday, 10 Dec, 2019
  TimeOfDay _timeOfDay = TimeOfDay.now();
   Map<String, dynamic> map = {};

  late final dref = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;

  String temp = '';
  String light = '';
  String pres = '';
  String pressure = '';
  String rain = '';

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    await dref.onValue.listen((DatabaseEvent event) {
      var snap = event.snapshot;
      if(mounted){
        setState((){
          map = Map<String, dynamic>.from(snap.value as Map<dynamic, dynamic>);
          temp = map['temp'];
          light = map['light'];
          pres = map['pres at sealevel'];
          pressure = map['pressure'];
          rain = map['rain'];
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print('Menu Clicked!'),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/sunny.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              SizedBox(height: 120),
                              Text(
                                'Đà Nẵng',
                                style: GoogleFonts.lato(
                                  fontSize:35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${_timeOfDay.hour}:${_timeOfDay.minute}:${dat}",
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              temp +'\u2103',
                              style: GoogleFonts.lato(
                                fontSize:85,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/moon.svg',
                                  width: 34,
                                  height: 34,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Light',
                                  style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'pres at sealevel',
                                  style: GoogleFonts.lato(
                                    fontSize:15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  pres,
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  'Pa',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.greenAccent,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'pressure',
                                  style: GoogleFonts.lato(
                                    fontSize:15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  pressure,
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  'Pa',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.greenAccent,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Rain',
                                  style: GoogleFonts.lato(
                                    fontSize:15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  rain,
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.redAccent,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Light',
                                  style: GoogleFonts.lato(
                                    fontSize:15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  light,
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'lux',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.redAccent,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
