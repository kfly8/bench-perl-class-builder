
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
    Host: kfly8.local Kernel: 22.3.0 arch: arm64 bits: 64 Console: s004 OS: Darwin 22.3.0
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
| 135.8 KB | --      | `class feature (perl: 5.038000)`            |
| 257.9 KB | 89.9%   | `bless arrayref`                            |
| 265.7 KB | 95.6%   | `Object::Pad@0.79`                          |
| 359.5 KB | 164.8%  | `bless hashref`                             |
| 359.5 KB | 164.8%  | `Moo@2.005004`                              |
| 359.5 KB | 164.8%  | `Class::Accessor::Lite@0.08`                |
| 359.5 KB | 164.8%  | `Moose@2.2206`                              |
| 359.5 KB | 164.8%  | `Moo@2.005004 (XSConstructor + XSAccessor)` |
| 359.5 KB | 164.8%  | `Object::Tiny@1.09`                         |
| 359.5 KB | 164.8%  | `Mouse@v2.5.10`                             |
| 359.5 KB | 164.8%  | `Moose@2.2206 (XSAccessor)`                 |
| 359.5 KB | 164.8%  | `Class::Tiny@1.008`                         |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                                       |
| ---    | ---     | ---                                         |
| 473/s  | -61%    | `Class::Tiny@1.008`                         |
| 636/s  | -47%    | `Moose@2.2206`                              |
| 675/s  | -44%    | `Moose@2.2206 (XSAccessor)`                 |
| 720/s  | -40%    | `Object::Pad@0.79`                          |
| 777/s  | -35%    | `Moo@2.005004`                              |
| 1053/s | -12%    | `Moo@2.005004 (XSConstructor + XSAccessor)` |
| 1141/s | -5%     | `Mouse@v2.5.10`                             |
| 1189/s | -1%     | `bless arrayref`                            |
| 1199/s | --      | `class feature (perl: 5.038000)`            |
| 1658/s | 38%     | `bless hashref`                             |
| 1662/s | 39%     | `Class::Accessor::Lite@0.08`                |
| 1690/s | 41%     | `Object::Tiny@1.09`                         |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate     | Compare | Title                                       |
| ---      | ---     | ---                                         |
| 81146/s  | -41%    | `Object::Pad@0.79`                          |
| 97206/s  | -29%    | `Class::Accessor::Lite@0.08`                |
| 111203/s | -19%    | `Moose@2.2206`                              |
| 117507/s | -14%    | `Moo@2.005004`                              |
| 119218/s | -13%    | `bless hashref`                             |
| 121662/s | -11%    | `bless arrayref`                            |
| 130453/s | -4%     | `Class::Tiny@1.008`                         |
| 136532/s | --      | `class feature (perl: 5.038000)`            |
| 165414/s | 21%     | `Object::Tiny@1.09`                         |
| 214369/s | 57%     | `Moose@2.2206 (XSAccessor)`                 |
| 229681/s | 68%     | `Mouse@v2.5.10`                             |
| 273066/s | 100%    | `Moo@2.005004 (XSConstructor + XSAccessor)` |

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).
