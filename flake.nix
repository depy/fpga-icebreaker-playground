{
  description = "iCE40UP5K FPGA dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "ice40 fpga dev";
        packages = with pkgs; [
          yosys      # synthesis
          nextpnr    # place & route (ice40)
          icestorm   # icepack / icetime / iceprog
          iverilog   # simulation
          surfer     # waveform viewer
          verible    # editor LSP / format / lint
          digital    # digital logic designer and circuit simulator
        ];
      };
    };
}
