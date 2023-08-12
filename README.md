# What's this?

[In Perl 5.38, the class feature was integrated into the core](https://metacpan.org/release/RJBS/perl-5.38.0/view/pod/perldelta.pod), so I compared it with many class builders. 
The class feature is still in the experimental stage, so I think the results may change depending on future development. 
In the following execution environment, the class feature had the best memory efficiency, and the results of the constructor of an object and access to object fields are equivalent to those of objects blessed with array references.

<details>
  <summary>Execution Environment</summary>

  <pre>
  ❯ inxi -SCm
  System:
    Host: kfly8.local Kernel: 22.3.0 arch: arm64 bits: 64 Console: s004 OS: Darwin 22.3.0
  Memory:
    System RAM: total: N/A available: N/A used: N/A
    RAM Report: missing: Required tool dmidecode not installed. Check --recommends
  CPU:
    Info: 10-core model: Apple M2 Pro bits: 64 type: MCP
    Speed: N/A min/max: N/A cores: No OS support for core speeds.
  </pre>
</details>

## Benchmark memory size

| Size     | Compare | Title                        |
|----------|---------|------------------------------|
| 135.8 KB | --      | class feature (perl: 5.038000) |
| 148.5 KB | 9.3%    | bless arrayref               |
| 171.9 KB | 26.6%   | Object::Pad@0.79             |
| 218.8 KB | 61.1%   | Object::Tiny@1.09            |
| 218.8 KB | 61.1%   | Mouse@v2.5.10                |
| 218.8 KB | 61.1%   | Class::Accessor::Lite@0.08   |
| 218.8 KB | 61.1%   | Class::Tiny@1.008            |
| 218.8 KB | 61.1%   | bless hashref                |
| 218.8 KB | 61.1%   | Moo@2.005004                 |
| 257.9 KB | 89.9%   | Moose@2.2206                 |

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

| Rate   | Compare | Title                          |
| ---    | ---     | ---                            |
| 86.1/s | -96%    | Moose@2.2206                   |
| 763/s  | -67%    | Class::Tiny@1.008              |
| 1309/s | -44%    | Object::Pad@0.79               |
| 1395/s | -40%    | Moo@2.005004                   |
| 1896/s | -18%    | Mouse@v2.5.10                  |
| 2262/s | -3%     | bless arrayref                 |
| 2327/s | --      | class feature (perl: 5.038000) |
| 2560/s | 10%     | Class::Accessor::Lite@0.08     |
| 2595/s | 12%     | bless hashref                  |
| 2715/s | 17%     | Object::Tiny@1.09              |

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

| Rate     | Compare | Title                          |
| ---      | ---     | ---                            |
| 79644/s  | -35%    | Object::Pad@0.79               |
| 92839/s  | -24%    | Class::Accessor::Lite@0.08     |
| 113778/s | -7%     | Moo@2.005004                   |
| 114688/s | -6%     | Moose@2.2206                   |
| 115924/s | -5%     | bless hashref                  |
| 118154/s | -4%     | Class::Tiny@1.008              |
| 120302/s | -2%     | bless arrayref                 |
| 122530/s | --      | class feature (perl: 5.038000) |
| 142175/s | 16%     | Object::Tiny@1.09              |
| 208523/s | 70%     | Mouse@v2.5.10                  |


This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).

