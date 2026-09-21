# SPDX-FileCopyrightText: 2026 Gabriel Santos de Souza <gabriel.santosdesouza@dcomp.ufs.br>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  description = "Personal blog.";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          '';
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              go
              hugo
              reuse
              taplo
            ];
            shellHook = ''
              ln -sf ${emacsSettings} .dir-locals.el
            '';
          };
        }
      );
    };
}
