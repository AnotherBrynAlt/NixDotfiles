{pkgs ? import <nixpkgs> {}}: let
  my-python = pkgs.python3;
  python-with-my-packages = my-python.withPackages (p:
    with p; [
      pandas
      requests
      pygments
    ]);
in
  pkgs.mkShell {
    packages = [
      python-with-my-packages
    ];
  }
