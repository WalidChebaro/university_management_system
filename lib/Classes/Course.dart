import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class Course {
  var randnb = Random(25);

  registerCourse(int _coursesection, String _firstname, String _lastname,
      int _id, String _major, String _uid) {
    Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .then((doc) {
      Firestore.instance.collection('/CourseStudents').add({
        'ID': _id,
        'uid': _uid,
        'FirstName': _firstname,
        'LastName': _lastname,
        'Major': _major,
      });
    });
  }

  Stream<QuerySnapshot> retrieveCourses(String _major) {
    return Firestore.instance
        .collection('/Course')
        .where('Major', isEqualTo: _major)
        .getDocuments()
        .asStream();
  }

  Stream<QuerySnapshot> getCourseInformation(int _coursesection) {
    return Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .asStream();
  }

  // Stream<QuerySnapshot> getCourseFile(
  //     int _coursesection, String _coursefiletitle) {
  //   Stream<QuerySnapshot> file;
  //   Firestore.instance
  //       .collection('/Course')
  //       .where('CourseSection', isEqualTo: _coursesection)
  //       .getDocuments()
  //       .then((doc) {
  //     file = Firestore.instance
  //         .collection('/CourseFiles')
  //         .where('CourseFileTitle', isEqualTo: _coursefiletitle)
  //         .getDocuments()
  //         .asStream();
  //   });
  //   return file;
  // }

  Stream<QuerySnapshot> getCourseFiles(int _coursesection) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .then((doc) {
      file = Firestore.instance
          .collection('/CourseFiles')
          .getDocuments()
          .asStream();
    });
    return file;
  }

  Future dropCourse(String _coursesection, String _uid) async {
    await Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .collection('/CourseSection')
          .where('uid', isEqualTo: _uid)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/CourseSection/${doc.documents[0].documentID}')
            .delete();
      });
    });
  }

  addSection(int _coursesection, String _coursename, String _courseinformation,
      int _coursecredithours, String _firstname, String _lastname, int _id) {
        String _teachername = "$_firstname $_lastname";
    Firestore.instance.collection('/Course/CourseSection').add({
      'ID': _id,
      'TeacherName': _teachername,
      'CourseSection': _coursesection,
      'CourseName': _coursename,
      'CourseInformation': _courseinformation,
      'CourseCreditHours': _coursecredithours,
      'Counter': 0,
    });
  }

  Future removeSection(String _coursesection) async {
    await Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/CourseSection/${doc.documents[0].documentID}')
          .delete();
    });
  }

  addExamGradeToCourse(int _coursesection, int _id, double _courseexamgrade,
      String _courseexamtitle) async {
    await Firestore.instance
        .collection('/Course')
        .where('CourseSection', isEqualTo: _coursesection)
        .getDocuments()
        .then((doc) {
      Firestore.instance.collection('/CourseStudents').add({
        '$_courseexamtitle': _courseexamgrade,
        'CourseOverallGrade': FieldValue.increment(_courseexamgrade),
        'Counter': FieldValue.increment(1),
      });
    });
  }

  Stream<QuerySnapshot> getCoursesStudent(String _uid) {
    return Firestore.instance
        .collection('/Course')
        .where('uid', isEqualTo: _uid)
        .getDocuments()
        .asStream();
  }

  Stream<QuerySnapshot> getCoursesTeacher(String _id) {
    return Firestore.instance
        .collection('/Course')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .asStream();
  }

  uploadCourseFile(var file) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepics/${randnb.nextInt(5000).toString()}.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    dowurl.toString();
  }
}
