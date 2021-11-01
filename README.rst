
This is a corpus of standalone test cases which are known to produce crashes,
or miscompiles when run with a recent snapshot of LLVM.  These are mostly
taken from OSSFuzz.

The primary purpose of this repo is to act as an example and test corpus
for my (as yet unpublished) automated corpus management project. Because of
this, YOU SHOULD NOT EXPECT THE HISTORY OF THIS REPO TO BE STABLE.  Force
pushes to this repository to remove history may be common (e.g. removing
large files entirely from history, etc..).  

Test Format
-----------

Each test must be a self describing LIT test.  The intention is that the
test file could be copied into the LLVM test sub-directory and work as
expected.

However, currently the management scripting does not support the full
generality of LITs configuration language.  As such, each test should
include a header which looks like this:

.. code::

  ; RUN: opt -S -passname < %s
  ; REQUIRES: asserts
  ; XFAIL:

Current restrictions:

* Only the RUN line is parsed and used by the corpus automation, but all
  comment lines will be preserved during reduction.  You can also use
  comments (e.g. lines starting with ";" to give description of the test
  if desired.
* The current parsing of RUN is rather adhoc, so sticking exactly to this
  example's format is highly recommended.
* Only "opt" tests are currently supported.  There's an eventual goal to
  support "llc" and "clang" tests; other tools may (or may not) follow.
* At the moment, all tests are assumed to require asserts.  In the future,
  there is an intention to allow require clauses for e.g. asan or alive-tv.

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