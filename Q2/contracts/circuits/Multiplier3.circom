pragma circom 2.0.4; // version 2.0.4 required to support signal assignment when declared

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d;  

   signal ab <== a * b;

   // Constraints.  
   d <== ab * c;  
}

component main = Multiplier3();