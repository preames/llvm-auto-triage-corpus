// RUN: clang -std=c++20 -c %s
// XFAIL: *
struct b {
  consteval b() {}
  union {
    int a;
    struct {
    } c{};
  };
};
void d() { b(); }
