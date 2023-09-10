import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Weather? weather;
  final openWeather = WeatherFactory('7f6efd14a7771ec6078f02b79ab944d4');
  String cityName = '';
  bool isLoading = false;

  getWeatherInfo() async {
    try {
      isLoading = true;
      setState(() {});
      weather = await openWeather.currentWeatherByCityName(cityName);
      isLoading = false;
      setState(() {});
    } catch (err) {
      // if(err. == 404){

      // }
      print('error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        title: Text('Search Weather App'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    cityName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        getWeatherInfo();
                      });
                    },
                    icon: Icon(CupertinoIcons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: weather != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather!.temperature!.celsius!.round()} ℃',
                          style: GoogleFonts.breeSerif(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${weather!.weatherDescription}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
