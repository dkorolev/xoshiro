#include <iostream>
#include <array>
#include <cstdint>

struct Xoshiro256 {
  using state_t = std::array<uint64_t, 4>;

  state_t state[4];

  static uint64_t rotl(const uint64_t x, int k) {
    return (x << k) | (x >> (64 - k));
  }

  Xoshiro256(state_t seed) : state(seed) {}

  uint64_t next() {
    uint64_t result = state[0] + state[3];
    uint64_t t = state[1] << 17;
    state[2] ^= state[0];
    state[3] ^= state[1];
    state[1] ^= state[2];
    state[0] ^= state[3];
    state[2] ^= t;
    state[3] = rotl(state[3], 45);
    return result;
  }
};

int main() {
  Xoshiro256::state_t state = {
    0x123456789abcdef0, 
    0xfedcba9876543210,
    0xdeadbeefcafebabe,
    0x0badc0ffee0ddf00d
  };

  Xoshiro256 rng(seed);

  for (int i = 0; i < 50; i++) {
    std::cout << rng.next() << std::endl;
  }

  return 0;
}
