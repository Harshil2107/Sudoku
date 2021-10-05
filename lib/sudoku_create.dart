import 'dart:math';

List<List<int>> createGrid() {
  List<List<int>> list = [[0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0],
                         [0,0,0,0,0,0,0,0,0]];
  Random random = new Random();
  int i = 0;
  while(i < 9) {
    int num = random.nextInt(9) + 1;
    if(check(list,num,i,i)) {
      list[i][i] = num;
      i++;
    }
  }
  solveGrid(list,0,0);
  int num = random.nextInt(15) + 50;
  i = 0;
  while(i < num) {
    int r = random.nextInt(9);
    int c = random.nextInt(9);
    if(list[r][c] != 0) {
      list[r][c] = 0;
      i++;
    }
  }
  
  return list;
}

bool check(List<List<int>> grid, int num, int row ,int col) {
  for(int i = 0; i < 9; i++) {
    if(grid[i][col] == num && row != i) {
      return false;
    }
  }
  
  for(int i = 0; i < 9; i++) {
    if(grid[row][i] == num && col != i) {
      return false;
    }
  }
  int subgrid_row = ((row + 1)/3).ceil();
  int subgrid_col = ((col + 1)/3).ceil();
  for(int i = (subgrid_row - 1 ) * 3; i < (subgrid_row) * 3; i++) {
    for(int j = (subgrid_col - 1) * 3; j < (subgrid_col) * 3; j++) {
      if(grid[i][j] == num && row != i && col != j) {
        return false;
      }
    }
  }
  
  return true;
}


bool solveGrid(List<List<int>> grid,int row,int col) {
  
  if(col > 8) {
    row++;
    col = 0;
  }
  
  if(row > 8) {
    return true;
  }
 
  if(grid[row][col] == 0) {
    for(int i = 1; i <= 9; i++) {
      if(check(grid, i, row, col)) {
        grid[row][col] = i;
        if(solveGrid(grid,row,col+1)) {
          return true;
        }
        grid[row][col] = 0;
      }
    }
  } else {
     if(solveGrid(grid,row,col+1)) {
          return true;
        }
  }
  return false;
}

String getVal(List<List<int>> grid,int r, int c) {
  if (grid[r][c] != 0)
    return grid[r][c].toString();
  else
    return '';
}