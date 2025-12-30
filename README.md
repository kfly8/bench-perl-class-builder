
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
| 359.5 KB | 120.4%  | `Mojo::Base@9.42`                           |
| 359.5 KB | 120.4%  | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 359.5 KB | 120.4%  | `Mouse@v2.6.1`                              |
| 359.5 KB | 120.4%  | `Moose@2.4000`                              |
| 359.5 KB | 120.4%  | `bless hashref`                             |
| 359.5 KB | 120.4%  | `Class::Tiny@1.008`                         |
| 359.5 KB | 120.4%  | `Class::Accessor::Lite@0.08`                |
| 359.5 KB | 120.4%  | `Moo@2.005005`                              |
| 359.5 KB | 120.4%  | `Moose@2.4000 (XSAccessor)`                 |
| 359.5 KB | 120.4%  | `Object::Tiny@1.09`                         |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                                       |
| ------ | ------- | ------------------------------------------- |
| 296/s  | -66%    | `Class::Tiny@1.008`                         |
| 426/s  | -51%    | `Moose@2.4000 (XSAccessor)`                 |
| 430/s  | -50%    | `Moose@2.4000`                              |
| 545/s  | -37%    | `Moo@2.005005`                              |
| 545/s  | -37%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 616/s  | -29%    | `Mouse@v2.6.1`                              |
| 697/s  | -19%    | `Object::Pad@0.823`                         |
| 764/s  | -12%    | `bless arrayref`                            |
| 865/s  | --      | `class feature (perl: 5.042000)`            |
| 956/s  | 11%     | `Mojo::Base@9.42`                           |
| 1013/s | 17%     | `Class::Accessor::Lite@0.08`                |
| 1017/s | 18%     | `bless hashref`                             |
| 1056/s | 22%     | `Object::Tiny@1.09`                         |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate    | Compare | Title                                       |
| ------- | ------- | ------------------------------------------- |
| 24435/s | -20%    | `Object::Pad@0.823`                         |
| 27306/s | -11%    | `Class::Accessor::Lite@0.08`                |
| 28444/s | -7%     | `Moose@2.4000`                              |
| 30075/s | -2%     | `Mojo::Base@9.42`                           |
| 30632/s | --      | `class feature (perl: 5.042000)`            |
| 32881/s | 7%      | `Moo@2.005005`                              |
| 33495/s | 9%      | `Class::Tiny@1.008`                         |
| 39821/s | 30%     | `bless hashref`                             |
| 41918/s | 37%     | `bless arrayref`                            |
| 43115/s | 41%     | `Object::Tiny@1.09`                         |
| 54097/s | 77%     | `Moose@2.4000 (XSAccessor)`                 |
| 58513/s | 91%     | `Mouse@v2.6.1`                              |
| 70447/s | 130%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).
