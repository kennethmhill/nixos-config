set quiet

machine := env('MACHINE_NAME', 'Mac')

default: switch

[linux]
build:
	nix build ".#nixosConfigurations.{{machine}}.system"

[macos]
build:
	nix build ".#darwinConfigurations.{{machine}}.system"

[linux]
check: build
	sudo nixos-rebuild check --flake ".#{{machine}}"

[macos]
check: build
	sudo ./result/sw/bin/darwin-rebuild check --flake ".#{{machine}}"

[linux]
switch: build
	sudo nixos-rebuild switch --flake ".#{{machine}}"

[macos]
switch: build
	sudo ./result/sw/bin/darwin-rebuild switch --flake ".#{{machine}}"

