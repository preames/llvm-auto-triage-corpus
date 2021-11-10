// RUN: clang -std=c++20 -c %s
// XFAIL: *

template<int N>
using R = decltype([] { return 0; }());

template <int N>
auto you_can_see_me() -> R<N> {
  return {};
}

int main() {
  you_can_see_me<0>();
}
