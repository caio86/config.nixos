default:
  @just --list

build:
  g++ ./main.cpp -o output

run: build
  ./output <input.txt | tee output.txt

watch:
  watchexec -e "cpp" -r "just run"
