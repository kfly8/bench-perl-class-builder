
## What's this?

[In Perl 5.38, the class feature was integrated into the core](https://metacpan.org/release/RJBS/perl-5.38.0/view/pod/perldelta.pod), so I compared it with many class builders. Ovid, who is main designer of new class feature, blogged the follwing thing:
> Note that it’s not taking anything away from Perl; it’s adding a core object system for better memory consumption, performance, and elegance.
> ( https://ovid.github.io/articles/corinna-in-the-perl-core.html )

The class feature is still in the experimental stage, so I think the results may change depending on future development. 

In the following execution environment, the class feature had the best memory efficiency, and the results of the constructor of an object and access to object fields are equivalent to those of objects blessed with array references.


## Execution Environment

```shell
  ❯ inxi -SCm
  System:
    Host: kfly8.local Kernel: 23.1.0 arch: arm64 bits: 64 Console: s006 OS: Darwin 23.1.0
  Memory:
    System RAM: total: N/A available: N/A used: N/A
    RAM Report: missing: Required tool dmidecode not installed. Check --recommends
  CPU:
    Info: 10-core model: Apple M2 Pro bits: 64 type: MCP
    Speed: N/A min/max: N/A cores: No OS support for core speeds.
```

## Benchmark memory size

| Size     | Compare | Title                                       |
| ---      | ---     | ---                                         |
| 135.8 KB | --      | `class feature (perl: 5.040000)`            |
| 257.9 KB | 89.90%  | `bless arrayref`                            |
| 265.7 KB | 95.60%  | `Object::Pad@0.808`                         |
| 359.5 KB | 164.80% | `Mouse@v2.5.10`                             |
| 359.5 KB | 164.80% | `Moo@2.005005`                              |
| 359.5 KB | 164.80% | `Moose@2.2207 (XSAccessor)`                 |
| 359.5 KB | 164.80% | `Object::Tiny@1.09`                         |
| 359.5 KB | 164.80% | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 359.5 KB | 164.80% | `Class::Tiny@1.008`                         |
| 359.5 KB | 164.80% | `Moose@2.2207`                              |
| 359.5 KB | 164.80% | `bless hashref`                             |
| 359.5 KB | 164.80% | `Class::Accessor::Lite@0.08`                |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                                       |
| ---    | ---     | ---                                         |
| 550/s  | -59%    | `Class::Tiny@1.008`                         |
| 752/s  | -44%    | `Moose@2.2207`                              |
| 752/s  | -44%    | `Moose@2.2207 (XSAccessor)`                 |
| 931/s  | -30%    | `Moo@2.005005`                              |
| 1081/s | -19%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |
| 1152/s | -14%    | `Mouse@v2.5.10`                             |
| 1195/s | -10%    | `Object::Pad@0.808`                         |
| 1334/s | --      | `class feature (perl: 5.040000)`            |
| 1347/s | 1%      | `bless arrayref`                            |
| 1674/s | 25%     | `bless hashref`                             |
| 1690/s | 27%     | `Class::Accessor::Lite@0.08`                |
| 1729/s | 30%     | `Object::Tiny@1.09`                         |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate     | Compare | Title                                       |
| ---      | ---     | ---                                         |
| 93699/s  | -26%    | `Object::Pad@0.808`                         |
| 100485/s | -20%    | `Class::Accessor::Lite@0.08`                |
| 120302/s | -5%     | `Moo@2.005005`                              |
| 123675/s | -2%     | `Class::Tiny@1.008`                         |
| 124842/s | -1%     | `Moose@2.2207`                              |
| 126030/s | --      | `class feature (perl: 5.040000)`            |
| 127242/s | 1%      | `bless hashref`                             |
| 137846/s | 9%      | `bless arrayref`                            |
| 156038/s | 24%     | `Object::Tiny@1.09`                         |
| 223418/s | 77%     | `Moose@2.2207 (XSAccessor)`                 |
| 236307/s | 87%     | `Mouse@v2.5.10`                             |
| 267962/s | 113%    | `Moo@2.005005 (XSConstructor + XSAccessor)` |

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).
