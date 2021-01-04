import 'package:flutter/material.dart';

void main() => runApp(BooksApp());

/*
 Navigator2.0 Page 的demo

 导航器 在其构造函数中有一个新参数 pages。如果Page对象列表发生更改，Navigator會更新路由堆栈以进行匹配。

 就目前而言，此应用仅使我们能够以声明方式定义页面堆栈。我们无法处理平台的后退按钮，并且在导航时浏览器的URL不会更改。
 */

// 定義用於顯示的 book 類
class Book {
  // 屬性
  final String title;
  final String author;
  // 構造函數
  Book(this.title, this.author);
}

// 主頁面
class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  Book _selectedBook;

// 首頁默認顯示的書籍信息
  List<Book> books = [
    Book('孫子兵法', '孫子'),
    Book('論語', '孔子弟子錄'),
    Book('逍遙游', '莊周'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('BooksListPage'),
            child: BooksListScreen(
              books: books,
              onTapped: _handleBookTapped,
            ),
          ),
          // 如果被選中的書籍不為空，顯示書籍詳情頁
          if (_selectedBook != null) BookDetailsPage(book: _selectedBook)
        ],
        // 當路由返回觸發時執行
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedBook to null
          setState(() {
            _selectedBook = null;
          });

          return true;
        },
      ),
    );
  }

// 當主頁書籍欄位被點擊時，保持被選中書籍狀態
  void _handleBookTapped(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }
}

// 書籍詳情頁（用於顯示書籍詳情區域）
class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}

// 書籍列表顯示區塊（需要傳入選中的書籍 和書籍被選中後的操作）
class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    @required this.books,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}

// 指定書籍詳情顯示區域（需要傳入首頁選中的書籍信息）
class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text("這是《${book.title}》書籍詳情頁面",
                  style: Theme.of(context).textTheme.headline5),
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
