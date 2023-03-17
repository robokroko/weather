import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/bloc/gps/gps_bloc.dart';
import 'package:weather/components/basic_widgets/data_container_card.dart';
import 'package:weather/components/basic_widgets/pop_up.dart';
import 'package:weather/utils/constans.dart' as constans;
import 'package:weather/models/open_weather_data.dart';
import 'package:weather/providers/api_provider.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  bool? _isEnabled;
  @override
  void initState() {
    super.initState();
    _isEnabled = context.read<GpsBloc>().state.isGpsAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 15, 14, 49), Color.fromARGB(255, 44, 43, 73)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text('Add Location'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DataContainerCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add Current Position',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'You can use your current position to query weather data. To do this, you need to turn on location on your device.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enable location',
                              style: TextStyle(
                                color: constans.appYellow,
                                fontSize: 14.0,
                              ),
                            ),
                            Switch(
                              value: _isEnabled!,
                              onChanged: (bool value) async {
                                if (value) {
                                  _isEnabled = !_isEnabled!;
                                  setState(() {});
                                  try {
                                    context.read<GpsBloc>().add(ChangeGpsStateToTurnedOn());
                                    var location = await ApiProvider().getLocation();
                                    if (mounted) {
                                      Navigator.pop(
                                        context,
                                        Coord(lon: location.longitude, lat: location.latitude),
                                      );
                                    }
                                  } catch (e) {
                                    PopUpDialogs.openAlertDialog(
                                        context: context, message: e.toString(), title: 'Error');
                                    debugPrint(e.toString());
                                  }
                                } else if (!value) {
                                  _isEnabled = !_isEnabled!;
                                  setState(() {});
                                  try {
                                    context.read<GpsBloc>().add(ChangeGpsStateToTurnedOff());
                                  } catch (e) {
                                    PopUpDialogs.openAlertDialog(
                                        context: context, message: e.toString(), title: 'Error');
                                    debugPrint(e.toString());
                                  }
                                }
                              },
                              activeColor: constans.appYellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DataContainerCard(
                    child: BlocBuilder<GpsBloc, GpsState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add City',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            context.read<GpsBloc>().state.isGpsAllowed == false
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'You can enter the name of a city to query the weather data. You need an active internet connection for this.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          controller: _cityTextController,
                                          cursorColor: constans.appYellow,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: constans.appYellow,
                                            ),
                                            labelStyle: TextStyle(
                                              color: constans.appYellow,
                                            ),
                                            focusColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: constans.appYellow,
                                              ), //<-- SEE HERE
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: constans.appYellow,
                                              ), //<-- SEE HERE
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Enter a city',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                          width: 200.0,
                                          height: 70.0,
                                          color: Colors.transparent,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: constans.appYellow,
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14.0),
                                                side: const BorderSide(
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              try {
                                                var city = await ApiProvider().searchCities(_cityTextController.text);
                                                if (mounted) {
                                                  Navigator.pop(
                                                    context,
                                                    Coord(lon: city.lon, lat: city.lat),
                                                  );
                                                }
                                              } catch (e) {
                                                debugPrint(e.toString());
                                                PopUpDialogs.openAlertDialog(
                                                    context: context, message: e.toString(), title: 'Error');
                                              }
                                            },
                                            child: const Text(
                                              'Add City',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 15, 14, 49),
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'If you want to add a city, please turn off the "Enable Current Location" switch above!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
