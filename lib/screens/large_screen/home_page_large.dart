import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_list/components/bottom_sheet_container.dart';
import 'package:my_list/components/custom_appbar.dart';
import 'package:my_list/components/icon_row_button.dart';
import 'package:my_list/components/tasks_list_view.dart';
import 'package:my_list/screens/done_tasks_screen.dart';
import 'package:my_list/screens/fav_tasks_sceen.dart';
import 'package:my_list/screens/important_tasks.dart';
import 'package:my_list/screens/plan_screen.dart';
import 'package:my_list/services/tasks_provider.dart';
import 'package:provider/provider.dart';

class HomePageLarge extends StatefulWidget {
  const HomePageLarge({super.key});

  @override
  State<HomePageLarge> createState() => _HomePageLargeState();
}

class _HomePageLargeState extends State<HomePageLarge> {
  int selectedIndex = 0;

  bool extended = false;
  final destinations = const [
    NavigationRailDestination(
      icon: Icon(Icons.task_alt_sharp),
      label: Text('all tasks'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.favorite_outline_rounded),
      label: Text('favorites'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.lightbulb_outline_rounded),
      label: Text('plans'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.label_important_outline_rounded),
      label: Text('important'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.check_box_outlined),
      label: Text('done'),
    ),
  ];
  final screens = const [
    FavTaskScreen(),
    PlanTaskScreen(),
    ImportantTaskScreen(),
    DoneTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Tasks>(context);
    Widget selectedWidget = screens[selectedIndex > 0 ? selectedIndex - 1 : 0];
    return Scaffold(
        appBar: selectedIndex == 0
            ? const CustomAppBar(
                label: 'All Tasks',
                backEnabled: true,
                splashColor: Colors.blue,
              ).build(context)
            : null,
        body: SizedBox(
          child: Row(
            children: [
              NavigationRail(
                leading: IconButton(
                  tooltip: 'Extend',
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    setState(() {
                      extended = !extended;
                    });
                  },
                  icon: extended
                      ? const Icon(Icons.cancel_outlined)
                      : const Icon(Icons.more_vert_rounded),
                ),
                extended: extended,
                elevation: 10,
                destinations: destinations,
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  // switch (value) {
                  //   case value:

                  //     break;
                  //   default:
                  // }
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
              selectedIndex == 0
                  ? Expanded(
                      child: Container(
                        child: provider.allTasks.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.pencil_outline,
                                    color: Colors.lightBlueAccent.shade700,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Nothing Yet',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: TasksList(
                                    provider: provider,
                                    tasks: provider.allTasks,
                                  ),
                                ),
                              ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        child: selectedWidget,
                      ),
                    )
            ],
          ),
        ),
        floatingActionButton: selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    //isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: BottomSheetContainer(provider: provider));
                    },
                  );
                },
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink.shade900,
                label: const Text('Create Note'),
              )
            : null);
  }
}

// {
//   //   body: Row(
//     //     children: [
//     //       Container(
//     //         constraints: BoxConstraints(
//     //             minHeight: MediaQuery.of(context).size.height,
//     //             minWidth: MediaQuery.of(context).size.width // 2,
//     //             ),
//     //         padding: const EdgeInsets.all(10),
//     //         child: ListView(
//     //           shrinkWrap: true,
//     //           children: [
//     //             IconRowButton(
//     //               iconColor: Colors.red,
//     //               icon: Icons.favorite_outline_rounded,
//     //               label: 'Favorites',
//     //               onTap: () {
    //                 sidePaneWidget = const FavTaskScreen();
//     //                 sidePaneOpen = true;
//     //               },
//     //               tasksLength: provider.favTasks.length,
//     //             ),
//     //             IconRowButton(
//     //               iconColor: Colors.yellow,
//     //               label: 'Plans',
//     //               icon: Icons.lightbulb_outline_rounded,
//     //               onTap: () {
//     //                 sidePaneWidget = const PlanTaskScreen();
//     //                 sidePaneOpen = true;
//     //               },
//     //               tasksLength: provider.plannedTasks.length,
//     //             ),
    //             IconRowButton(
//     //               iconColor: Colors.blue,
//     //               label: 'Important',
//     //               icon: Icons.label_important_outline_rounded,
//     //               onTap: () {
//     //                 sidePaneWidget = const ImportantTaskScreen();
//     //                 sidePaneOpen = true;
//     //               },
//     //               tasksLength: provider.importantTasks.length,
//     //             ),
//     //             IconRowButton(
//     //               iconColor: Colors.blue,
//     //               label: 'Done',
//     //               icon: Icons.check_box_outlined,
//     //               onTap: () {
//     //                 sidePaneWidget = const DoneTaskScreen();
//     //                 sidePaneOpen = true;
//     //               },
//     //               tasksLength: provider.doneTasks.length,
//     //             ),
//     //             const Padding(
//     //               padding: EdgeInsets.only(left: 10),
//     //               child: Divider(
//     //                 color: Colors.lightBlueAccent,
//     //                 thickness: 1,
//     //               ),
//     //             ),
//     //             const Padding(
//     //               padding: EdgeInsets.only(left: 10),
//     //               child: Divider(
//     //                 color: Colors.lightBlueAccent,
//     //                 thickness: 1,
//     //               ),
//     //             ),
//     //             Expanded(
//     //               child: Container(
//     //                 child: provider.allTasks.isEmpty
//     //                     ? Column(
//     //                         mainAxisAlignment: MainAxisAlignment.center,
//     //                         children: [
//     //                           Icon(
//     //                             CupertinoIcons.pencil_outline,
//     //                             color: Colors.lightBlueAccent.shade700,
//     //                             size: 50,
//     //                           ),
//     //                           const SizedBox(
//     //                             height: 10,
//     //                           ),
//     //                           const Text(
//     //                             'Nothing Yet',
//     //                             style: TextStyle(fontSize: 18),
//     //                           ),
//     //                         ],
//     //                       )
//     //                     : SizedBox(
//     //                         child: TasksList(
//     //                           provider: provider,
//     //                           tasks: provider.allTasks,
//     //                         ),
//     //                       ),
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       sidePaneOpen
//     //           ? Container(
//     //               constraints: BoxConstraints(
//     //                   minHeight: MediaQuery.of(context).size.height,
//     //                   minWidth: MediaQuery.of(context).size.width // 2,
//     //                   ),
//     //               child: sidePaneWidget,
//     //             )
//     //           : const SizedBox()
//     //     ],
//     //   ),
//     // );

// }
