
This repo is the interface to a service which attempts to automatically
reduce test cases demonstrating LLVM bugs into more actionable forms.  The
service checks all reduction results back into this repo.  As such this
is a corpus of standalone test cases which are known to produce crashes,
or miscompiles when run with a recent snapshot of LLVM.  (See details on
supported failure types below.)

To contribute a test or corpus of tests to be auto-triaged, please post a
pull request. Once (manually) accepted, the automated reducer should have
added reduced examples within roughly 24 hours.  Further usage information
can be found below.

.. contents::

How to use?
-----------

There are three major use cases expected for this repo: one-off bug reduction,
wholesale corpus reduction, and developers looking for bugs to fix.

I've been fuzzing and have a whole bunch of failures!
++++++++++++++++++++++++++++++++++++++++++++++++++++

Great, this is exactly what this service is designed for.  If you have a
collection of failures which are "interesting", and which you can turn into
reasonably short running self contained LIT tests, you should post a PR to
this repo.  Once (manually) merged, you should have results in tree within a
fairly short period.

The "interesting" requirement does require a bunch of knowledge of what
bugs the LLVM project considers worth fixing.  As an example, LLVM generally
does not care about fixing IR parser crashes when fed invalid IR.  As such,
a pull request will a bunch of cases of invalid IR would not be accepted.
On the other hand, a bunch of crashes in LLVM opt passes triggered by valid
IR would be immediately accepted.

The "reasonably short running" bit comes down to practical resourcing
constraints.  See below for current resource requirements.

Depending on the size of the failing corpus, I may ask for some help
reducing duplicates, but this can be handled case by case.  Long term,
the plan is to de-duplicate automatically, but we're not there yet.

I found an clang crash!
+++++++++++++++++++++++

If your starting point is a clang crash during the build of a large project,
this repo is probably not yet of use to you.  Due to resource limits,
reduction is unlikely to make progress on huge input C/C++ files.  Instead,
you're probably better off running creduce locally and then contributing the
result of that.

If you've managed to reduce your input to something which runs quickly and is
self contained, the automation may help with further isolating the failure to
the appropriate part of LLVM.

Longer term, the hope is to find a way to raise the resource limits to make
this a one-step process for reducing clang crashes from the wild, but we're
not there yet.  

Let's fix some llvm bugs!
+++++++++++++++++++++++++

Each of the individual files in the repo should reproduce some crash or
miscompile on recent tip of tree LLVM.  Each test is self describing and
(assuming you're already familiar with LLVM's LIT style testing) should be
pretty straight forward to look at.

Here are some suggestions on how to identify interesting cases to investigate:

* Filter by file size.  Since the repo keeps intermediate reduction results,
  there can be many duplicates of the same issue with test cases of various
  complexity.   It's generally useful to start by looking at the smallest
  tests.
* Filter by pass.  The reducers try to reduce the pass list down to a single
  pass wherever possible.  If you look for e.g. instsimplify bugs, you'll find
  a bunch.  Similarly, we try to isolate analysis crashes and you can grap
  for the corresponding "-analysis -XXX" command line.
* You can also use lit to quickly run any subset of tests to examine output
  (e.g. stack trace or alive2 failure messages).
* The reduction.log contains information about which cases were reduced from
  which inputs.  If you care about fixing e.g. oss-fuzz failures, you can
  prioritize tests reduced from those inputs.

Longer term, there are tentative plans to provide a web-based triage interface
on top of the raw information here, but for the moment, you're on your own!

If during your investigation, you find test cases which have room for further
automated reduction, sharing your observations (or even better filing bugs
with the relevant reduction tool project) would be greatly appreciated.


Test Format
-----------

Each test must be a self describing LIT test.  The intention is that the
test file could be copied into the LLVM test sub-directory and work as
expected. As such, each test should include a header which looks like this:

.. code::

  ; RUN: opt -S -passname < %s
  ; REQUIRES: asserts
  ; XFAIL:

The binary exercised must be either a) an LLVM tool (e.g opt, llc,
or clang), or an alive2 tool (eg. opt-alive.sh, alive-tv).  If using
an alive2 too, the REQUIRES line must list "alive".

Additionally, tests are required to meet certain resource consumption
limits.  These limits are chosen to allow reduction of the whole corpus
to run in a reasonable time on the current hardware resources allocated
to the automation without excessive timeouts (e.g. wasted compute).
Given that, you should expect these limits to change over time.  Tests
which don't meet these limits will be deleted. The current hard limits are:

* Must run to completion in less than 5 minutes.
* Must use less than 2GB of memory.

Current implementation restrictions:

