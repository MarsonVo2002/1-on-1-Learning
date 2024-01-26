import 'package:flutter/material.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:lettutor/model/user/user.dart';

class AccountSessionProvider extends ChangeNotifier {
  AccountDTO account = AccountDTO(email: '', password: '');
  User user = User();
  List<TutorInfo> tutor_list = [];
  List<TutorInfo> search_tutor = [];
  List<Course> course_list = [];
  List<TutorInfo> favorite = [];
  List<BookingInfo> booked_class = [];
  List<BookingInfo> history = [];
  List<TestPreparation> test = [];
  List<LearnTopic> topic = [];
  List<BookingInfo> upcoming_classes = [];
  List<Tutor> review = [];
  void setTests(List<TestPreparation> list) {
    test.clear();
    test = list;
    notifyListeners();
  }

  void setUpcomingClasses(List<BookingInfo> upcoming) {
    upcoming_classes.clear();
    upcoming_classes = upcoming;
    notifyListeners();
  }

  void setTopics(List<LearnTopic> list) {
    topic.clear();
    topic = list;
    notifyListeners();
  }

  void setReview(List<Tutor> tutor) {
    review = tutor;
    notifyListeners();
  }

  void addHistory(ClassInfo info) {
    account.history_list.add(info);
    print('add to favourite');
    notifyListeners();
  }

  void setHistory(List<BookingInfo> info) {
    history.clear();
    history = info;
    notifyListeners();
  }

  void setBookedClass(List<BookingInfo> info) {
    booked_class.clear();
    booked_class = info;
    notifyListeners();
  }

  void sortTutorList() {
    tutor_list.sort((a, b) {
      int favoriteComparison =
          (b.isFavorite == true ? 1 : 0) - (a.isFavorite == true ? 1 : 0);

      // If isFavorite is the same, compare by rating
      if (favoriteComparison == 0) {
        if (a.rating != null && b.rating != null) {
          return b.rating!.compareTo(a.rating!);
        } else if (a.rating != null) {
          return -1; // Move items with null rating to the end
        } else if (b.rating != null) {
          return 1; // Move items with null rating to the end
        } else {
          return 0; // Both ratings are null
        }
      }

      return favoriteComparison;
    });
    review.sort((a, b) {
      int indexA = tutor_list.indexWhere((info) => info.user!.id == a.userId);
      int indexB = tutor_list.indexWhere((info) => info.user!.id == b.userId);
      return indexA.compareTo(indexB);
    });
    notifyListeners();
  }
  void removeUpcoming(BookingInfo info)
  {
    upcoming_classes.remove(info);
    notifyListeners();
  }
  void sortBookedClasses() {
    booked_class.sort(
      (a, b) {
        DateTime dateTimeA = DateTime.fromMillisecondsSinceEpoch(
            a.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        DateTime dateTimeB = DateTime.fromMillisecondsSinceEpoch(
            b.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        int dateComparison = dateTimeB.year.compareTo(dateTimeA.year);
        if (dateComparison == 0) {
          dateComparison = dateTimeB.month.compareTo(dateTimeA.month);
          if (dateComparison == 0) {
            dateComparison = dateTimeB.day.compareTo(dateTimeA.day);
          }
        }

        if (dateComparison == 0) {
          int timeComparison = dateTimeA.hour.compareTo(dateTimeB.hour);
          if (timeComparison == 0) {
            timeComparison = dateTimeA.minute.compareTo(dateTimeB.minute);
          }
          return timeComparison;
        }
        return dateComparison;
      },
    );
    notifyListeners();
  }

  void sortUpcomingClasses() {
    upcoming_classes.sort(
      (a, b) {
        DateTime dateTimeA = DateTime.fromMillisecondsSinceEpoch(
            a.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        DateTime dateTimeB = DateTime.fromMillisecondsSinceEpoch(
            b.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        int dateComparison = dateTimeA.year.compareTo(dateTimeB.year);
        if (dateComparison == 0) {
          dateComparison = dateTimeA.month.compareTo(dateTimeB.month);
          if (dateComparison == 0) {
            dateComparison = dateTimeA.day.compareTo(dateTimeB.day);
          }
        }

        if (dateComparison == 0) {
          int timeComparison = dateTimeA.hour.compareTo(dateTimeB.hour);
          if (timeComparison == 0) {
            timeComparison = dateTimeA.minute.compareTo(dateTimeB.minute);
          }
          return timeComparison;
        }
        return dateComparison;
      },
    );
    notifyListeners();
  }

  void setFavoriteList(List<TutorInfo> tutors) {
    favorite.clear();
    favorite = tutors;
    notifyListeners();
  }

  void addFavorite(TutorInfo tutor) {
    favorite.add(tutor);
    notifyListeners();
  }

  void deleteFavorite(TutorInfo tutor) {
    favorite.remove(tutor);
    notifyListeners();
  }

  void deleteBookedClass() {
    notifyListeners();
  }

  void setUser(User u) {
    user = u;
    notifyListeners();
  }

  void setCourseList(List<Course> course) {
    course_list.clear();
    course_list = course;
    notifyListeners();
  }

  void setTutorList(List<TutorInfo> tutor) {
    tutor_list.clear();
    tutor_list = tutor;
    notifyListeners();
  }

  void setSearchList(List<TutorInfo> tutor) {
    search_tutor.clear();
    search_tutor = tutor;
    notifyListeners();
  }

  void addTeacher(TeacherDTO teacher) {
    account.teacher_list.add(teacher);
    print('add to favourite');
    notifyListeners();
  }

  void removeTeacher(TeacherDTO teacher) {
    account.teacher_list.remove(teacher);
    print('remove from favourite');
    notifyListeners();
  }

  void removeHistory(ClassInfo info) {
    account.history_list.remove(info);
    print('remove from favourite');
    notifyListeners();
  }

  void addLesson(ClassInfo obj) {
    account.lesson_list.add(obj);
    account.totalLessonTime += 25;
    notifyListeners();
  }

  void removeLesson(ClassInfo obj) {
    account.lesson_list.remove(obj);
    account.totalLessonTime -= 25;
    notifyListeners();
  }

  void setAccount(AccountDTO obj) {
    account = obj;
    notifyListeners();
  }

  void updateUsername(String name) {
    account.name = name;
    notifyListeners();
  }

  void updateAvatar(String avatarpath) {
    account.avatarpath = avatarpath;
    notifyListeners();
  }
}
