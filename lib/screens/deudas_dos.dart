import 'package:deduasql/custom/customShape.dart';
import 'package:deduasql/screens/ingreso_deudas.dart';
import 'package:deduasql/screens/login.dart';
import 'package:deduasql/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDeudas2 extends StatefulWidget {
  const MyDeudas2({super.key});

  @override
  State<MyDeudas2> createState() => _MyDeudas2();
}

class _MyDeudas2 extends State<MyDeudas2> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _controller;
  late String user_id;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    final User? user = _auth.currentUser;
    if (user != null) {
      user_id = user.uid;
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyLogin(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void doNothing(BuildContext context) {}
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  Future<bool?> toast(String message) {
    //Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.inversePrimary, //Colors.red,
            child: Center(
                child: Text(
              "DEUDAS QL",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        /* title: Text(
            "DEUDAS QL",
            style: Theme.of(context).textTheme.labelMedium,
          ), */
        actions: <Widget>[
          Card(
              elevation: 8.0,
              child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(236, 236, 236, 142)),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 74, 8, 216),
                    ),
                    onPressed: () {
                      // do something
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => IngresoDeudas(),
                        ),
                      );
                    },
                  )))
        ],
      ),
      body: FutureBuilder(
        future: getDeudasUser(user_id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  //return Text(snapshot.data?[index]['nombre_deuda']);
                  return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(236, 236, 236, 142)),
                          child: Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              //dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) {
                                    eliminar(snapshot.data![index].id);
                                    setState(() {
                                      getDeudasAll();
                                    });
                                    toast("Deuda Eliminada");
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Eliminar',
                                ),
                                /* SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ), */
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: (context) {
                                    pagar(snapshot.data![index].id,
                                        snapshot.data![index].n_cuota);
                                    setState(() {
                                      getDeudasAll();
                                    });
                                  },
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Pagar',
                                ),
                                /* SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Save',
                                ), */
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child: Icon(Icons.monetization_on,
                                    color: Color.fromARGB(255, 39, 33, 33)),
                              ),
                              title: Text(
                                  snapshot.data![index].nombre_deuda.toString(),
                                  style: TextStyle(color: Colors.black)),
                              subtitle: Row(
                                children: <Widget>[
                                  Icon(Icons.linear_scale,
                                      color: Colors.black54),
                                  Text(
                                      "Cuotas Restantes: " +
                                          snapshot.data![index].n_cuota
                                              .toString(),
                                      style: TextStyle(color: Colors.black54))
                                ],
                              ),
                            ),
                          )));
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_new_rounded),
            label: 'Cerrar Sesión',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 74, 8, 216),
        onTap: (int index) async {
          switch (index) {
            case 0:
              // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                if (_homeController.hasClients) {
                  _homeController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                }
              }
            case 1:
              showModal(context);
              final User? user = await _auth.currentUser;
              if (user == null) {
//6
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('No one has signed in.'),
                ));
                return;
              }
              await _auth.signOut();
              final String uid = user.uid;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(uid + 'Haz Cerrado Sesión Exitosamente.'),
              ));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyLogin(),
                ),
              );
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),

      /* body: Center(
        child: Text("TEXTO", style: Theme.of(context).textTheme.displayMedium,)
        ), */
    );
  }
}
