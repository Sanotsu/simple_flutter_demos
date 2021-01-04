// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 主函数（main）使用了 (=>) 符号，这是 Dart 中单行函数或方法的简写。
void main() => runApp(MyApp());

// 该应用程序继承了 StatelessWidget，这将会使应用本身也成为一个 widget。
// 在 Flutter 中，几乎所有都是 widget，包括对齐 (alignment)、填充 (padding) 和布局 (layout)。
// Stateless widgets 是不可变的，这意味着它们的属性不能改变 —— 所有的值都是 final。
class MyApp extends StatelessWidget {
  // 一个 widget 的主要工作是提供一个 build() 方法来描述如何根据其他较低级别的 widgets 来显示自己。
  @override
  Widget build(BuildContext context) {
    // english_words 隨機生成英文单词对(倆英文單詞)
    // final wordPair = WordPair.random();

    return MaterialApp(
      // title: 'Welcome to Flutter',
      // // Scaffold 是 Material 库中提供的一个 widget，它提供了默认的导航栏、标题和包含主屏幕 widget 树的 body 属性。 widget 树可以很复杂。
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Welcome to Flutter'),
      //   ),
      //   // body 的 widget 树中包含了一个 Center widget，
      //   // Center widget 又包含一个 Text 子 widget， Center widget 可以将其子 widget 树对齐到屏幕中心。
      //   body: Center(
      //     // 「大驼峰式命名法」也称为 upper camel case 或 Pascal case，表示字符串中的每个单词（包括第一个单词）都以大写字母开头。
      //     // 所以，uppercamelcase 会变成 UpperCamelCase。
      //     // child: Text(wordPair.asPascalCase),

      //     child: RoandomWords(),
      //   ),
      // ),

      title: 'Startup Name Generator',
      /* 
      Flutter 里我们使用 theme 来控制你应用的外观和风格，
      你可以使用默认主题，该主题取决于物理设备或模拟器，也可以自定义主题以适应您的品牌。
      你可以通过配置 ThemeData 类轻松更改应用程序的主题，目前我们的应用程序使用默认主题，下面将更改 primaryColor 颜色为 紅色
      */
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: RandomWords(),
    );
  }
}

/* 
Stateless widgets 是不可变的，这意味着它们的属性不能改变 —— 所有的值都是 final。
 Stateful widgets 持有的状态可能在 widget 生命周期中发生变化，
 实现一个 stateful widget 至少需要两个类：
    1）一个 StatefulWidget 类；
    2）一个 State 类，
 StatefulWidget 类本身是不变的，但是 State 类在 widget 生命周期中始终存在。
*/
// 添加一个 stateful widget（有状态的 widget）—— RandomWords，
// 它会创建自己的状态类 —— _RandomWordsState，
// 然后你需要将 RandomWords 内嵌到已有的无状态的 MyApp widget。
class RandomWords extends StatefulWidget {
  // dart 語法，下劃線開頭表示私有
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // 向 _RandomWordsState 类中添加一个 _suggestions 列表以保存建议的单词对，
  // 同时，添加一个 _biggerFont 变量来增大字体大小。

  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  /*
   添加一个 _saved Set（集合）到 RandomWordsState，这个集合存储用户喜欢（收藏）的单词对。 
   在这里，Set 比 List 更合适，因为 Set 中不允许重复的值。
  */
  final Set<WordPair> _saved = new Set<WordPair>();

  /*
  在 Flutter 中，导航器管理应用程序的路由栈。
  将路由推入（push）到导航器的栈中，将会显示更新为该路由页面。 
  从导航器的栈中弹出（pop）路由，将显示返回到前一个路由。
  */
  //（当用户点击导航栏中的列表图标时）我们会建立一个路由并将其推入到导航管理器栈中。
  // 此操作会切换页面以显示新路由，新页面的内容会在 MaterialPageRoute 的 builder 属性中构建，builder 是一个匿名函数。
  void _pushSaved() {
    // 添加 Navigator.push 调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(
      // 添加 MaterialPageRoute 及其 builder。
      // 现在，添加生成 ListTile 行的代码，ListTile 的 divideTiles() 方法在每个 ListTile 之间添加 1 像素的分割线。
      // 该 divided 变量持有最终的列表项，并通过 toList()方法非常方便的转换成列表显示。
      new MaterialPageRoute<void>(
        // builder 返回一个 Scaffold，其中包含名为"Saved Suggestions"的新路由的应用栏。
        // 新路由的body 由包含 ListTiles 行的 ListView 组成；每行之间通过一个分隔线分隔。
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            // 添加水平分隔符，如下代码所示：
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

// 向 _RandomWordsState 类添加一个 _buildSuggestions() 方法，此方法构建显示建议单词对的 ListView。
/*
ListView 类提供了一个名为 itemBuilder 的 builder 属性，
这是一个工厂匿名回调函数，接受两个参数 BuildContext 和行迭代器 i。
迭代器从 0 开始，每调用一次该函数 i 就会自增，每次建议的单词对都会让其递增两次，
一次是 ListTile，另一次是 Divider。它用于创建一个在用户滚动时候无限增长的列表。
*/
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        /*
         对于每个建议的单词对都会调用一次 itemBuilder，然后将单词对添加到 ListTile 行中。
         在偶数行，该函数会为单词对添加一个 ListTile row，
         在奇数行，该函数会添加一个分割线的 widget，来分隔相邻的词对。
         注意，在小屏幕上，分割线看起来可能比较吃力。
         */
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线 widget。
          if (i.isOdd) return Divider();
          /*
          语法 i ~/ 2 表示 i 除以 2，但返回值是整形（向下取整），
          比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，
          这个可以计算出 ListView 中减去分隔线后的实际单词对数量。
          */
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            // 如果是建议列表中最后一个单词对，接着再生成10个单词对，然后添加到建议列表。
            _suggestions.addAll(generateWordPairs().take(10));
          }
          // 对于每一个单词对，_buildSuggestions() 都会调用一次 _buildRow()。
          // 这个函数在 ListTile 中显示每个新词对，这使你在下一步中可以生成更漂亮的显示行
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    // 在 _buildRow 方法中添加 alreadySaved 来检查确保单词对还没有添加到收藏夹中。
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // 同时在 _buildRow() 中， 添加一个心形 ❤️图标到 ListTiles以启用收藏功能。接下来，你就可以给心形 ❤️图标添加交互能力了。
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      /*
       在 _buildRow 中让心形 ❤️图标变得可以点击。
       如果单词条目已经添加到收藏夹中， 再次点击它将其从收藏夹中删除。
       当心形 ❤️图标被点击时，函数调用 setState() 通知框架状态已经改变。
       */
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    // 更新 _RandomWordsState 的 build() 方法以使用 _buildSuggestions()，而不是直接调用单词生成库
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        // 在 RandomWordsState 的 build 方法中为 AppBar 添加一个列表图标。
        // 当用户点击列表图标时，包含收藏夹的新路由页面入栈显示。
        // 提示: 某些 widget 属性需要单个 widget（child），而其它一些属性，
        // 如 action，需要一组widgets（children），用方括号 [] 表示。
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
