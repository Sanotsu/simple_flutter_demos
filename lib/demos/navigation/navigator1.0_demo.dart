import 'package:flutter/material.dart';

void main() => runApp(Nav4App());

/*
-----------------------------------------------------
匿名路由示例
 */
class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('點擊查看詳情'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailScreen();
              }),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('返回上一層!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

/*
---------------------------------------------------------
 命名路由示例
 */

class Nav3App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen3(),
        '/details': (context) => DetailScreen3(),
      },
    );
  }
}

class HomeScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('點擊看看細節2'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details',
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('返回上一層2!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

/*
---------------------------------------------------------
 使用 onGenerateRoute 的命名路由示例
 */
class Nav4App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
// 这里，settings是RouteSettings的一个实例。
// name和arguments字段是在Navigator.pushNamed()或者initialRoute()设置的值。

      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen4());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen4(id: id));
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}

class HomeScreen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('點擊查看詳情4'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details/1', // 修改這個路由，測試跳轉到主頁、詳情頁、404
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailScreen4 extends StatelessWidget {
  String id;

  DetailScreen4({
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('查看詳情 for item $id'),
            FlatButton(
              child: Text('返回上一層4!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