* Only the RUN line is parsed and used by the corpus automation, but all
  comment lines will be preserved during reduction.  You can also use
  comments (e.g. lines starting with ";" to give description of the test
  if desired.
* The current parsing of RUN is rather adhoc, so sticking exactly to this
  example's format is highly recommended.
* At the moment, all tests are assumed to require asserts.

Layout
------

All original tests should be under a named sub-directory.  As an example,
a reproducer taken from OSSFuzz should be placed under the oss_fuzz subdir.
Naming withing these sub-directory is unconstrained.

All other tests (e.g. results from automated reduction efforts) must be in
the root directory with names which correspond to the sha1 hash of the file
contents.

Long term, the use of named sub-directories will probably be removed
entirely and replaced with a metadata file, but for the moment having the
separation is useful for testing as it makes it easy to delete only the
autogenerated files.

Reduction Log
-------------

The file `reductions.log" at the root of the repository contains records
describing previous reductions, and thus allows tracking which tests were
reduced from which inputs.

The format of this file is one json array per line, with each entry currently
having the following fields:

* reducer tag.  This is a name for the reducer.
* input file.  This is the file which was reduced.
* output file.  This was a reduced output from the reducer.

Please be aware that this format is likely to change in the future.

A couple of subtleties to be aware of:

* A single reducer can produce multiple reduced files.  In this case, multiple entries with common values for the first two fields and distinct values for the later will be present.
* A single reducer can produce different reductions over time.  (This happens whenever we improve the reducer and pick up a new version.)  There is currently no way in the log to distinguish this case from the previous.


Supported Failure Types
-----------------------

The automated reducer can currently reduce the following types of failures:

* Crashes and assertion failures.  LLVM is compiled with assertions enabled.
  If the input triggers a crash in a llvm tool, this can be reduced.
* Miscompiles confirmed by alive.  If alive is capable of reporting a
  miscompile with the test input, we can reduce the input to the minimum
  which produces the miscompile.

The automated reducer will reduce *any* failure seen in the test case.  Since
reducers are simply a sub-case of mutation fuzzers, this means that sometimes
the attempted reduction can introduce a new failure cause.  This means that
the reduced test case may fail for a different reason that the original test.

The following failure types can not (yet?) be reduced:

* Any non-IR, non-C/C++ input.  In particular, this means that reducing MIR
  or assembly is not yet supported.
* Sanitizer failures.  The LLVM build exercised does not enable ubsan, asan,
  msan, or tsan.
* Non deterministic failures.  A test which only fails some of the time
  will probably not be successfully reduced.
* Infinite compilations.  Tests which exceed the timeout are discarded, and
  will not be reduced.
* Excess memory usage.  Tests which consume large amounts of memory are
  discarded and will not be reduced.
* Execution failures.  The automation will not run binaries produced from
  user test cases.  As a result, miscompiles resulting in execution failures
  - which can not also be found by alive - can not be reduced.

Supported Reducers
------------------

Currently, the following reducers are supported:

* bugpoint (specifically, its crash reduction mode).  Bugpoint will be used
  to reduce crashes in opt with IR inputs.  Currently crash reduction is
  unconstrained meaning that *any* crash will be reduced.
* llvm-reduce.  llvm-reduce will be used to reduce crashes in LLVM tools, and
  miscompiles reported by alive on IR inputs.  Currently, reduction is
  unconstrained meaning that any failure will be reduced.
* opt-analysis-isolate.  This is a custom reducer which attempts to reproduce
  opt crashes with only analysis printers (i.e. no transformation passes).
  When successful, this makes it clear when a problem exists in an analysis
  as opposed to (possibly many) consumer passes.
* creduce.  creduce will be used to reduce crashes in clang with C/C++ inputs.
  Crash reduction is unconstrained meaning *any* crash will be reduced.  In
  principal, creduce could be applied to other input formats, but initial
  experimentation indicates that the resource cost vs result quality tradeoff
  is not worthwhile.

The results from reducers will be cross fed - i.e. a reduced output from
bugpoint will be further reduced via llvm-reduce and vice-versa.  Note that
it is common to have reductions converge to multiple different maximally
reduced IRs.  That is, the reduction result is often path dependent on the
reduction order chosen.  It can be insightful to compare them.

In the nearish future, the following additions are planned:

* creduce for alive failures.
* clang to opt runline conversion.  Many times we can derive a crashing opt
  test by taking clang's -emit-llvm output and doing a bit of cleanup.
* Constrained reduction of assertion failures.  Blocked by lack of current
  motivating examples.
* Reduction of MIR issues using llvm-reduce.  Support for this was added
  to upstream LLVM in https://reviews.llvm.org/D110527, but there's an
  interface complexity which would require duplicating some code in the
  reducer wrapping code.  This is blocked on figuring out if the interface
  can be simplified to a self contains MIR test to drive target specification.
* Reduction of assembly inputs.  The challenge here is that most of the tools
  crash when fed malformed assembly.  Generally, finding crashes on malformed
  input is "easy" and thus reduction to malformed input is not "interesting".
  Blocked on finding a way to reduce only valid, but still crashing, inputs.

Retention Policy
----------------

The individual tests within this repo will be retained only so long as they
a) demonstrate a crash on upstream LLVM, b) are subjectively interesting in
the sole judgment of the author, and c) do not exceed any of the stated
resource limits (as may be freely revised in the future.)

Additionally, the history of this repository may be rewritten.  Because of
this, YOU SHOULD NOT EXPECT THE HISTORY OF THIS REPO TO BE STABLE.  Force
pushes to this repository to remove history may be common (e.g. removing
large files entirely from history, etc..).

Putting these together, you should always ensure that individual test cases
are preserved in some other system of record.  Keep a copy of your corpus.
Copy the text of an failure into a bug report or commit message.  You can
include a link to this repo if desired, you should operate under the
assumption that link may break at any time.

