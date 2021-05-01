import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// DATA
const List<Map<String, String>> books = [
  {
    'id': '1',
    'title': 'Stranger in a Strange Land',
    'author': 'Robert A. Heinlein',
  },
  {
    'id': '2',
    'title': 'Foundation',
    'author': 'Isaac Asimov',
  },
  {
    'id': '3',
    'title': 'Fahrenheit 451',
    'author': 'Ray Bradbury',
  },
];

const List<Map<String, String>> articles = [
  {
    'id': '1',
    'title': 'Article 1',
    'author': 'Author 1',
  },
  {
    'id': '2',
    'title': 'Article 2',
    'author': 'Author 2',
  },
];

// SCREENS
class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Recommended"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> book = books[index];
                return ListTile(
                  title: Text(book['title']),
                  subtitle: Text(book['author']),
                  onTap: () => Beamer.of(context).currentLocation.update(
                    (state) => state.copyWith(
                      pathBlueprintSegments: ['books', ':bookId'],
                      pathParameters: {'bookId': book['id']},
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({
    this.bookId,
  }) : book = books.firstWhere((book) => book['id'] == bookId);

  final String bookId;
  final Map<String, String> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book: ${book['title']}')),
      body: Text('Author: ${book['author']}'),
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Articles')),
      body: Column(
        children: [
          Container(
            height: 40.0,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: 150.0,
                  child: Text("Recommended"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> article = articles[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['author']),
                  onTap: () => Beamer.of(context).currentLocation.update(
                    (state) => state.copyWith(
                      pathBlueprintSegments: [
                        'articles',
                        ':articleId'
                      ],
                      pathParameters: {'articleId': article['id']},
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleDetailsScreen extends StatelessWidget {
  ArticleDetailsScreen({
    this.articleId,
  }) : article = articles.firstWhere((article) => article['id'] == articleId);

  final String articleId;
  final Map<String, String> article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article: ${article['title']}')),
      body: Text('Author: ${article['author']}'),
    );
  }
}

// LOCATIONS
class HomeLocation extends BeamLocation {
  HomeLocation(state) : super(state);

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('app-${state.uri}'),
          child: AppScreen(beamState: state),
        ),
      ];
}

class BooksLocation extends BeamLocation {
  BooksLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/books/:bookId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('books'),
          child: BooksScreen(),
        ),
        if (state.pathParameters.containsKey('bookId'))
          BeamPage(
            key: ValueKey('book-${state.pathParameters['bookId']}'),
            child: BookDetailsScreen(
              bookId: state.pathParameters['bookId'],
            ),
          ),
      ];
}

class ArticlesLocation extends BeamLocation {
  ArticlesLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/articles/:articleId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('articles'),
          child: ArticlesScreen(),
        ),
        if (state.pathParameters.containsKey('articleId'))
          BeamPage(
            key: ValueKey('articles-${state.pathParameters['articleId']}'),
            child: ArticleDetailsScreen(
              articleId: state.pathParameters['articleId'],
            ),
          ),
      ];
}


// APP
class AppScreen extends StatefulWidget {
  AppScreen({this.beamState});

  final BeamState beamState;

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _routerDelegates = [
    BeamerRouterDelegate(
      locationBuilder: (state) => ArticlesLocation(state),
    ),
    BeamerRouterDelegate(
      locationBuilder: (state) => BooksLocation(state),
    ),
  ];

  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.beamState.uri.path.contains('books') ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Beamer(routerDelegate: _routerDelegates[0]),
          Beamer(routerDelegate: _routerDelegates[1]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(label: 'A', icon: Icon(Icons.article)),
          BottomNavigationBarItem(label: 'B', icon: Icon(Icons.book)),
        ],
        onTap: (index) {
          if (_currentIndex == index) {
            _routerDelegates[_currentIndex].beamToNamed(widget.beamState.uri.path);
          } else {
            setState(() => _currentIndex = index);
            _routerDelegates[_currentIndex].parent?.updateRouteInformation(
                _routerDelegates[_currentIndex].currentLocation.state.uri,
            );
          }
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final beamerRouter = BeamerRouterDelegate(
        locationBuilder: (state) => HomeLocation(state));

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: beamerRouter,
    );
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}
