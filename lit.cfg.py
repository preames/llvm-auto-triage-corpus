# Construct just enough of a lit config that running llvm-lit <corpus-root>
# does something vaguely sensible provided that all tools are on your path.
# Eventually, this should import the LIT config used by LLVM itself, but
# the first couple of attempts at that proved less than successful.  Will
# need to do that before REQUIRES: clauses can be used in a sensible way.

import lit.formats
import os

config.name = "Example Corpus"
config.test_format = lit.formats.ShTest(True)

config.suffixes = ['.ll']

# This is an ugly hack, figure out cleaner mechanism
# Or just checkout under test tree
config.environment["PATH"] = os.environ['PATH']


tools = []
tools.extend([
    'dsymutil', 'lli', 'lli-child-target', 'llvm-ar', 'llvm-as',
    'llvm-addr2line', 'llvm-bcanalyzer', 'llvm-bitcode-strip', 'llvm-config',
    'llvm-cov', 'llvm-cxxdump', 'llvm-cvtres', 'llvm-diff', 'llvm-dis',
    'llvm-dwarfdump', 'llvm-dlltool', 'llvm-exegesis', 'llvm-extract',
    'llvm-isel-fuzzer', 'llvm-ifs',
    'llvm-install-name-tool', 'llvm-jitlink', 'llvm-opt-fuzzer', 'llvm-lib',
    'llvm-link', 'llvm-lto', 'llvm-lto2', 'llvm-mc', 'llvm-mca',
    'llvm-modextract', 'llvm-nm', 'llvm-objcopy', 'llvm-objdump', 'llvm-otool',
    'llvm-pdbutil', 'llvm-profdata', 'llvm-profgen', 'llvm-ranlib', 'llvm-rc', 'llvm-readelf',
    'llvm-readobj', 'llvm-rtdyld', 'llvm-sim', 'llvm-size', 'llvm-split',
    'llvm-stress', 'llvm-strings', 'llvm-strip', 'llvm-tblgen', 'llvm-tapi-diff',
    'llvm-undname', 'llvm-windres', 'llvm-c-test', 'llvm-cxxfilt',
    'llvm-xray', 'yaml2obj', 'obj2yaml', 'yaml-bench', 'verify-uselistorder',
    'bugpoint', 'llc', 'llvm-symbolizer', 'opt', 'sancov', 'sanstats'])
