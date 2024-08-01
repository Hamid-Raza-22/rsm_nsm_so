import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'RSM_status.dart';

class RsmDetailPagee extends StatefulWidget {
  final Booker booker;

  RsmDetailPagee({required this.booker});

  @override
  _RsmDetailPageeState createState() => _RsmDetailPageeState();
}

class _RsmDetailPageeState extends State<RsmDetailPagee> {
  final List<String> _statusOptions = ["Clock in", "Clock out"];
  final List<Map<String, dynamic>> _data = [
    {
      'date': '2024-07-25',
      'clockIn': '08:00 AM',
      'clockOut': '05:00 PM',
      'totalTime': '9h 0m',
      'totalDistance': '15 km',
    },
    {
      'date': '2024-07-26',
      'clockIn': '09:00 AM',
      'clockOut': '06:00 PM',
      'totalTime': '9h 0m',
      'totalDistance': '20 km',
    },
    {
      'date': '2024-07-27',
      'clockIn': '08:30 AM',
      'clockOut': '05:30 PM',
      'totalTime': '9h 0m',
      'totalDistance': '18 km',
    },
    {
      'date': '2024-07-28',
      'clockIn': '07:45 AM',
      'clockOut': '04:45 PM',
      'totalTime': '9h 0m',
      'totalDistance': '17 km',
    },
    {
      'date': '2024-07-29',
      'clockIn': '08:15 AM',
      'clockOut': '05:15 PM',
      'totalTime': '9h 0m',
      'totalDistance': '16 km',
    },
  ];

  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;
  List<Map<String, dynamic>> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        _filterData();
      });
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _startDate = null;
      _endDate = null;
      _filteredData = _data;
    });
  }

  void _filterData() {
    setState(() {
      _filteredData = _data.where((entry) {
        final entryDate = DateTime.parse(entry['date']);
        final isWithinDateRange = (_startDate == null && _endDate == null) ||
            (_startDate != null && _endDate == null && entryDate.isAtSameMomentAs(_startDate!)) ||
            (_startDate == null && _endDate != null && entryDate.isAtSameMomentAs(_endDate!)) ||
            (_startDate != null && _endDate != null && entryDate.isAfter(_startDate!.subtract(const Duration(days: 1))) && entryDate.isBefore(_endDate!.add(const Duration(days: 1))));
        final matchesStatus = _selectedStatus == null ||
            (_selectedStatus == "Clock in" && entry['clockIn'].isNotEmpty) ||
            (_selectedStatus == "Clock out" && entry['clockOut'].isNotEmpty);
        return isWithinDateRange && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontFamily: "avenir", fontSize: 14);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.booker.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      labelStyle: TextStyle(
                        color: _startDate != null ? Colors.black : Colors.black,
                        fontSize: _startDate != null ? 12 : null,
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Text(
                        _startDate != null
                            ? DateFormat('yyyy-MM-dd').format(_startDate!)
                            : '',
                        style: TextStyle(
                          color: _startDate != null ? Colors.black : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "End Date",
                      labelStyle: TextStyle(
                        color: _endDate != null ? Colors.black : Colors.black,
                        fontSize: _endDate != null ? 12 : null,
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Text(
                        _endDate != null
                            ? DateFormat('yyyy-MM-dd').format(_endDate!)
                            : '',
                        style: TextStyle(
                          color: _endDate != null ? Colors.black : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Status",
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStatus,
                        isExpanded: true,
                        items: _statusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                            _filterData();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Clear', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('Date', style: textStyle)),
                      const DataColumn(label: Text('Clock In', style: textStyle)),
                      const DataColumn(label: Text('Clock Out', style: textStyle)),
                      const DataColumn(label: Text('Total Time', style: textStyle)),
                      const DataColumn(label: Text('Total Distance', style: textStyle)),
                    ],
                    rows: _filteredData.map((entry) {
                      return DataRow(
                        cells: [
                          DataCell(Text(entry['date'], style: textStyle)),
                          DataCell(Text(entry['clockIn'], style: textStyle)),
                          DataCell(Text(entry['clockOut'], style: textStyle)),
                          DataCell(Text(entry['totalTime'], style: textStyle)),
                          DataCell(Text(entry['totalDistance'], style: textStyle)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
