%Program to make an approximation to the flops a computer has. In
%computing, FLOPS (or flops or flop/s) is an acronym meaning FLoating point 
%Operations Per Second. The FLOPS is a measure of a computer's performance, 
%especially in fields of scientific calculations that make heav
%y use of floating point calculations, similar to instructions per second.

%In this case only the products are going to be taken into account, instead
%the instructions per second. The study does not pretend to be a reference
%to study the performance of a computer, because, as it is well known, the
%computer performance depend on the operative system, quantity of memory,
%Size of cache memory, type of processor, Bus speed, Matlab version ...

%To obtain the number of product the computer is able to do, a formula is
%obtain counting the number of product needed to make a matrix gauss
%triangulation. flops = n*(n^2 - 1)/3 + n*(n-1)/2 + n*(n+1)/2. The
%computational time is measured and the flops per second found.

%A second method will be used, knowing the fact that to multiplicate two
%matrix the number of products needed is n^3, where n is the size of a
%square matrix.

%To obtain a value we can realise on, at least a bit, we take an average
%from 10 linear systems solutions. Linear systems are obtained with the 
%order rand.

%Nicolás Gutiérrez Vázquez
%KTH (Kungliga Tekniska Högskolan) Stockholm. 8th April 2009

%My computer (centrino (one core) 1.7Ghz, 1Gbyte RAM, Matlab 7.4),has around 600 Megaflops. 
%% Initializing vectors
disp(' ')
disp('The pogram is calculating the flops your computer is able to do.')
disp('This operation could take from few seconds to few minutes, please,')
disp('be patient, if the solution is taking to much time press Ctrl+C')
disp(' ')

clear
close all

%First method
n = 5000;                                           %Size of the square matrix
cases = 10;
time = zeros(1,2*cases);                            %Time solvin each matrix 
flopsgauss = n*(n^2 - 1)/3 + n*(n-1)/2 + n*(n+1)/2; %flops needed to solve each matrix
flopsproduct = n^3;                                 %Number of cases we want to run

%% Loop and calcuations
% Gauss method
for j=1:cases
   A = 100*rand(n); 
   b = 100*rand(n,1); 
   disp(['Working on Gauss case: ' num2str(j)])
   time(j) = cputime;
   Solution = A\b;
   time(j) = cputime - time(j);
end
flopscases = flopsgauss./time(1:cases);
computer_flops = mean(flopscases);
totaltime = sum(time(1:cases));
megaflops = computer_flops/1e6;

% Multiplication method
for j=1:cases
    A = 100*rand(n);
    b = 100*rand(n);
    disp(['Working on Product case: ' num2str(j)])
    time(cases+j) = cputime;
    C = A*b;
    time(cases+j) = cputime - time(cases+j);
end
flopsprod = flopsproduct./time(cases+1 : 2*cases);
computer_flops2 = mean(flopsprod);
totaltime2 = sum(time(cases+1 : 2*cases));
megaflops2 = computer_flops2/1e6;

average = mean([megaflops megaflops2]);

%% Plotting results
format long
disp(['Total time used: ' num2str(sum(time)) ' s'])
disp(' ')
disp('Results from Gauss triangulation:')
disp(['The total time was: ' num2str(totaltime) ' s'])
disp(['Your computer is able to do: ' num2str(megaflops) ' Megaflops']);
disp(' ')
disp('Results from product calculation:')
disp(['The total time was: ' num2str(totaltime2) ' s'])
disp(['Your computer is able to do: ' num2str(megaflops2) ' Megaflops'])
disp(' ')
disp(' ')
disp(['The average value is: ' num2str(average) ' Megaflops'])
disp(' ')

figure(1);clf
bar(time(1:cases))
grid on
title(['Time to solve each: ' num2str(n) ' x ' num2str(n) ' system'])
xlabel('Case')
ylabel('Time [s]')

figure(2);clf
hold on
bar(flopscases/1e6,'r')
plot(0:n , megaflops*ones(1,n+1) ,'k')
grid on
axis([0 cases+1 0.95*megaflops 1.05*megaflops])
title('Megaflops in each case for gauss (in black the average)')
xlabel('Case')
ylabel('Megaflops')

figure(3);clf
bar(time(cases+1:2*cases),'y')
grid on
title(['Time to solve each each ' num2str(n) ' square matrix multiplication'])
xlabel('Case')
ylabel('Time [s]')

figure(4);clf
hold on
bar(flopsprod/1e6,'r')
plot(0:n , megaflops2*ones(1,n+1) ,'k')
grid on
axis([0 cases+1  0.95*megaflops2 1.05*megaflops2])
title('Megaflops in each case for product (in black the average)')
xlabel('Case')
ylabel('Megaflops')
