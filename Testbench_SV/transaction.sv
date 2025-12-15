class Transaction;

       bit PGen;
  rand bit [7:0] Din;
  rand bit [1:0] SS;
       bit Run;
       bit Data_in;
       bit Dout;
       

  function void display(string msg);
    $display("--------------%s--------------" , msg);
    $display("Din : %0h   SS : %0h" , Din , SS);
    $display("..............................");
  endfunction       
        

endclass