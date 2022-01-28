set -xe

mkdir -p /tmp/ci_build
cd /tmp/ci_build

echo "Setup mold for faster building"
wget -c https://nightly.link/ren15/mold_ci/workflows/build/main/mold_complie_art.zip 
pwd
ls
ls ./*.zip | xargs unzip

chmod +x mold
mkdir -p /usr/local/lib/mold

mv mold /usr/local/bin
mv mold-wrapper.so /usr/local/lib/mold

echo "Cloning and building llvm"
git clone --depth 1 https://github.com/llvm/llvm-project.git

cd llvm-project
mkdir build
cd build

cmake ../llvm -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Release -G Ninja
mold -run cmake --build .

