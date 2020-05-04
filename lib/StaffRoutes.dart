import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Staff.dart';
import 'TeacherPage.dart';
import 'ChairpersonPage.dart';
import 'RegistrarPage.dart';
import 'BusinessAnalystPage.dart';
import 'TechnicalStaffPage.dart';

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
  String role;
  @override
  void initState() {
    super.initState();
    Staff().setAttributeValues().then((role) {
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
        return new TeacherPage(onSignedOut: widget.onSignedOut);
      case Role.registrar:
        return new RegistrarPage(
          onSignedOut: widget.onSignedOut,
        );
      case Role.chairPerson:
        return new ChairpersonPage(
          onSignedOut: widget.onSignedOut,
        );
      case Role.buisnessAnalyst:
        return new BusinessAnalystPage(
          onSignedOut: widget.onSignedOut,
        );
      case Role.technicalStaff:
        return new TechnicalStaffPage(
          onSignedOut: widget.onSignedOut,
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
