use std::num::Wrapping;

pub struct Xoshiro256 {
  state: [Wrapping<u64>; 4],
}

impl Xoshiro256 {
  pub fn new(seed: [u64; 4]) -> Self { Self { state: seed.map(Wrapping) } }

  pub fn next(&mut self) -> u64 {
    let result = (self.state[0] + self.state[3]).0;
    let t = (self.state[1] << 17).0;
    self.state[2] ^= self.state[0];
    self.state[3] ^= self.state[1];
    self.state[1] ^= self.state[2];
    self.state[0] ^= self.state[3];
    self.state[2] ^= Wrapping(t);
    self.state[3] = Wrapping(self.state[3].0.rotate_left(45));
    result
  }
}

fn main() {
  let seed = [
    0x123456789abcdef0,
    0xfedcba9876543210,
    0xdeadbeefcafebabe,
    0xbadc0ffee0ddf00d
  ];
  let mut rng = Xoshiro256::new(seed);
  for _ in 0..50 {
    println!("0x{:0>16x}", rng.next());
  }
}
