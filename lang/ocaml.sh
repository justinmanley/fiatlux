sudo add-apt-repository ppa:avsm/ppa
sudo apt-get update
sudo apt-get install ocaml ocaml-native-compilers camlp4-extra opam -y

opam init && opam update

# for flowtype: http://flowtype.org/
sudo apt-get install libelf-dev -y