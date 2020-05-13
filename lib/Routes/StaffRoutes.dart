import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Staff.dart';
import 'package:university_management_system/Pages/TeacherPage.dart';
import 'package:university_management_system/Pages/ChairpersonPage.dart';
import 'package:university_management_system/Pages/RegistrarPage.dart';
import 'package:university_management_system/Pages/BusinessAnalystPage.dart';
import 'package:university_management_system/Pages/TechnicalStaffPage.dart';

class StaffRoutes extends StatefulWidget {
  final VoidCallback onSignedOut;
  StaffRoutes({this.onSignedOut});

  @override
  State<StatefulWidget> createState() => new _StaffRoutesState();
}

enum Role {
  notDetermined,
  teacher,
  registrar,
  buisnessAnalyst,
  technicalStaff,
  chairPerson
}

class _StaffRoutesState extends State<StaffRoutes> {
  Role roleStatus = Role.notDetermined;
  Staff staff = new Staff();
  String role;
  @override
  void initState() {
    super.initState();
    staff.setAttributeValues().then((role) {
      setState(() {
        if (role == 'Teacher') {
          roleStatus = Role.teacher;
        } else if (role == 'BusinessAnalyst') {
          roleStatus = Role.buisnessAnalyst;
        } else if (role == 'Registrar') {
          roleStatus = Role.registrar;
        } else if (role == 'TechnicalStaff') {
          roleStatus = Role.technicalStaff;
        } else if (role == 'Chairperson') {
          roleStatus = Role.chairPerson;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (roleStatus) {
      case Role.notDetermined:
        return _buildWaitingScreen();
      case Role.teacher:
        return new TeacherPage(
          onSignedOut: widget.onSignedOut,
          staff: staff,
        );
      case Role.registrar:
        return new RegistrarPage(
          onSignedOut: widget.onSignedOut,
          staff: staff,
        );
      case Role.chairPerson:
        return new ChairpersonPage(
          onSignedOut: widget.onSignedOut,
          staff: staff,
        );
      case Role.buisnessAnalyst:
        return new BusinessAnalystPage(
          onSignedOut: widget.onSignedOut,
          staff: staff,
        );
      case Role.technicalStaff:
        return new TechnicalStaffPage(
          onSignedOut: widget.onSignedOut,
          staff: staff,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
