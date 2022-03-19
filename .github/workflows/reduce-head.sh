# This is intended to be run by a github action triggered on a push of a
# new change.
set -x

LAST_CHANGED_FILES=$(git show HEAD --name-only --pretty=format: | xargs -l -iFILE echo $CORPUS/FILE | xargs echo)

echo "Files changed in last commit $LAST_CHANGED_FILES"

# Override for testing purposes
LAST_CHANGED_FILES=./oss_fuzz/4733908335853568.ll

# install nightly clang/etc (and log versions installed)
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" all
clang -v
opt -v

# Install creduce and management scripting
sudo apt-get install creduce
git clone https://github.com/preames/llvm-auto-triage-scripting

pushd llvm-auto-triage-scripting
time python3 manage-corpus.py $LAST_CHANGED_FILES
popd
