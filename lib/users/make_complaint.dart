import 'package:flutter/material.dart';
class makeComplaint extends StatefulWidget {
  const makeComplaint({Key? key}) : super(key: key);

  @override
  State<makeComplaint> createState() => _makeComplaintState();
}

class _makeComplaintState extends State<makeComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Add Complaint'),
    )
    );
  }
}
