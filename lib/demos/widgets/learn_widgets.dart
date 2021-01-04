/*
 *===============================================================
 * flutter默認的主頁面 
 *===============================================================
 */
/*
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //此小部件是应用程序的根。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 这是应用程序的主题。
        //
        // 使用“flutter running”来运行应用程序。你会看到
        // 应用程序有一个蓝色工具栏。然后，在不退出应用程序的情况下，尝试
        // 将下面的主样本更改为 Colors.green 然后调用
        // “热加载”（在运行"flutter run" 後的控制台中按“r”，
        // 或者简单地将更改保存到flatter ide中的“热重新加载”。
        // 请注意，计数器没有重置回零；应用程序未重新启动。
        primarySwatch: Colors.blue,
        // 自適應平臺顯示
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter 應用主頁面'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // 这个小部件是应用程序的主页。它是stateful的，这意味着它有一个State对象（定义如下），其中包含影响其外观的字段。

  // 這個类是状态的配置。它保存由父级（在本例中是App小部件）提供并由State的build方法使用的值（在本例中是title）。
  // 小部件子类中的字段总是标记为“final”。
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // 这个对setState的调用告诉flutter框架在这个状态下发生了一些变化，
      // 这导致它重新运行下面的build方法，以便显示可以反映更新的值。
      // 如果在不调用setState（）的情况下更改了_counter，则不会再次调用build方法，因此看起来不会发生任何事情。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次调用setState时，都会重新运行此方法，例如由上面的 _incrementCounter 方法执行。
    // flutter框架已经过优化，可以快速地重新运行构建方法，这样您就可以重建任何需要更新的内容，而不必单独更改小部件的实例。
    return Scaffold(
      appBar: AppBar(
        //这里我们从MyHomePage对象获取值，该对象是由应用程序生成方法，并使用它设置appbar标题。
        title: Text(widget.title),
      ),
      body: Center(
        // Center 是一个布局小部件。它把一个孩子放在父母中间。
        child: Column(
          // Column 也是一个布局小部件。它获取子对象列表并垂直排列它们。
          // 默认情况下，它调整自身大小使其水平适合其子对象，并尝试与父对象一样高。
          //
          // 调用“debug painting”（在控制台中按“p”，
          // 在Android Studio中从flatter Inspector中选择“Toggle debug Paint”操作，
          // 或者在visual studio code中选择“Toggle debug Paint”命令）以查看每个小部件的线框。
          //
          // Column 有各种属性来控制它如何调整自身大小以及如何定位子列。这里我们使用主轴对齐来垂直居中子对象；
          // 这里的主轴是垂直轴，因为列是垂直的（横轴是水平的）。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你已經按了 + 號按鈕:',
            ),
            Text(
              '$_counter 次。',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //这个尾随的逗号使得自动格式化对于构建方法更为有效。
    );
  }
}
*/

/*
 *============================================
 *  hello world最簡單程序
 *============================================
 */
/*
import 'package:flutter/material.dart';

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
*/
/*
 *============================================
 *  简单的Flutter 自带了一套强大的基础 widgets示例
 *============================================
 */
/*
import 'package:flutter/material.dart';

// MyAppBar widget 创建了一个高 56 独立像素，左右内边距 8 像素的 Container。
// 在容器内，MyAppBar 以 Row 布局来组织它的子元素。
// 中间的子 widget（title widget），被标记为 Expanded，这意味着它会扩展以填充其它子 widget 未使用的可用空间。
// 你可以定义多个Expanded 子 widget，并使用 flex 参数确定它们占用可用空间的比例。
class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

// MyScaffold widget 将其子 widget 组织在垂直列中。
// 在列的顶部，它放置一个 MyAppBar 实例，并把 Text widget 传给它来作为应用的标题。
// 【把 widget 作为参数传递给其他 widget 是一个很强大的技术，它可以让你以各种方式创建一些可重用的通用组件】。
// 最后，MyScaffold 使用 Expanded 来填充剩余空间，其中包含一个居中的消息。
class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  // 为了获得(MaterialApp)主题的数据，
  // 许多 Material Design 的 widget 需要在 MaterialApp 中才能显现正常。因此，请使用 MaterialApp 运行应用。
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: SafeArea(
      child: MyScaffold(),
    ),
  ));
}
*/
/*
 *============================================
 *  使用 Material 组件
 *============================================
 */
/*
import 'package:flutter/material.dart';

// widget 作为参数传递给了另外的 widget。 
// Scaffold widget 将许多不同的 widget 作为命名参数，每个 widget 都放在了 Scofford 布局中的合适位置。
// 同样的，AppBar widget 允许我们给 leading、title widget 的 actions 传递 widget。
// 这种模式在整个框架会中重复出现，在设计自己的 widget 时可以考虑这种模式。
void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    // home: TutorialHome(),
    home: MyButton(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}
*/

/*
 *============================================
 *  假定一个购物应用显示各种出售的产品，并在购物车中维护想购买的物品
 *============================================
 */

import 'package:flutter/material.dart';

class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

// 定义一个用于展示的类
// ShoppingListItem widget 遵循无状态 widget 的通用模式。
// 它将构造函数中接受到的值存储在 final 成员变量中，然后在 build() 函数中使用它们。
// 例如，inCart 布尔值使两种样式进行切换：一个使用当前主题的主要颜色，另一个使用灰色。
class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts
    // of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

// 当用户点击列表中的一项，widget 不会直接改变 inCart 的值，而是通过调用从父 widget 接收到的 onCartChanged 函数。
// 这种方式可以在组件的生命周期中存储状态更长久，从而使状态持久化。
// 甚至，widget 传给 runApp() 的状态可以持久到整个应用的生命周期
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

// 当处理 onCartChanged 回调时，_ShoppingListState 通过增加或删除 _shoppingCart 中的产品来改变其内部状态。
// 为了通知框架它改变了它的内部状态，需要调用 setState()。
// 调用 setState() 会将该 widget 标记为“dirty”（脏的），并且计划在下次应用需要更新屏幕时重新构建它。
// 如果在修改 widget 的内部状态后忘记调用 setState，框架将不知道这个 widget 是“dirty”(脏的)，
// 并且可能不会调用 widget 的 build() 方法，这意味着用户界面可能不会更新以展示新的状态。
// 通过以这种方式管理状态，你不需要编写用于创建和更新子 widget 的单独代码。相反，你只需实现 build 函数，它可以处理这两种情况。
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget
  // appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses the State object
  // instead of creating a new State object.

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, you need to change
      // _shoppingCart inside a setState call to trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
