import 'package:flutter/material.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Scaffold(
          appBar: AkangaAppBar(),
          drawer: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            child: Drawer(child: MenuPage()),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(color: Colors.white30),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(126, 87, 194, 1),
                      ),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('FRENTE'),
                            )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('teste 2'),
                            )),
                      ],
                    ),
                    // ...List.generate(
                    //   20,
                    //   (index) => const TableRow(
                    //     children: [
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //       TableCell(
                    //         verticalAlignment:
                    //             TableCellVerticalAlignment.middle,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text('teste'),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
