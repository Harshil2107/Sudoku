import 'package:flutter/material.dart';
import 'sudoku_create.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MaterialApp(
    home: SudokuSolve(),
  ));
}

class SudokuSolve extends StatefulWidget {
  @override
  _SudokuSolveState createState() => _SudokuSolveState();
}

class _SudokuSolveState extends State<SudokuSolve> {
  List<List<int>> _grid;
  List<List<int>> _isfixed = [[0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0]];
  _SudokuSolveState() {
    _grid = createGrid();
    setFixed();
  }
  void setFixed() {
    for (int i = 0; i < 9; i++)
      for (int j = 0; j < 9; j++)
        if(_grid[i][j] != 0)
          _isfixed[i][j] = 1;
        else
          _isfixed[i][j] = 0;
  }
  Color getColor(int r, int c){
    if(_isfixed[r][c] != 0) 
      return Colors.blue[500];
    else
      return Colors.black;
  }
  void create() {
    setState(() {
      _grid = createGrid();
      setFixed();
    });
  }

  void solve() {
    setState(() {
      solveGrid(_grid, 0, 0);
    });
  }

  EdgeInsets setMargin(int r, int c) {
    double  tb = 0, rb = 0, bb = 0;
    if(r == 1) 
      tb = 2.0;
    if( r % 3 == 0)
      bb = 2.0;
    if( c % 3 == 0)
      rb = 2.0;
    return EdgeInsets.fromLTRB(0, tb, rb, bb);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return Scaffold(
        appBar: AppBar(
          title: Text('Sudoku Solver'),
        ),
        body: Column(children: <Widget>[
          Container(
              color: Colors.black,
              child: GridView.count(
                primary: false,
                padding: EdgeInsets.all(2.0),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 9,
                shrinkWrap: true,
                children: <Widget>[
                  for (int i = 0; i < 9; i++)
                    for (int j = 0; j < 9; j++)
                      Container(
                        margin: setMargin(i+1,j+1),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          getVal(_grid, i, j).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getColor(i, j),
                          ),
                        ),
                        color: Colors.white,
                      ),
                ],
              )),
          Center(
              child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(75, 20, 20, 20),
                  child: RaisedButton(
                      child: Text('Solve'),
                      onPressed: () {
                        solve();
                      })),
              Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                      child: Text('Create New Grid'),
                      onPressed: () {
                        create();
                      })),
            ],
          )),
        ]));
  }
}
