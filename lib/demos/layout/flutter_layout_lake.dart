import 'package:flutter/material.dart';

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
          // 标题行中的最后两项是一个红色星形图标，和文字”41”。
          // 整行都在一个 Container 容器布局中，而且每条边都有 32 像素的内间距。
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
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
