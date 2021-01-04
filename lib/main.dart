import 'package:flutter/material.dart';

/*
 這是最基本的 flutter應用，更多示例查看demos文件夾
 */
void main() {
  // runApp() 函数会持有传入的 Widget，并且使它成为 widget 树中的根节点。
  runApp(
    // 在这个例子中，Widget 树有两个 widgets， Center widget 及其子 widget ——Text 。
    // 框架会强制让根 widget 铺满整个屏幕，也就是说“Hello World”会在屏幕上居中显示。
    Center(
      child: Text(
        'Hello, world!',
        // 在这个例子我们需要指定文字的方向，当使用 MaterialApp widget 时，你就无需考虑这一点，
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
