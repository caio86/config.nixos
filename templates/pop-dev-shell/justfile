default:
  @just --list

run source: ( build  source )
  ./output <input.txt | tee output.txt

build source:
  g++ {{invocation_directory()}}/{{ source }} -o output
