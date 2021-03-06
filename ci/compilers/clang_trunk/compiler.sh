set -xe

source /tmp/setup_cc.sh

echo "Check gcc version"
gcc --version
which gcc

mkdir -p /tmp/ci_build
cd /tmp/ci_build


echo "Cloning and building llvm"
git clone --depth 1 https://github.com/llvm/llvm-project.git

cd llvm-project
mkdir build
cd build

cmake ../llvm -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Release -G Ninja
mold -run cmake --build .

