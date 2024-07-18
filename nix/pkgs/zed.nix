{ lib, fetchFromGitHub, ... }:
lib.carburetor.mkWhiskersDerivation {
  pname = "zed";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "6ac674645711195d90f02876e74c79256848ff22";
    hash = "sha256-jOHCO4wBqm2oNwVSJ3S9npKE5Gsen6ai9TZd9IMuevc=";
  };
}
