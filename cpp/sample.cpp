#include <iostream>

int fib(int a, int b, int howManyToPrint) {
    if(howManyToPrint > 0) {
        std::cout << b << " ";
        return fib(b, a + b, howManyToPrint - 1);
    } else {
        return b;
    }
}

int main() {
    int first = 1;
    int second = 1;
    std::cout << "This is Max" << std::endl;
    std::cout << "We're going to make a Fibonacci sequence, except you get to choose the two starting numbers. The program will then print out 10 numbers from that sequence" << std::endl;
    std::cout << "Enter your first number:  ";
    std::cin >> first;
    std::cout << "Enter your second number: ";
    std::cin >> second;
    std::cout << first << " " << fib(first, second, 10) << std::endl;
    //This is a loop
    for(int i = 0; i < 10; i++) {
        std::cout << "=";
    }
    std::cout << std::endl;
    return 0;
}
