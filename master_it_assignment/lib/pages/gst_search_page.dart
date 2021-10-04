import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:master_it_assignment/pages/gst_profile_page.dart';

class GstSearchPage extends StatelessWidget {
  const GstSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const GstSearchPageHeader(),
        GstSearchPageBody(),
      ],
    );
  }
}

class GstSearchPageHeader extends StatefulWidget {
  const GstSearchPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<GstSearchPageHeader> createState() => _GstSearchPageHeaderState();
}

class _GstSearchPageHeaderState extends State<GstSearchPageHeader> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        color: Colors.green,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text(''),
                    )
                  ];
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "select the type for",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "GST Number Search Tool",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FlutterToggleTab(
              marginSelected: const EdgeInsets.all(4),
              selectedIndex: selectedTab,
              selectedBackgroundColors: const [Colors.white],
              unSelectedBackgroundColors: [Colors.green[900]!],
              width: 90,
              borderRadius: 30,
              height: 50,
              selectedTextStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              labels: const ['Search GST Number', 'GST Return Status'],
              selectedLabelIndex: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GstSearchPageBody extends StatelessWidget {
  GstSearchPageBody({
    Key? key,
  }) : super(key: key);
  late String gstNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Enter GST Number',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (input) {
              gstNumber = input;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: "Ex:07AACCM9910C1Z",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GstProfilePage(gstNumber : gstNumber),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
