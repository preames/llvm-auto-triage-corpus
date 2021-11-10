// RUN: clang -std=c++20 -c %s
// XFAIL: *

struct S {
  consteval S() {}
  union {
    int a;
    struct { int b; } c = {0};
  };
};
void f() { S(); }
