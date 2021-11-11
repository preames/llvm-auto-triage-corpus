// RUN: clang -std=c++20 -c %s
// XFAIL: *
template <int> using a = decltype([] {});
template <int b> auto c() -> a<b>;
void d() { c<0>; }
