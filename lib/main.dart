import 'package:flutter/material.dart';

final GlobalKey key1 = GlobalKey();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: SafeArea(
          child: Center(
              child: CustomRowWidget(
                  text:
                  'Flutter Demo Home Page Flutter Demo Hom111',
                  isChecked: true)),
        ),
      ),
    );
  }
}

class CustomRowWidget extends StatefulWidget {
  final String text;
  final bool isChecked;

  const CustomRowWidget({super.key, required this.text, required this.isChecked});

  @override
  State<CustomRowWidget> createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<CustomRowWidget> {
  final childKey = GlobalKey();
  Size? childSize;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
      childKey.currentContext?.findRenderObject() as RenderBox;
      childSize = renderBox.size;
      setState(() {
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
          if (childSize != null && childSize!.width <= 10.0 ) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: MySeparator(
                    color: Colors.grey,
                    containerKey: childKey,

                  ),
                ),
                Checkbox(
                  value: widget.isChecked,
                  onChanged: (value) {},
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: MySeparator(
                    color: Colors.grey,
                    containerKey: childKey,
                  ),
                ),
                Checkbox(
                  value: widget.isChecked,
                  onChanged: (value) {},
                ),
              ],
            );
          }
      },
    );
  }
}

class MySeparator extends StatefulWidget {
  const MySeparator(
      {Key? key,
        this.height = 1,
        this.color = Colors.black,
        required this.containerKey})
      : super(key: key);
  final double height;
  final Color color;
  final Key containerKey;

  @override
  State<MySeparator> createState() => _MySeparatorState();
}

class _MySeparatorState extends State<MySeparator> {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: widget.containerKey,
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth().toDouble();
        const dashWidth = 10.0;
        final dashHeight = widget.height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        if (boxWidth <= 10.0) {
          return const SizedBox(
            width: 10.0,
          );
        } else {
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: widget.color),
                ),
              );
            }),
          );
        }
      },
    );
  }
}
