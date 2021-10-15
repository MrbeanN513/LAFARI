// Don't forget to make the changes mentioned in
// https://github.com/bitsdojo/bitsdojo_window#getting-started

import 'dart:ui' as ui;
import 'dart:io';

import 'package:LAFARI/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'dart:async';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Acrylic.initialize();
  runApp(const MyApp());
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      // const initialSize = Size(900, 600);
      // win.minSize = initialSize;
      // win.size = initialSize;
      win.maximize();
      win.alignment = Alignment.center;
      // win.title = "Custom window with Flutter";
      win.show();
    });
  }
}

// const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WindowBorder(
        color: Colors.transparent,
        width: 0,
        child: Row(
          children: const [
            Expanded(flex: 2, child: Leftside()),
            Expanded(flex: 15, child: Rightside())
          ],
        ),
      ),
    );
  }
}

class Leftside extends StatefulWidget {
  const Leftside({Key? key}) : super(key: key);

  @override
  _LeftsideState createState() => _LeftsideState();
}

class _LeftsideState extends State<Leftside> {
  AcrylicEffect effect = AcrylicEffect.transparent;
  Color color =
      Platform.isWindows ? const Color(0x00FFFFFF) : Colors.transparent;

  @override
  void initState() {
    super.initState();
    this.setWindowEffect(this.effect);
  }

  void setWindowEffect(AcrylicEffect? value) {
    Acrylic.setEffect(effect: value!, gradientColor: this.color);
    this.setState(() => this.effect = value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.grey.shade200.withAlpha(210),
                ),
              ),
            ),
            WindowTitleBarBox(
              child: Row(children: [
                const WindowButtons(),
                Expanded(child: MoveWindow()),
              ]),
            ),
          ],
        ));
  }
}

class Rightside extends StatefulWidget {
  const Rightside({Key? key}) : super(key: key);

  @override
  _RightsideState createState() => _RightsideState();
}

class _RightsideState extends State<Rightside> {
  AcrylicEffect effect = AcrylicEffect.transparent;
  Color color =
      Platform.isWindows ? const Color(0x00FFFFFF) : Colors.transparent;

  @override
  void initState() {
    super.initState();
    this.setWindowEffect(this.effect);
  }

  void setWindowEffect(AcrylicEffect? value) {
    Acrylic.setEffect(effect: value!, gradientColor: this.color);
    this.setState(() => this.effect = value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
          child:webApp(),
          color: Colors.white,
        ),
      ),
      WindowTitleBarBox(
        child: Row(
          children: [
            Expanded(child: MoveWindow()),
          ],
        ),
      )
    ]);
  }
}

// const sidebarColor = Color(0xFFF6A00C);

// class LeftSide extends StatelessWidget {
//   const LeftSide({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.transparent,
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   bottomLeft: Radius.circular(20)),
//               child: BackdropFilter(
//                 filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                 child: Container(
//                   color: Colors.grey.shade200.withAlpha(210),
//                 ),
//               ),
//             ),
//             WindowTitleBarBox(
//               child: Row(children: [
//                 const WindowButtons(),
//                 Expanded(child: MoveWindow()),
//               ]),
//             ),
//           ],
//         ));
//   }
// }

// class RightSide extends StatelessWidget {
//   const RightSide({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       ClipRRect(
//         borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
//         child: Container(
//           color: Colors.white,
//         ),
//       ),
//       WindowTitleBarBox(
//         child: Row(
//           children: [
//             Expanded(child: MoveWindow()),
//           ],
//         ),
//       )
//     ]);
//   }
// }

// final buttonColors = WindowButtonColors(
//     iconNormal: const Color(0xFF805306),
//     mouseOver: Colors.green,
//     mouseDown: const Color(0xFF805306),
//     iconMouseOver: const Color(0xFF805306),
//     iconMouseDown: Colors.blue);

// final closeButtonColors = WindowButtonColors(
//     mouseOver: const Color(0xFFD32F2F),
//     mouseDown: const Color(0xFFB71C1C),
//     iconNormal: Colors.red,
//     iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  void close() {
    setState(() {
      appWindow.close();
    });
  }

  void minimize() {
    setState(() {
      appWindow.minimize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: GestureDetector(
              onTap: () {
                close();
              },
              child: Container(
                height: 15,
                width: 15,
                color: Colors.red,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(7.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: GestureDetector(
              onTap: () {
                minimize();
              },
              child: Container(
                height: 15,
                width: 15,
                color: Colors.green,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: GestureDetector(
              onTap: () {
                maximizeOrRestore();
              },
              child: Container(
                height: 15,
                width: 15,
                color: Colors.yellowAccent.shade700,
              ),
            ),
          ),
        ),

        // CloseWindowButton(colors: closeButtonColors),
        // appWindow.isMaximized
        //     ? RestoreWindowButton(
        //         colors: buttonColors,
        //         onPressed: maximizeOrRestore,
        //       )
        //     : MaximizeWindowButton(
        //         colors: buttonColors,
        //         onPressed: maximizeOrRestore,
        //       ),
        // MinimizeWindowButton(colors: buttonColors),
      ],
    );
  }
}
