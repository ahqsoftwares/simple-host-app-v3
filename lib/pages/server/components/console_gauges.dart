import "dart:async";
import "dart:math";

import "package:flutter/material.dart";
import "package:syncfusion_flutter_gauges/gauges.dart";

class ConsoleGauges extends StatelessWidget {
  const ConsoleGauges({
    Key? key,
    required this.serverId,
    required this.userId,
    required this.token,
    required this.number,
  }) : super(key: key);

  final String serverId;
  final String userId;
  final String token;

  final double number;

  final Color _pointerColor = const Color(0xFF494CA2);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        SfRadialGauge(
          enableLoadingAnimation: true,
          axes: [
            RadialAxis(
              axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.15,
              ),
              useRangeColorForAxis: true,
              minimum: 0,
              minorTicksPerInterval: 2,
              minorTickStyle: const MinorTickStyle(
                color: Colors.white,
              ),
              majorTickStyle: const MajorTickStyle(
                length: 1,
                color: Colors.white,
              ),
              maximum: 100,
              showLabels: true,
              showLastLabel: true,
              axisLabelStyle: const GaugeTextStyle(
                color: Colors.white,
              ),
              pointers: [
                RangePointer(
                  value: number,
                  width: 0.15,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: _pointerColor,
                  animationDuration: 200,
                  animationType: AnimationType.ease,
                  gradient: SweepGradient(
                    colors: number >= 90
                        ? [
                            Colors.green[900] as Color,
                            Colors.yellow[500] as Color,
                            Colors.red[800] as Color
                          ]
                        : number >= 50
                            ? [
                                Colors.green[900] as Color,
                                Colors.yellow[500] as Color,
                              ]
                            : [
                                Colors.green[900] as Color,
                              ],
                    stops: number >= 90
                        ? [0.2, 0.4, 0.9]
                        : number >= 50
                            ? [0.5, 0.7]
                            : [1],
                  ),
                  enableAnimation: true,
                ),
                MarkerPointer(
                  enableAnimation: true,
                  color: Colors.red[900],
                  markerHeight: 40,
                  markerWidth: 40,
                  markerType: MarkerType.circle,
                  animationType: AnimationType.easeOutBack,
                  value: number,
                  animationDuration: 500,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
