pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    // Calculate matrix A multiplied by matrix x
    component Ax = matMul(n, n, 1);
    for (var i=0; i<n; i++) {
        for (var j=0; j<n; j++) {
            Ax.a[i][j] <== A[i][j];
        }
        Ax.b[i][0] <== x[i];
    }

    // Check Ax = b, combining element results with logical AND
    component eq[n];
    signal result[n+1]; // require an array of signal due to quadratic requirement
    result[0] <== 1; // Initialize first element to 1 so it can be AND'ed with output of "IsEqual"
    for (var i=0; i<n; i++) {
        eq[i] = IsEqual();
        eq[i].in[0] <== Ax.out[i][0];
        eq[i].in[1] <== b[i];
        result[i+1] <== result[i] * eq[i].out; // multiplication is same as logical AND when all inputs are either 0 or 1
    }

    // Last element of array indicates all values in "Ax" equals the corresponding ones in "b"
    out <== result[n];
}

component main {public [A, b]} = SystemOfEquations(3);