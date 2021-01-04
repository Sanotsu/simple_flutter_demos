import 'package:flutter/material.dart';

// 示例更多查看 https://flutter.cn/docs/development/ui/layout/constraints

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        body:
            // Center(
            //   child: Container(
            //     color: Colors.red,
            //     padding: const EdgeInsets.all(20.0),
            //     child: Container(color: Colors.green, width: 30, height: 30),
            //   ),
            // ),

            // Center 允许 ConstrainedBox 达到屏幕可允许的任意大小。 ConstrainedBox 将 constraints 参数带来的约束附加到其子对象上。
            // Container 必须介于 70 到 150 像素之间。虽然它希望自己有 10 个像素大小，但最终获得了 70 个像素（最小为 70）。
            Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 70,
              minHeight: 70,
              maxWidth: 150,
              maxHeight: 150,
            ),
            child: Container(color: Colors.red, width: 10, height: 10),
          ),
        ),
      ),
    );
  }
}

/*
Flutter 布局约束
一條準則：
    首先，上层 widget 向下层 widget 传递约束条件；   Constaints go down
    然后，下层 widget 向上层 widget 传递大小信息。   Sizes go up
    最后，上层 widget 决定下层 widget 的位置。      Parent sets position
  細節：
    Widget 会通过它的 父级 获得自身的约束。约束实际上就是 4 个浮点类型的集合：最大/最小宽度，以及最大/最小高度。
    然后，这个 widget 将会逐个遍历它的 children 列表。向子级传递 约束（子级之间的约束可能会有所不同），
        然后询问它的每一个子级需要用于布局的大小。
    然后，这个 widget 就会对它子级的 children 逐个进行布局。（水平方向是 x 轴，竖直是 y 轴）
    最后，widget 将会把它的大小信息向上传递至父 widget（包括其原始约束条件）。

Flutter 的布局引擎有一些重要限制：
    一个 widget 仅在其父级给其约束的情况下才能决定自身的大小。这意味着 widget 通常情况下【不能任意获得其想要的大小】。
    一个 widget 【无法知道，也不需要决定其在屏幕中的位置】。因为它的位置是由其父级决定的。
    当轮到父级决定其大小和位置的时候，同样的也取决于它自身的父级。所以，【在不考虑整棵树的情况下，几乎不可能精确定义任何 widget 的大小和位置】。
    如果子级想要拥有和父级不同的大小，然而父级没有足够的空间对其进行布局的话，子级的设置的大小可能会不生效。 【这时请明确指定它的对齐方式】。
 */

/*
屏幕迫使 ConstrainedBox 与屏幕大小完全相同，因此它告诉其子 Widget 也以屏幕大小作为约束，从而忽略了其 constraints 参数带来的影响。


屏幕强制 OverflowBox 变得和屏幕一样大，并且 OverflowBox 允许其子容器设置为任意大小。
    OverflowBox 与 UnconstrainedBox 类似，但不同的是，如果其子级超出该空间，它将不会显示任何警告。

UnconstrainedBox 让它的子级决定成为任何大小，如果其子级是一个具有无限大小的 Container。
    Flutter 无法渲染无限大的东西，所以它抛出以下错误： BoxConstraints forces an infinite width.（盒子约束强制使用了无限的宽度）
    UnconstrainedBox 给 LimitedBox 一个无限的大小；但它向其子级传递了最大为 100 的约束，那么子級設置無限大不會報錯，因為最大就100。

屏幕强制 FittedBox 变得和屏幕一样大，而 Text 则是有一个自然宽度（也被称作 intrinsic 宽度），它取决于文本数量，字体大小等因素。
    FittedBox 让 Text 可以变为任意大小。但是在 Text 告诉 FittedBox 其大小后， FittedBox 缩放文本直到填满所有可用宽度。
将 FittedBox 放进 Center widget 中会发生什么？ Center 将会让 FittedBox 能够变为任意大小，取决于屏幕大小。
    FittedBox 然后会根据 Text 调整自己的大小，然后让 Text 可以变为所需的任意大小，由于二者具有同一大小，因此不会发生缩放。
FittedBox 只能在有限制的宽高中对子 widget 进行缩放（宽度和高度不会变得无限大）。否则，它将无法渲染任何内容，并且你会在控制台中看到错误。

屏幕强制 Row 变得和屏幕一样大，所以 Row 充满屏幕。
    和 UnconstrainedBox 一样， Row 也不会对其子代施加任何约束，而是让它们成为所需的任意大小。 Row 然后将它们并排放置，任何多余的空间都将保持空白。
    由于 Row 不会对其子级施加任何约束，因此它的 children 很有可能太大而超出 Row 的可用宽度。在这种情况下， Row 会和 UnconstrainedBox 一样显示溢出警告

如果所有 Row 的子级都被包裹了 Expanded widget，每一个 Expanded 大小都会与其 flex 因子成比例，并且 Expanded widget 将会强制其子级具有与 Expanded 相同的宽度。

如果你使用 Flexible 而不是 Expanded 的话，唯一的区别是，Flexible 会让其子级具有与 Flexible 相同或者更小的宽度。而 Expanded 将会强制其子级具有和 Expanded 相同的宽度。
    但无论是 Expanded 还是 Flexible 在它们决定子级大小时都会忽略其宽度。
*/

// 布局約束主要涉及到的widget
/*
Container
Center 
Align 
ConstrainedBox 
UnconstrainedBox 
OverflowBox 
LimitedBox 
FittedBox 
Row 
Expanded 
Flexible 
Scaffold 
SizedBox
*/

/*
当一个 widget 告诉它的子级必须变成某个大小的时候，我们通常称这个 widget 对其子级使用 严格约束（tight）。

Flutter 中的 widget 由在其底层的 RenderBox 对象渲染而成。渲染框由其父级 widget 给出约束，并根据这些约束调整自身尺寸大小。
约束是由最小宽度、最大宽度、最小高度、最大高度四个方面构成；尺寸大小则由特定的宽度和高度两个方面构成。

一般来说，从如何处理约束的角度来看，有以下三种类型的渲染框：
    尽可能大。比如 Center 和 ListView 的渲染框。
    与子 widget 一样大，比如 Transform 和 Opacity 的渲染框。
    特定大小，比如 Image 和 Text 的渲染框。

无边界约束
传递给框的约束是 无边界 的或无限的。这意味着约束的最大宽度或最大高度为double.INFINITY。
渲染框具有无边界约束的最常见情况是：
    当其被置于 flex boxes (Row 和 Column)内
    可滚动区域(ListView 和其它 ScrollView 的子类)内

Flex
Flex 框本身(Row 和 Column)的行为会有所不同，这取决于其在给定方向上是处于有边界约束还是无边界约束。
    在有边界约束条件下，它们在给定方向上会尽可能大。
    在无边界约束条件下，它们试图让其子 widget 自适应这个给定的方向。
在 交叉 方向上，如 Column（垂直的 flex）的宽度和 Row（水平的 flex）的高度，它们必将不能是无界的，
否则它们将无法合理地对齐它们的子 widget。
 */
