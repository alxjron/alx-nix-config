# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> {} }: {
  alx-background = pkgs.callPackage ./backgrounds { };
  iconpack-obsidian = pkgs.callPackage ./iconpack-obsidian { };
}
