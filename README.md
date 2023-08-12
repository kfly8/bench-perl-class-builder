# What's this?

[In Perl 5.38, the class feature was integrated into the core](https://metacpan.org/release/RJBS/perl-5.38.0/view/pod/perldelta.pod), so I compared it with many class builders. 
The class feature is still in the experimental stage, so I think the results may change depending on future development. 
In the following execution environment, the class feature had the best memory efficiency, and the results of the constructor of an object and access to object fields are equivalent to those of objects blessed with array references.

<details>
  <summary>Execution Environment</summary>
  <pre>
  Perl: 5.038000
  Object::Pad: 0.79
  Class::Accessor::Lite: 0.08
  Mouse: v2.5.10
  Moo: 2.005004
  Moose: 2.2206
  Class::Tiny: 1.008
  Object::Tiny: 1.09
  </pre>

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

```tsv
total_size	size_rate
135.8 KB	--	class feature
148.5 KB	9.3%	bless arrayref
171.9 KB	26.6%	Object::Pad
218.8 KB	61.1%	Object::Tiny
218.8 KB	61.1%	Moo
218.8 KB	61.1%	Class::Tiny
218.8 KB	61.1%	Mouse
218.8 KB	61.1%	Class::Accessor::Lite
218.8 KB	61.1%	bless hashref
257.9 KB	89.9%	Moose
```

This result were calculated using [bench-size.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-size.pl).

## Benchmark object constructors

```tsv
Rate	class feature
87.7/s	-96%	Moose
752/s	-67%	Class::Tiny
1291/s	-43%	Object::Pad
1395/s	-38%	Moo
1846/s	-18%	Mouse
2262/s	--	class feature
2262/s	0%	bless arrayref
2512/s	11%	Class::Accessor::Lite
2570/s	14%	bless hashref
2644/s	17%	Object::Tiny
```

This result were calculated using [bench-new.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-new.pl).

## Benchmark access to object fields

```tsv
Rate	class feature
79644/s	-35%	Object::Pad
91995/s	-25%	Class::Accessor::Lite
114840/s	-6%	Moo
114841/s	-6%	Moose
117028/s	-4%	bless hashref
118154/s	-4%	Class::Tiny
122530/s	--	class feature
123675/s	1%	bless arrayref
146161/s	19%	Object::Tiny
208523/s	70%	Mouse
```

This result were calculated using [bench-field.pl](https://github.com/kfly8/bench-perl-class-builder/blob/main/bench-field.pl).

