import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp4());
}

/*
-------------------------------------------------------------
狀態管理示例
以下用於狀態管理的示例，與上方的無關，且另起main
-------------------------------------------------------------
Demo1 ：widget自己管理狀態
點擊一個小方框容器 Container 時，切換顯示文字和顏色
*/

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "激活" : "未激活",
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Widget自己管理狀態",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget自己管理狀態'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}

/*
-------------------------------------------------------------
Demo2 ：父 widget 管理 子 widget 的 狀態

TapboxB 通过回调将其状态到其父类。由于 TapboxB 不管理任何状态，因此它继承自 StatelessWidget。
*/

// 父級widget
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

// TapboxB 子widget
class TapboxB extends StatelessWidget {
  // 在创建 API 时，请考虑使用 @required 为代码所依赖的任何参数使用注解。
  // 要使用 @required 注解，请导入 [foundation library]（该库重新导出 Dart 的 [meta.dart]）：
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? "已激活" : "未激活",
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration:
            BoxDecoration(color: active ? Colors.blue[700] : Colors.grey[600]),
      ),
    );
  }
}

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "父 widget 管理 widget 的 state",
      home: Scaffold(
        appBar: AppBar(
          title: Text('父 widget 管理 widget 的 state'),
        ),
        body: Center(
          child: ParentWidget(),
        ),
      ),
    );
  }
}

/*
-------------------------------------------------------------
Demo3 ：混搭管理狀態

在 TapboxC 示例中，点击时，盒子的周围会出现一个深绿色的边框。点击时，边框消失，盒子的颜色改变。
TapboxC 将其 _active 状态导出到其父 widget 中，但在内部管理其 _highlight 状态。
这个例子有两个状态对象 _ParentWidgetState 和 _TapboxCState。
*/

//----父級widget，和demo2一樣的
class ParentWidget2 extends StatefulWidget {
  @override
  _ParentWidget2State createState() => _ParentWidget2State();
}

// _ParentWidget2State 对象:
//    管理_active 状态。
//    实现 _handleTapboxChanged(), 此方法在盒子被点击时调用。
//    当点击盒子并且 _active 状态改变时调用 setState() 来更新 UI。
class _ParentWidget2State extends State<ParentWidget2> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

// TapboxC 子widget
class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => _TapboxCState();
}

// _TapboxCState 对象:
//     管理 _highlight state。
//     GestureDetector 监听所有 tap 事件。当用户点下时，它添加高亮（深绿色边框）；当用户释放时，会移除高亮。
//     当按下、抬起、或者取消点击时更新 _highlight 状态，调用 setState() 更新UI。
//     当点击时，[widget] 属性将状态的改变传递给父 widget 并进行合适的操作。
class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}

class MyApp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "混合管理 state",
      home: Scaffold(
        appBar: AppBar(
          title: Text('混合管理 state'),
        ),
        body: Center(
          child: ParentWidget2(),
        ),
      ),
    );
  }
}
