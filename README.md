
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

| Size     | Compare | Title                        |
|----------|---------|------------------------------|
| 135.8 KB | --      | `class feature (perl: 5.038000)` |
| 148.5 KB | 9.3%    | `bless arrayref`               |
| 171.9 KB | 26.6%   | `Object::Pad@0.79`             |
| 218.8 KB | 61.1%   | `Object::Tiny@1.09`            |
| 218.8 KB | 61.1%   | `Mouse@v2.5.10`                |
| 218.8 KB | 61.1%   | `Class::Accessor::Lite@0.08`   |
| 218.8 KB | 61.1%   | `Class::Tiny@1.008`            |
| 218.8 KB | 61.1%   | `bless hashref`                |
| 218.8 KB | 61.1%   | `Moo@2.005004`                 |
| 257.9 KB | 89.9%   | `Moose@2.2206`                 |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                            |
| ---    | ---     | ---                              |
| 545/s  | -57%    | `Class::Tiny@1.008`              |
| 739/s  | -42%    | `Moose@2.2206`                   |
| 777/s  | -39%    | `Moo@2.005004`                   |
| 807/s  | -37%    | `Object::Pad@0.79`               |
| 977/s  | -24%    | `Mouse@v2.5.10`                  |
| 1280/s | --      | `class feature (perl: 5.038000)` |
| 1321/s | 3%      | `bless arrayref`                 |
| 1410/s | 10%     | `Class::Accessor::Lite@0.08`     |
| 1493/s | 17%     | `Object::Tiny@1.09`              |
| 1534/s | 20%     | `bless hashref`                  |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate     | Compare | Title                            |
| ---      | ---     | ---                              |
| 85163/s  | -40%    | `Object::Pad@0.79`               |
| 103322/s | -27%    | `Class::Accessor::Lite@0.08`     |
| 117507/s | -17%    | `Class::Tiny@1.008`              |
| 118154/s | -17%    | `bless hashref`                  |
| 120250/s | -15%    | `Moose@2.2206`                   |
| 130326/s | -8%     | `Moo@2.005004`                   |
| 132332/s | -7%     | `bless arrayref`                 |
| 141835/s | --      | `class feature (perl: 5.038000)` |
| 159288/s | 12%     | `Object::Tiny@1.09`              |
| 229681/s | 62%     | `Mouse@v2.5.10`                  |

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).
