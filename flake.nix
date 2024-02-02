{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkg = (import ./nix/vscode.nix) pkgs;
  in {
    packages.x86_64-linux.default = pkg;
  };
}
