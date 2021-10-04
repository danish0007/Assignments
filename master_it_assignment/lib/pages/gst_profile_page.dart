import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

class GstProfilePage extends StatelessWidget {
  const GstProfilePage({Key? key, required this.gstNumber}) : super(key: key);

  final String gstNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GstProfilePageHeader(gstNumber: gstNumber),
                const _GstProfileDetails(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Get Return Filing Status',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GstProfilePageHeader extends StatelessWidget {
  const GstProfilePageHeader({Key? key, required this.gstNumber})
      : super(key: key);
  final String gstNumber;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    print(height);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        color: Colors.green,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'GST Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Opacity(
              opacity: 0.7,
              child: Text(
                "GSTIN of the tax payer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              gstNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Masters India Private Limited",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            const RawChip(
              label: Text("ACTIVE"),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(color: Colors.green, fontSize: 12),
              avatar: Icon(
                Icons.donut_small,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _GstProfileDetails extends StatelessWidget {
  const _GstProfileDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TimelineTile(
                    // alignment: TimelineAlign.start,
                    isFirst: true,
                    endChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 32,
                        ),
                        NormalText(label: 'Principal Place of Bussiness'),
                        BoldText(
                            label:
                                'K-37, floor, Mandoli Industrial Area North East Delhi, Delhi, 110093')
                      ],
                    ),
                    beforeLineStyle:
                        const LineStyle(color: Colors.grey, thickness: 1),
                    indicatorStyle: IndicatorStyle(
                      indicator: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[200]),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    // alignment: TimelineAlign.start,
                    isLast: true,
                    endChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 32,
                        ),
                        NormalText(label: 'Additional Place of Bussiness'),
                        BoldText(label: 'Floor'),
                      ],
                    ),
                    beforeLineStyle:
                        const LineStyle(color: Colors.grey, thickness: 1),
                    indicatorStyle: IndicatorStyle(
                      indicator: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[200]),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //  Timeline.tileBuilder(
            //   builder: TimelineTileBuilder.fromStyle(
            //     contentsAlign: ContentsAlign.basic,
            //     contentsBuilder: (context, index) => Padding(
            //       padding: const EdgeInsets.all(24.0),
            //       child: Text('Timeline Event $index'),
            //     ),
            //     itemCount: 2,
            //   ),
            // ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 70,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: const [
              _GstProfilePageDetailBar(
                label: 'State Jurisdiction',
                details: 'Ward 74',
              ),
              _GstProfilePageDetailBar(
                label: 'Center Jurisdiction',
                details: 'Range - 139',
              ),
              _GstProfilePageDetailBar(
                label: 'Taxpayer Type',
                details: 'Regular',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  NormalText(label: 'Condition of Business'),
                  BoldText(label: 'Private Limited Company'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      NormalText(label: 'Date of Registration'),
                      NormalText(label: 'Date of Confirmation'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BoldText(label: '01/07/2017'),
                      BoldText(label: '- - -'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GstProfilePageDetailBar extends StatelessWidget {
  const _GstProfilePageDetailBar({
    Key? key,
    required this.details,
    required this.label,
  }) : super(key: key);

  final String label;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NormalText(label: label),
              BoldText(label: details),
            ],
          ),
        ),
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  const NormalText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: Colors.black, fontSize: 12),
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
