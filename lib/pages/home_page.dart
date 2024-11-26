import 'package:antrian_app/core/constants/colors.dart';
import 'package:antrian_app/data/models/antrian.dart';
import 'package:audio_plus/audio_plus.dart';
import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../data/datasources/antrian_local_datasource.dart';
import '../data/datasources/antrian_print.dart';
import 'antrian_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Antrian> listAntrian = [];

  Future<void> getAntrian() async {
    //get all antrian
    final result = await AntrianLocalDatasource.instance.getAllAntrian();
    setState(() {
      listAntrian = result;
    });
  }

  @override
  void initState() {
    getAntrian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Antrian",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: listAntrian.isEmpty
          ? const Center(
              child: Text('Data Antrian Kosong'),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: listAntrian.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await AudioPlus.play('assets/audio/pressed.mp3');
                    final noAntrian =
                        listAntrian[index].noAntrian.split('-').last;

                    final newAntrian = listAntrian[index].copyWith(
                      noAntrian:
                          '${listAntrian[index].noAntrian.split('-').first}-${int.parse(noAntrian) + 1}',
                    );

                    final printValue = await AntrianPrint.instance.printAntrian(
                      newAntrian,
                    );
                    await PrintBluetoothThermal.writeBytes(printValue);

                    AntrianLocalDatasource.instance.updateAntrian(newAntrian);
                    getAntrian();
                  },
                  child: Card(
                    color: AppColors.card,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          listAntrian[index].nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        //text
                        Text(
                          listAntrian[index].noAntrian,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // // Add your onPressed code here!
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AntrianPage();
              },
            ),
          );
          getAntrian();
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.settings, color: Colors.white),
      ),
    );
  }
}
