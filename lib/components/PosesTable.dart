import 'package:flutter/material.dart';

class SavedPosesTable extends StatelessWidget {
  final List<Map<String, dynamic>> poses;
  final Function(Map<String, dynamic>) onApply;
  final Function(String) onDelete;

  const SavedPosesTable({
    Key? key,
    required this.poses,
    required this.onApply,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saved Poses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Motor 1'), numeric: true),
                  DataColumn(label: Text('Motor 2'), numeric: true),
                  DataColumn(label: Text('Motor 3'), numeric: true),
                  DataColumn(label: Text('Motor 4'), numeric: true),
                  DataColumn(label: Text('Motor 5'), numeric: true),
                  DataColumn(label: Text('Actions')),
                ],
                rows: poses.map((pose) {
                  return DataRow(
                    cells: [
                      DataCell(Text(pose['name'] ?? 'Unnamed')),
                      DataCell(Text(pose['motor1'].toStringAsFixed(1))),
                      DataCell(Text(pose['motor2'].toStringAsFixed(1))),
                      DataCell(Text(pose['motor3'].toStringAsFixed(1))),
                      DataCell(Text(pose['motor4'].toStringAsFixed(1))),
                      DataCell(Text(pose['motor5'].toStringAsFixed(1))),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.green,
                              ),
                              onPressed: () => onApply(pose),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => onDelete(pose['id']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
