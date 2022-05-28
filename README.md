# flopcounter
Modern computers are more and more powerful every day. Apart from single
thread performance, the core count is being increased as well in every 
generation. Measuring how powerful a computer is for a specific tasks is
a science in itself called benchmarking: from video processing, CFD, ray
tracing, to gaming the market is full of SW that produce a final single
value that can be compared across machines. 

The main issue with these numbers are that the user has not control over them
and one needs to believe that those reflect properly the ability of a machine
to solve a specific tasks in the minimum amount of time possible. 

In case of calculations, one of the measures commonly used is FLOPS that 
stand for Floating point Operation Per Second. In other words a FLOP is 
normally considered as a floating point multiplication. 

This project aims at providing at approximation to the Flops a machine is able
to cope with. To obtain this number two methods are used:
1) Solve the matrix system A*x = B using factorization of A as P*A = L*U. This
operation required flops are calculated as n*(n^2 - 1)/3 + n*(n-1)/2 + n*(n+1)/2,
where n is the number of rows/columns of the matrix (considering squared matrices).
Number of flops is then divided by the time taken to solve the operation.
2) A second method is based on matrix multiplication. The number of products needed 
in this case is n^3.

n can be chosen in the code to increase complexity and time if required. The operations
are developed several times and averaged to obtain the final result.

Nicolás Gutiérrez Vázquez
developed while in KTH (Kungliga Tekniska Högskolan) Stockholm. 8th April 2009

## Results
An Intel Centrino 1 with one core @ 1.7Ghz, 1 Gbyte RAM, Matlab 7.4 solves __600 Megaflops in 2009__.

An Intel i7 10750H @ 2.60 GHz, 16 Gb Ram, Matlab 9.1.0 solves __10.5 Gigaflops in 2022__.

__This is 17 fold increase in 13 years__. 