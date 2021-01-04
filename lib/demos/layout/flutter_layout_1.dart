import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false; // Set to true for visual layout
  // 修改MyApp* 去顯示不同的內容
  runApp(MyApp3());
}

/*
 * Stack 和 Card 示例
 * Stack
 *    可以使用 Stack 在基础 widget（通常是图片）上排列 widget， widget 可以完全或者部分覆盖基础 widget。
 * 說明：
 *    用于覆盖另一个 widget
 *    子列表中的第一个 widget 是基础 widget；后面的子项覆盖在基础 widget 的顶部
 *    Stack 的内容是无法滚动的
 *    你可以剪切掉超出渲染框的子项
 * Card
 *    Material 库 中的 Card 包含相关有价值的信息，几乎可以由任何 widget 组成，但是通常和 ListTile 一起使用。 
 *    Card 只有一个子项，这个子项可以是列、行、列表、网格或者其他支持多个子项的 widget。
 * 說明：
 *    实现一个 Material card
 *    用于呈现相关有价值的信息
 *    接收单个子项，但是子项可以是 Row、Column 或者其他可以包含列表子项的 widget
 *    显示圆角和阴影
 *    Card 的内容无法滚动
 *    来自 Material 库
 */
class MyApp4 extends StatelessWidget {
  static final showCard = true; // Set to false to show Stack

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: Center(child: showCard ? _buildCard() : _buildStack()),
      ),
    );
  }

// 包含 3 个 ListTile 的 Card，并且通过被 SizedBox 包住来调整大小。 Divider 分隔了第一个和第二个 ListTiles。

// ListTile 是 Material 库 中专用的行 widget，它可以很轻松的创建一个包含三行文本以及可选的行前和行尾图标的行。
// ListTile 在 Card 或者 ListView 中最常用，但是也可以在别处使用。
// 一个可以包含最多 3 行文本和可选的图标的专用的行
// 比 Row 更少的配置，更容易使用
// 来自 Material 库
  // #docregion Card
  Widget _buildCard() => SizedBox(
        height: 210,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('1625 Main Street',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('My City, CA 99984'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('(408) 555-1212',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text('costa@example.com'),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      );
  // #enddocregion Card

  // #docregion Stack
  Widget _buildStack() => Stack(
        alignment: const Alignment(0.6, 0.6),
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/pic.jpg'),
            radius: 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: Text(
              'Mia B',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  // #enddocregion Stack
}

/*
 * GridView 和 ListView 示例
 * GridView
 *    使用 GridView 将 widget 作为二维列表展示。 GridView 提供两个预制的列表，或者你可以自定义网格。
 *    当 GridView 检测到内容太长而无法适应渲染盒时，它就会自动支持滚动。
 * 說明：
 *    在网格中使用 widget
 *    当列的内容超出渲染容器的时候，它会自动支持滚动。
 *    创建自定义的网格，或者使用下面提供的网格的其中一个：
 *      GridView.count 允许你制定列的数量
 *      GridView.extent 允许你制定单元格的最大宽度
 * ListView
 *    ListView，一个和列很相似的 widget，当内容长于自己的渲染盒时，就会自动支持滚动。
 * 說明：
 *    一个用来组织盒子中列表的专用 Column
 *    可以水平或者垂直布局
 *    当监测到空间不足时，会提供滚动
 *    比 Column 的配置少，使用更容易，并且支持滚动
 */
class MyApp3 extends StatelessWidget {
  // 切換網格顯示或者列表顯示
  static final showGrid = false; // Set to false to show ListView

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: Center(child: showGrid ? _buildGrid() : _buildList()),
      ),
    );
  }

// 構建網格顯示圖片
  // #docregion grid
  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(30));

  // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
  // The List.generate() constructor allows an easy way to create
  // a list when objects have a predictable naming pattern.

// 图像以名称pic0.jpg、pic1.jpg…pic29.jpg保存。
// 这个 List.generate() 构造函数允许在对象具有可预测的命名模式时轻松地创建列表。
  List<Container> _buildGridTileList(int count) => List.generate(
      count, (i) => Container(child: Image.asset('images/pic$i.jpg')));
  // #enddocregion grid

// 構建列表顯示圖片
  // #docregion list
  Widget _buildList() => ListView(
        children: [
          _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
          _tile('The Castro Theater', '429 Castro St', Icons.theaters),
          _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
          _tile('Roxie Theater', '3117 16th St', Icons.theaters),
          _tile('United Artists Stonestown Twin', '501 Buckingham Way',
              Icons.theaters),
          _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
          Divider(),
          _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
          _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
          _tile(
              'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
          _tile('La Ciccia', '291 30th St', Icons.restaurant),
        ],
      );

// 每個列表顯示的內容（標題 子標題 ICON）
  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
  // #enddocregion list
}

/*
 * Container 的使用示例
 *    增加 padding、margins、borders
 *    改变背景色或者图片
 *    只包含一个子 widget，但是这个子 widget 可以是行、列或者是 widget 树的根 widget
 */
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: Center(child: _buildImageColumn()),
      ),
    );
  }

