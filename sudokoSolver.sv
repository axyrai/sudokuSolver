
typedef bit[3:0] puzzle[9][9];

class sudokoSolver;
  puzzle unsolved;
  rand puzzle solved;
  
  function new(puzzle unsolved);
    this.unsolved = unsolved;
  endfunction
  constraint numberLimit_c
  {
    foreach(solved[i,j])
    {
      solved[i][j] >0;
      solved[i][j] <10;
    }
    
  }
  
  constraint copyData_c
  {
    foreach(unsolved[i,j])
    {
      if(unsolved[i][j]!=0)
        solved[i][j]==unsolved[i][j];
    }
  }
      
  constraint colCompare_c
  {
    foreach(solved[row,col])
    {
      foreach(solved[anotherRow,])
      {
        if(row!=anotherRow)
        {
          solved[row][col] != solved[anotherRow][col]; 
        }
      }
    }
  }
            
   
  constraint rowCompare_c
  {
    foreach(solved[row,col])
    {
      foreach(solved[,anotherCol])
      {
        if(col!=anotherCol)
        {
          solved[row][col] != solved[row][anotherCol]; 
        }
      }
    }
  }
            
  constraint blockCompare_c
  {
    foreach(solved[row,col])
    {
      foreach(solved[anotherRow,anotherCol])
      {
        if(row/3==anotherRow/3 && col/3==anotherCol/3 && !(row==anotherRow && col==anotherCol))
        {
          solved[row][col]!=solved[anotherRow][anotherCol];
        }
                          
      }
    }
  }
  function void displayBeforeSolving();
    $display("Before Solving");
    for(int i=0;i<9;i++)
      begin
        $display("%p",unsolved[i]);
      end
	endfunction

  function void displayAfterSolving();
    $display("After Solving");
    for(int i=0;i<9;i++)
      begin
        $display("%p",solved[i]);
      end
  endfunction
endclass


module top;
  sudokoSolver sudoko;
  
  initial
    begin
      puzzle unsolved = '{'{0,0,0,2,6,0,7,0,1},'{6,8,0,0,7,0,0,9,0},'{1,9,0,0,0,4,5,0,0},'{8,2,0,1,0,0,0,4,0},'{0,0,4,6,0,2,9,0,0},'{0,5,0,0,0,3,0,2,8},'{0,0,9,3,0,0,0,7,4},'{0,4,0,0,5,0,0,3,6},'{7,0,3,0,1,8,0,0,0}};
  
      sudoko=new(unsolved);
      sudoko.randomize();
      sudoko.displayBeforeSolving();
      sudoko.displayAfterSolving();
      
    end
endmodule
