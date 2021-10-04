import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:stockdaddy/controllers/controller.dart';
import 'package:stockdaddy/models/sd_task_model.dart';
import 'package:stockdaddy/repository/sd_default_model_repo.dart';
import 'package:stockdaddy/screens/sd_edit_create_screen.dart';
import 'package:stockdaddy/widgets/sd_custom_text_field.dart';

class SDHomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const SDHomeScreen({Key? key}) : super(key: key);

  @override
  _SDHomeScreenState createState() => _SDHomeScreenState();
}

class _SDHomeScreenState extends State<SDHomeScreen> {
  // List<SDTaskModel> list = [];

  // void getList() async {

  //   print(list);
  // }
  // SDFirebaseDefaultRepo repo;

  @override
  void initState() {
    // context.read<SDTaskCubit>().getAll();
    super.initState();
    fetchData();
  }

  List<Map<String, dynamic>> models = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  fetchData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('tasks').snapshots().listen((tasks) {
      for (var element in tasks.docs) {
        models.add(element.data());
        print(element.data());
      }
    });

    print(models);
  }

  @override
  Widget build(BuildContext context) {
    print(models);
    return SafeArea(
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            floatingActionButton: const _FABButton(),
            body: ListView(
              children: <Widget>[
                /// Search Bar
                const _DiarySearchBar(),

                SizedBox(
                  height: MediaQuery.of(context).size.height - 235,
                  child: StreamBuilder(
                    stream: firestore.collection('tasks').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('ADD DATA!'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return _DiaryTile(
                            index: index,
                            model: models[index],
                          );
                        },
                        itemCount: models.length,
                      );
                    },
                  ),
                ),
                // /// Diary List
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _DiarySearchBar extends StatelessWidget {
  const _DiarySearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          SDCustomTextField(
            label: 'Search',
            onChange: (input) {},
            hintText: 'Enter Title Here',
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class _DiaryTile extends StatelessWidget {
  const _DiaryTile({Key? key, required this.index, required this.model})
      : super(key: key);

  final int index;
  final Map<String, dynamic> model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        subtitle: model[SDTaskModel.kTags] != null
            ? Flex(
                direction: Axis.horizontal,
                children: List.generate(
                  model[SDTaskModel.kTags].length <= 1
                      ? model[SDTaskModel.kTags].length
                      : 2,
                  (tagIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: RawChip(
                        label: Text(model[SDTaskModel.kTags][tagIndex],
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10)),
                        backgroundColor: Colors.white,
                      ),
                    );
                  },
                ),
              )
            : null,
        tileColor: index % 2 == 0 ? Colors.blue : Colors.blue[700],
        title: Text(
          model[SDTaskModel.kTitle],
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        leading: SizedBox(
          width: 75,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE')
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            model[SDTaskModel.kDateTime]
                                    ?.microsecondsSinceEpoch ??
                                DateTime.now().microsecondsSinceEpoch))
                        .toString()
                        .substring(0, 3),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat('d MMM').format(
                        DateTime.fromMicrosecondsSinceEpoch(
                            model[SDTaskModel.kDateTime]
                                    ?.microsecondsSinceEpoch ??
                                DateTime.now().microsecondsSinceEpoch)),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 1.5,
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline_outlined,
            size: 28,
          ),
          onPressed: () {
            context.read<SDTaskCubit>().delete();
          },
          color: Colors.white,
        ),
        isThreeLine: true,
      ),
    );
  }
}

class _FABButton extends StatelessWidget {
  const _FABButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Row(
        children: const [
          Text(
            'Add',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.add,
            size: 24,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      onPressed: () {
        Navigator.of(context).pushNamed(SDEditCreateScreen.id);
      },
    );
  }
}
