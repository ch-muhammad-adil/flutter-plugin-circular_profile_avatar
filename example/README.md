# example


        class _MyHomePageState extends State<MyHomePage> {
          @override
          Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircularProfileAvatar(
                          radius: 100,
                          backgroundColor: Colors.green,
                          borderWidth: 10,
                          initialsText: Text(
                            "AD",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          borderColor: Colors.brown,
                          elevation: 5.0,
                          onTap: () {
                            print('adil');
                          },
                          imageUrl:
                              'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                      CircularProfileAvatar(
                          radius: 120,
                          backgroundColor: Colors.green,
                          borderWidth: 10,
                          initialsText: Text(
                            "AD",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          borderColor: Colors.yellow,
                          elevation: 5.0,
                          foregroundColor: Colors.yellow.withOpacity(0.5),
                          onTap: () {
                            print('adil');
                          },
                          showInitialTextAbovePicture: true,
                          imageUrl:
                          'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                      CircularProfileAvatar(
                          radius: 70,
                          backgroundColor: Colors.green,
                          initialsText: Text(
                            "AD",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          elevation: 5.0,
                      ),
        
                    ],
                  ),
                ));
          }
        }



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
