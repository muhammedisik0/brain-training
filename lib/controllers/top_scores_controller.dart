import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../models/rank_color_model.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_db_service.dart';
import 'pages_controllers/games_controller.dart';

class TopScoresController extends GetxController {
  late List<User> listOfUsers;

  GamesController get gamesController => Get.find();

  Future<void> getPlayers() async {
    listOfUsers = [];
    final docs = await FirestoreDbService.instance.getDocs();
    for (var element in docs) {
      listOfUsers.add(User.fromJson(element.data()));
    }
    update();
  }

  Future<int> get index async {
    final docs = await FirestoreDbService.instance.getDocs();
    final index = docs.indexWhere(
      (element) => element.id == FirebaseAuthService().user!.uid,
    );
    return index;
  }

  get user async {
    if (await index == -1) {
      return null;
    } else {
      return listOfUsers[await index];
    }
  }

  RankColor getRankColor(int rank, myRank) {
    switch (rank) {
      case 1:
        return RankColor(backgroundColor: const Color(0xffffd700));
      case 2:
        return RankColor(backgroundColor: const Color(0xffc0c0c0));
      case 3:
        return RankColor(backgroundColor: const Color(0xffcd7f32));
      default:
        return rank == myRank
            ? RankColor(backgroundColor: ColorConstants.purple, iconColor: Colors.white)
            : RankColor();
    }
  }
}
