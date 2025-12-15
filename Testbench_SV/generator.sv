class Generator;

  mailbox gen2drv;
  virtual intf vif;
  
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();
    repeat(5);
    begin
      Transaction trans;
      trans = new();
      trans.randomize();
      
      gen2drv.put(trans);
    end
  endtask

endclass