import 'package:flutter/material.dart';

void main() {
  runApp(const TestandoPreferencias());
}

class TestandoPreferencias extends StatelessWidget {
  const TestandoPreferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF586C61)
        ),
      ),
      home: const Preferencias(title: 'testando preferencias'),
    );
  }
}

class Preferencias extends StatefulWidget {
  const Preferencias({super.key, required this.title});

  final String title;

  @override
  State<Preferencias> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Preferencias> {
  final List<Map> items = [
    {"nome": "infantil", "foto": "assets/icons_bruno/infantil.png"},
    {"nome": "festas", "foto": "assets/icons_bruno/festas.png"},
    {"nome": "passeios", "foto": "assets/icons_bruno/passeios.png"},
    {"nome": "esportes", "foto": "assets/icons_bruno/spt.png"},
    {"nome": "cursos", "foto": "assets/icons_bruno/cursos.png"},
    {"nome": "pride", "foto": "assets/icons_bruno/pride.png"},
    {"nome": "espiritualidade", "foto": "assets/icons_bruno/espiritualidade.png"},
    {"nome": "tecnologia", "foto": "assets/icons_bruno/tecnologia.png"},
  ];
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF586C61),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0,bottom:30),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromRGBO(47, 69, 56, 1),
              child: IconButton(onPressed: (){


              },    padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.arrow_right_alt_rounded,
                    color:Color.fromRGBO(244, 177, 52, 1),
                    size: 37,
                  )
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left:30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Interesses", style:TextStyle(color:Color.fromRGBO(244, 177, 52, 1),
                fontSize:27,
              ), ),
              Text("Escolha até dois interesses",
                style:TextStyle(color:Color.fromRGBO(252, 239, 237, 1),
                    fontSize: 18
                ),),
            ],
          ),
        ),),
      body:  Container(
        height:height,
        width:width,
        color: Color.fromRGBO(212, 224, 212, 1),
        child:
         GridView.builder(
           padding: EdgeInsets.only(right: 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2,
              crossAxisCount: height > width? 2: 4, // Número de colunas
              mainAxisExtent: 100,
                mainAxisSpacing: 10
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                //leading: Center(child: Icon(Icons.star)),
                title: Center(child:

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    
                    //highlightColor: Colors.yellow,
                    //splashColor: Colors.green[800],

                    onTap: () {
                      selected[index] = !selected[index];
                      int count = selected.where((element) => element).length;
                      if (count > 2) {
                        selected[index] = false;
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selected[index]?Border.all( color: Color.fromARGB(244, 177, 52, 1)):Border(),
                        color:Color.fromRGBO(47, 69, 56, 0.3),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.only(left: 10,),
                      height: 115,
                      width: height>width?145:300,
                      
                      //Color.fromRGBO(47, 69, 56, 0.3),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Image.asset(
                              items[index]["foto"],
                              width: 43,
                              height: 50,
                            ),
                          ),
                          Expanded(child: Align(alignment:Alignment.center, child: Text(items[index]["nome"]))),
/*
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: selected[index]?Colors.yellow:Colors.blueGrey,),),),

 */

                        ],),
                    ),
                  ),
                ),
                ),
              );
            },
          ),
        ),
    );
  }
}











/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map> items = [
    {"nome": "infantil", "foto": "assets/icons/infantil.png"},
    {"nome": "festas", "foto": "assets/icons/festas.png"},
    {"nome": "passeios", "foto": "assets/icons/passeios.png"},
    {"nome": "esportes", "foto": "assets/icons/spt.png"},
    {"nome": "cursos", "foto": "assets/icons/cursos.png"},
    {"nome": "pride", "foto": "assets/icons/pride.png"},
    {"nome": "espiritualidade", "foto": "assets/icons/espiritualidade.png"},
    {"nome": "tecnologia", "foto": "assets/icons/tecnologia.png"},

  ];
  int _counter = 0;
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(items.length, (index) => false);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });


  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
          color:Color.fromRGBO(212, 224, 212, 1),
              child: Image.asset(
                "assets/logo.png",
                cacheWidth: 280,
                cacheHeight:270,
              ),
    );
  }
}

 */



















/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map> items = [
    {"nome": "infantil", "foto": "assets/icons/infantil.png"},
    {"nome": "festas", "foto": "assets/icons/festas.png"},
    {"nome": "passeios", "foto": "assets/icons/passeios.png"},
    {"nome": "esportes", "foto": "assets/icons/spt.png"},
    {"nome": "cursos", "foto": "assets/icons/cursos.png"},
    {"nome": "pride", "foto": "assets/icons/pride.png"},
    {"nome": "espiritualidade", "foto": "assets/icons/espiritualidade.png"},
    {"nome": "tecnologia", "foto": "assets/icons/tecnologia.png"},

  ];
  int _counter = 0;
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(items.length, (index) => false);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });


  }
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color(0xFF586C61),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0,bottom:30),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromRGBO(47, 69, 56, 1),
              child: IconButton(onPressed: (){
                print("escolheu as preferencias");

                },    padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.arrow_right_alt_rounded,
                    color:Color.fromRGBO(244, 177, 52, 1),
                    size: 37,
                  )
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left:30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Interesses", style:TextStyle(color:Color.fromRGBO(244, 177, 52, 1),
              fontSize:27,
              ), ),
              Text("Escolha até dois interesses",
                style:TextStyle(color:Color.fromRGBO(252, 239, 237, 1),
                fontSize: 18
                ),),
            ],
          ),
        ),),
      body:  Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
          color: Color.fromRGBO(212, 224, 212, 1),
        child:
   ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
    return ListTile(
    //leading: Center(child: Icon(Icons.star)),
    title: Center(child:

    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          selected[index] = !selected[index];
          int count = selected.where((element) => element).length;
          if (count > 2) {
            selected[index] = false;
          }
          setState(() {});
          print('Container clicado!');
        },
        child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            height: 100,
            width: 310,
            color: Color.fromRGBO(47, 69, 56, 0.3),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Flexible(
                child: Image.asset(
                  items[index]["foto"],
                  width: 43,
                  height: 50,
                ),
              ),
                Expanded(child: Align(alignment:Alignment.center, child: Text(items[index]["nome"]))),
               Expanded(
                 child: Align(
                   alignment: Alignment.centerRight,
                   child: CircleAvatar(
                        radius: 10,
                        backgroundColor: selected[index]?Colors.yellow:Colors.blueGrey,
                      ),
                 ),
                 ),

            ],),
          ),
        ),
      ),
    ),
    );
    },
    ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


 */