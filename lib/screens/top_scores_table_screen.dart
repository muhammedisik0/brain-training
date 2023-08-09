import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../widgets/text_with_divider_widget.dart';
import '../controllers/top_scores_controller.dart';
import '../localization/translation_helper.dart';

class TopScoresTableScreen extends StatelessWidget {
  const TopScoresTableScreen({Key? key}) : super(key: key);

  TopScoresController get topScoresController => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorConstants.orange.withOpacity(0.25),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              children: [
                topScoresText,
                const SizedBox(height: 30),
                topScores,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get topScoresText {
    return TextWithDivider(
      text: TranslationHelper.topScores,
      textStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
    );
  }

  Widget get topScores {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListView.separated(
            itemCount: topScoresController.listOfUsers.length,
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: ((_, index) => buildListOfUsers(index)),
            separatorBuilder: (_, index) {
              return const Divider(
                height: 10,
                thickness: 1,
                color: ColorConstants.grey,
              );
            },
          ),
        ),
      ),
    );
  }

  FutureBuilder<int> buildListOfUsers(int index) {
    return FutureBuilder(
      future: topScoresController.index,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final rank = index + 1;
            final myRank = (snapshot.data as int) + 1;
            return buildUser(rank, myRank);
          } else if (snapshot.hasError) {
            return buildErrorMessage(snapshot);
          }
        }
        return buildProgressIndicator();
      },
    );
  }

  Widget buildUser(int rank, myRank) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: getDecoration(rank, myRank),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                buildRank(rank),
                const SizedBox(width: 10),
                buildRankIcon(rank, myRank),
                const SizedBox(width: 10),
                buildName(rank - 1),
              ],
            ),
          ),
          const SizedBox(width: 20),
          buildScore(rank - 1),
        ],
      ),
    );
  }

  Widget buildRank(int rank) {
    return Expanded(
      flex: 1,
      child: Text(
        '#$rank',
        style: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      ),
    );
  }

  Widget buildRankIcon(int rank, myRank) {
    return CircleAvatar(
      backgroundColor: topScoresController.getRankColor(rank, myRank).backgroundColor,
      minRadius: 16,
      child: Icon(
        Icons.person,
        size: 20,
        color: topScoresController.getRankColor(rank, myRank).iconColor,
      ),
    );
  }

  Widget buildName(int index) {
    return Expanded(
      flex: 4,
      child: Text(
        topScoresController.listOfUsers[index].username,
        style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  }

  Widget buildScore(int index) {
    return Text(
      '${topScoresController.listOfUsers[index].score}',
      style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Center buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorConstants.purple,
        strokeWidth: 2,
      ),
    );
  }

  Widget buildErrorMessage(AsyncSnapshot<int> snapshot) {
    return Center(
      child: Text(
        '${snapshot.error} occurred',
        style: Get.textTheme.bodyLarge,
      ),
    );
  }

  BoxDecoration? getDecoration(int rank, myRank) {
    return rank == myRank
        ? BoxDecoration(
            border: Border.all(color: ColorConstants.purple, width: 2.5),
            borderRadius: BorderRadius.circular(20),
          )
        : null;
  }
}
