
## What's this?

[In Perl 5.38, the class feature was integrated into the core](https://metacpan.org/release/RJBS/perl-5.38.0/view/pod/perldelta.pod), so I compared it with many class builders. Ovid, who is main designer of new class feature, blogged the following:
> Note that it’s not taking anything away from Perl; it’s adding a core object system for better memory consumption, performance, and elegance.
> ( https://ovid.github.io/articles/corinna-in-the-perl-core.html )

The class feature is still in the experimental stage, so I think the results may change depending on future development. 

In the following execution environment, the class feature had the best memory efficiency, and the results of the constructor of an object and access to object fields are equivalent to those of objects blessed with array references.


## Execution Environment

The following benchmarks run on GitHub Actions, workflow file: [benchmark-debian-trixie.yml](https://github.com/kfly8/bench-perl-class-builder/blob/main/.github/workflows/benchmark-debian-trixie.yml)

## Benchmark memory size

| Size     | Compare | Title                                       |
| -------- | ------- | ------------------------------------------- |
| 163.1 KB | --      | `class feature (perl: 5.042000)`            |
| 257.9 KB | 58.1%   | `bless arrayref`                            |
| 265.7 KB | 62.9%   | `Object::Pad@0.823`                         |
| 359.5 KB | 120.4%  | `Moose@2.4000 (XSAccessor)`                 |
| 359.5 KB | 120.4%  | `Object::Tiny@1.09`                         |
| 359.5 KB | 120.4%  | `Class::Accessor::Lite@0.08`                |
| 359.5 KB | 120.4%  | `Class::Tiny@1.008`                         |
| 359.5 KB | 120.4%  | `Moo@2.005005`                              |
| 359.5 KB | 120.4%  | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 359.5 KB | 120.4%  | `Mojo::Base@9.42`                           |
| 359.5 KB | 120.4%  | `Moose@2.4000`                              |
| 359.5 KB | 120.4%  | `Mouse@v2.6.1`                              |
| 359.5 KB | 120.4%  | `bless hashref`                             |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                                       |
| ------ | ------- | ------------------------------------------- |
| 299/s  | -67%    | `Class::Tiny@1.008`                         |
| 427/s  | -52%    | `Moose@2.4000 (XSAccessor)`                 |
| 435/s  | -51%    | `Moose@2.4000`                              |
| 550/s  | -39%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 555/s  | -38%    | `Moo@2.005005`                              |
| 673/s  | -25%    | `Mouse@v2.6.1`                              |
| 717/s  | -20%    | `Object::Pad@0.823`                         |
| 799/s  | -11%    | `bless arrayref`                            |
| 896/s  | --      | `class feature (perl: 5.042000)`            |
| 975/s  | 9%      | `Mojo::Base@9.42`                           |
| 1037/s | 16%     | `Class::Accessor::Lite@0.08`                |
| 1046/s | 17%     | `bless hashref`                             |
| 1110/s | 24%     | `Object::Tiny@1.09`                         |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate    | Compare | Title                                       |
| ------- | ------- | ------------------------------------------- |
| 24660/s | -24%    | `Object::Pad@0.823`                         |
| 29257/s | -10%    | `Class::Accessor::Lite@0.08`                |
| 31716/s | -2%     | `Moose@2.4000`                              |
| 31717/s | -2%     | `Mojo::Base@9.42`                           |
| 32434/s | --      | `class feature (perl: 5.042000)`            |
| 34909/s | 8%      | `Class::Tiny@1.008`                         |
| 34909/s | 8%      | `Moo@2.005005`                              |
| 41918/s | 29%     | `bless hashref`                             |
| 43442/s | 34%     | `bless arrayref`                            |
| 45081/s | 39%     | `Object::Tiny@1.09`                         |
| 56366/s | 74%     | `Moose@2.4000 (XSAccessor)`                 |
| 61837/s | 91%     | `Mouse@v2.6.1`                              |
| 72404/s | 123%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).