import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 標題部分的布局
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            // 将 Column 元素放到 Expanded widget 中可以拉伸该列，以利用该行中所有剩余的闲置空间。
            // 设置 crossAxisAlignment 属性值为 CrossAxisAlignment.start，这会将该列放置在行的起始位置。
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 将第一行文本放入 Container 容器中使得你可以增加内间距。列中的第二个子元素，同样为文本，显示为灰色。
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "奥希宁湖露营地",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "卡尔斯鲁厄，瑞士",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          // 點擊星星收藏/取消收藏
          FavoriteWidget(),
        ],
      ),
    );

    // 按钮行的布局
    // 通过调用函数并传递针对某列的颜色，Icon 图标和文本，来构建包含这些列的行。
    // 然后在行的主轴方向通过使用 MainAxisAlignment.spaceEvenly，将剩余的空间均分到每列各自的前后及中间。
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, "撥號"),
          _buildButtonColumn(color, Icons.near_me, "導航"),
          _buildButtonColumn(color, Icons.share, "分享")
        ],
      ),
    );

    // 文本区域的布局
    // 将文本区域定义为一个变量，将文本放置到一个 Container 容器中，然后为每条边添加内边距
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        '奥希宁湖位于伯尔尼阿尔卑斯山脉的比吕姆利萨尔普山脚下。它位于海拔1578米处，'
        '是较大的高山湖泊之一。从坎德斯特格乘坐贡多拉，然后在牧场和松林中步行半小时，'
        '就可以到达湖边，夏天湖水的温度会上升到20摄氏度。这里的活动包括划船和乘坐夏季雪橇。',
        softWrap: true, // 设置 softwrap 为 true，文本将在填充满列宽后在单词边界处自动换行。
      ),
    );

    return MaterialApp(
      title: "布局構建教程示例",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter單頁布局示例"),
        ),
        // 需要在一个 ListView 中排列好所有的元素，而不是在一个 Column 中，
        // 因为当 app 运行在某个小设备上时，ListView 支持 app body 的滚动。
        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              // BoxFit.cover 告诉系统图片应当尽可能等比缩小到刚好能够覆盖住整个渲染 box。
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  // 按钮区域包含三列使用相同布局－一行文本上面一个图标。此行的各列被等间隙放置，文本和图标被着以初始色。
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    // 直接将图标添加到这列里。文本在以一个仅有上间距為8的 Container 容器中，使得文本与图标分隔开。
    return Column(
      // 主軸大小
      mainAxisSize: MainAxisSize.min,
      // 主軸位置
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

// 创建 StatefulWidget 的子类
// 創建 FavoriteWidget管理收藏的狀態（點擊星星的狀態改變）。
class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

// _FavoriteWidgetState 类存储可变信息；可以在 widget 的生命周期内改变逻辑和内部状态。
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // 状态对象存储这些信息在 _isFavorited 和 _favoriteCount 变量中。
  bool _isFavorited = true;
  int _favoriteCount = 41;

// 按下 IconButton 时会调用 _toggleFavorite() 方法，然后它会调用 setState()。
  void _toggleFavorite() {
    // 调用 setState() 是至关重要的，因为这告诉框架，widget 的状态已经改变，应该重绘。
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

// build() 方法创建一个包含红色 IconButton 和 Text 的行
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        // 将文本放在 [SizedBox]中并设置其宽度可防止出现明显的“跳跃”，因为这些值具有不同的宽度。
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
