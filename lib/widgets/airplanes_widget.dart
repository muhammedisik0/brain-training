import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/enum_constants.dart';
import '../constants/image_constants.dart';
import '../controllers/game_controllers/airplane_direction_game_controller.dart';

class Airplanes extends GetView<AirplaneDirectionGameController> {
  const Airplanes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirplaneDirectionGameController>(
      builder: (controller) {
        switch (controller.airplanesType) {
          case AirplanesType.vertical:
            return const AirplanesVertical();
          case AirplanesType.horizontal:
            return const AirplanesHorizontal();
          case AirplanesType.quadrangle:
            return const AirplanesQuadrangle();
          case AirplanesType.pentagon:
            return const AirplanesPentagon();
          case AirplanesType.hexagon:
            return const AirplanesHexagon();
        }
      },
    );
  }
}

class Airplane extends StatelessWidget {
  const Airplane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -45 * pi / 180,
      child: Image.asset(
        ImageConstants.airplaneDirection,
        width: 30,
      ),
    );
  }
}

class AirplaneAround extends GetView<AirplaneDirectionGameController> {
  const AirplaneAround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirplaneDirectionGameController>(
      builder: (controller) {
        return RotatedBox(
          quarterTurns: controller.airplaneAroundTurns,
          child: const Airplane(),
        );
      },
    );
  }
}

class AirplaneInTheMiddle extends GetView<AirplaneDirectionGameController> {
  const AirplaneInTheMiddle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirplaneDirectionGameController>(
      builder: (controller) {
        return RotatedBox(
          quarterTurns: controller.airplaneInTheMiddleTurns,
          child: const Airplane(),
        );
      },
    );
  }
}

class AirplanesVertical extends StatelessWidget {
  const AirplanesVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const AirplaneAround(),
        const SizedBox(height: 10),
        const AirplaneAround(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            AirplaneAround(),
            Padding(
              padding: EdgeInsets.all(10),
              child: AirplaneInTheMiddle(),
            ),
            AirplaneAround(),
          ],
        ),
        const AirplaneAround(),
        const SizedBox(height: 10),
        const AirplaneAround(),
      ],
    );
  }
}

class AirplanesHorizontal extends StatelessWidget {
  const AirplanesHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        AirplaneAround(),
        SizedBox(width: 10),
        AirplaneAround(),
        SizedBox(width: 10),
        AirplaneInTheMiddle(),
        SizedBox(width: 10),
        AirplaneAround(),
        SizedBox(width: 10),
        AirplaneAround(),
      ],
    );
  }
}

class AirplanesQuadrangle extends StatelessWidget {
  const AirplanesQuadrangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AirplaneAround(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AirplaneAround(),
            Padding(
              padding: EdgeInsets.all(10),
              child: AirplaneInTheMiddle(),
            ),
            AirplaneAround(),
          ],
        ),
        const AirplaneAround(),
      ],
    );
  }
}

class AirplanesPentagon extends StatelessWidget {
  const AirplanesPentagon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AirplaneAround(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: AirplaneAround(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: AirplaneInTheMiddle(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: AirplaneAround(),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AirplaneAround(),
            SizedBox(width: 10),
            AirplaneAround(),
          ],
        ),
      ],
    );
  }
}

class AirplanesHexagon extends StatelessWidget {
  const AirplanesHexagon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AirplaneAround(),
            SizedBox(width: 10),
            AirplaneAround(),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AirplaneAround(),
            Padding(
              padding: EdgeInsets.all(10),
              child: AirplaneInTheMiddle(),
            ),
            AirplaneAround(),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AirplaneAround(),
            SizedBox(width: 10),
            AirplaneAround(),
          ],
        ),
      ],
    );
  }
}
