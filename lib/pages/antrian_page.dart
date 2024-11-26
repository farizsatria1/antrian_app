import 'package:antrian_app/core/constants/colors.dart';
import 'package:antrian_app/data/models/antrian.dart';
import 'package:antrian_app/pages/printer_page.dart';
import 'package:flutter/material.dart';

import '../data/datasources/antrian_local_datasource.dart';

class AntrianPage extends StatefulWidget {
  const AntrianPage({super.key});

  @override
  State<AntrianPage> createState() => _AntrianPageState();
}

class _AntrianPageState extends State<AntrianPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noAntrianController = TextEditingController();

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Kelola Antrian",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const PrinterPage();
              }));
            },
          ),
        ],
      ),
      body: listAntrian.isEmpty
          ? const Center(
              child: Text('Data Antrian Kosong'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listAntrian.length,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      listAntrian[index].nama,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      listAntrian[index].noAntrian,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.subtitle,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        //show dialog update antrian
                        showDialog(
                          context: context,
                          builder: (context) {
                            _namaController.text = listAntrian[index].nama;
                            _noAntrianController.text =
                                listAntrian[index].noAntrian;
                            return AlertDialog(
                              title: const Text('Ubah Antrian'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _namaController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nama Antrian',
                                    ),
                                  ),
                                  TextField(
                                    controller: _noAntrianController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nomor Antrian',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        AntrianLocalDatasource.instance
                                            .deleteAntrian(
                                          listAntrian[index].id!,
                                        );
                                      },
                                    );
                                    getAntrian();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Hapus'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      AntrianLocalDatasource.instance
                                          .updateAntrian(
                                        Antrian(
                                          id: listAntrian[index].id,
                                          nama: _namaController.text,
                                          noAntrian: _noAntrianController.text,
                                          isActive: listAntrian[index].isActive,
                                        ),
                                      );
                                    });
                                    getAntrian();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Simpan'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //show dialog add antrian
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Tambah Antrian'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Antrian',
                        ),
                      ),
                      TextField(
                        controller: _noAntrianController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Antrian',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        //save antrian
                        AntrianLocalDatasource.instance.saveAntrian(
                          Antrian(
                            nama: _namaController.text,
                            noAntrian: _noAntrianController.text,
                            isActive: true,
                          ),
                        );
                        getAntrian();
                        Navigator.pop(context);
                      },
                      child: const Text('Simpan'),
                    ),
                  ],
                );
              });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
