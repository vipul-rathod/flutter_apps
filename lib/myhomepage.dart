
import 'package:flutter/material.dart';
import 'package:owner_form_app/myhomeviewsmall.dart';
import 'package:owner_form_app/myhomeviewlarge.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600){
            return const MyHomeViewSmall();
          }
          else{
            return const MyHomeViewLarge();
          }
        },
      ),
    );
  }
}

// class StretchableSilverAppBar extends StatefulWidget {
//   const StretchableSilverAppBar({super.key});
//   @override
//   State<StretchableSilverAppBar> createState() => _StretchableSilverAppBarState();
// }

// class _StretchableSilverAppBarState extends State<StretchableSilverAppBar> {
//   bool _stretch = true;
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: Scaffold(
//         body: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: <Widget>[
//             SliverAppBar(
//               stretch: _stretch,
//               onStretchTrigger: () async {
//                 //Triggers when stretching
//               },
//               stretchTriggerOffset: 300.0,
//               expandedHeight: 200.0,
//               flexibleSpace: const FlexibleSpaceBar(
//                 title: Text('SilverAppBar', style: TextStyle(color: Colors.black)),
//                 background: FlutterLogo(),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//                 return Container(
//                   color: index.isOdd ? Colors.white : Colors.black12,
//                   height: 50.0,
//                   child: Center(
//                     child: Text('$index', textScaler: const TextScaler.linear(2.5)),
//                   ),
//                 );
//               },
//               childCount: 20,
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: OverflowBar(
//               overflowAlignment: OverflowBarAlignment.center,
//               alignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Text('stretch'),
//                 Switch(
//                   onChanged: (bool val){
//                     setState((){
//                       _stretch = val;
//                     });
//                   },
//                   value: _stretch,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
