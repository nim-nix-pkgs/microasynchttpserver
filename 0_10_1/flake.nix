{
  description = ''A thin asynchronous HTTP server library, API compatible with Nim's built-in asynchttpserver.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-microasynchttpserver-0_10_1.flake = false;
  inputs.src-microasynchttpserver-0_10_1.ref   = "refs/tags/0.10.1";
  inputs.src-microasynchttpserver-0_10_1.owner = "philip-wernersbach";
  inputs.src-microasynchttpserver-0_10_1.repo  = "microasynchttpserver";
  inputs.src-microasynchttpserver-0_10_1.type  = "github";
  
  inputs."picohttpparser".owner = "nim-nix-pkgs";
  inputs."picohttpparser".ref   = "master";
  inputs."picohttpparser".repo  = "picohttpparser";
  inputs."picohttpparser".dir   = "0_10_0";
  inputs."picohttpparser".type  = "github";
  inputs."picohttpparser".inputs.nixpkgs.follows = "nixpkgs";
  inputs."picohttpparser".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-microasynchttpserver-0_10_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-microasynchttpserver-0_10_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}