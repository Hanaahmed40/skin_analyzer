import 'package:flutter/material.dart';
import 'diagnosis_record.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';
import 'diagnosis_record.dart';

class HistoryPage extends StatelessWidget {
  final List<DiagnosisRecord> history;

  const HistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: AppColors.primaryLight,
      ),
      body: history.isEmpty
          ? Center(
        child: Text(
          'No history yet.',
          style: TextStyle(fontSize: 18, color: AppColors.blackColor),
        ),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final record = history[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ListTile(
              leading: Image.file(
                record.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                record.result,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(record.date),
              ),
            ),
          );
        },
      ),
    );
  }
}