// 創建圖片顯示列
  // #docregion column
  Widget _buildImageColumn() => Container(
        decoration: BoxDecoration(
          color: Colors.black26, // 背景色（某種灰色）
        ),
        child: Column(
          children: [
            _buildImageRow(1),
            _buildImageRow(3),
          ],
        ),
      );
  // #enddocregion column

// 每張圖片的顯示設置
  // #docregion row
  Widget _buildDecoratedImage(int imageIndex) => Expanded(
        child: Container(
          // 裝飾器，設置容器樣式和顯示內容
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.red),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
          margin: const EdgeInsets.all(4),
          child: Image.asset('images/pic$imageIndex.jpg'),
        ),
      );

// 設置一行顯示的圖片
  Widget _buildImageRow(int imageIndex) => Row(
        children: [
          _buildDecoratedImage(imageIndex),
          _buildDecoratedImage(imageIndex + 1),
        ],
      );
  // #enddocregion row
}

/*
--------------------------------------------------------
 * 嵌套widgets示例
 *    Row 和 Column 是两种最常用的布局模式。
 *    Row 和 Column 每个都有一个子 widgets 列表。
 *    一个子 widget 本身可以是 Row、Column 或其他复杂 widget。
 *    可以指定 Row 或 Column 如何在垂直和水平方向上对齐其子项。
 *    可以拉伸或限制特定的子 widgets。
 *    可以指定子 widgets 如何占用 Row 或 Column 的可用空间。
 */

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: buildHomePage('Strawberry Pavlova Recipe'), // app頂上標題
    );
  }

// 主頁面
  Widget buildHomePage(String title) {
    // 標題
    final titleText = Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'Strawberry Pavlova', // 主頁面內部標題
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 30,
        ),
      ),
    );

// 副標題
    final subTitle = Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina '
      'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
      'topped with fruit and whipped cream.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 25,
      ),
    );

// 評星部分
    // #docregion ratings, stars / 文档区域 的評分 星星
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
    // #enddocregion stars

// 評論部分（含星星）
    final ratings = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
    // #enddocregion ratings

// 圖標部分默認文本樣式
    // #docregion iconList
    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2,
    );

// 創建3個并排圖標
    // DefaultTextStyle.merge() 允许您创建由其子级和所有后续子级继承的默认文本样式。
    final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.kitchen, color: Colors.green[500]),
                Text('PREP:'),
                Text('25 min'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.timer, color: Colors.green[500]),
                Text('COOK:'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.restaurant, color: Colors.green[500]),
                Text('FEEDS:'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ),
    );
    // #enddocregion iconList

// 把上面的標題、副標題、評論、圖標等放到屏幕左邊
    // #docregion leftColumn
    final leftColumn = Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        children: [
          titleText,
          subTitle,
          ratings,
          iconList,
        ],
      ),
    );
    // #enddocregion leftColumn

// 右側的圖片
    final mainImage = Image.asset(
      'images/pavlova.jpg',
      width: 200,
      fit: BoxFit.cover,
    );

    // final mainImage = Container(
    //   padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
    //   child: Expanded(
    //     child: Image.asset('images/pavlova.jpg', fit: BoxFit.cover),
    //   ),
    // );

// Material app，你可以使用 Scaffold widget，它提供默认的 banner、背景颜色，还有用于添加抽屉、提示条和底部列表弹窗的 API
// 屏幕是768*1376 ？ 不是設置的AVD 1080P?
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // #docregion body
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 440,
                  child: leftColumn,
                ),
                mainImage,
              ],
            ),
          ),
        ),
      ),
      // #enddocregion body
    );
  }
}
