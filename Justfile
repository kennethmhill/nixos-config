export HOSTNAME := "Mac"

default: switch

@build:
	nix build ".#darwinConfigurations.${HOSTNAME}.system"

[macos]
@switch: build
	sudo ./result/sw/bin/darwin-rebuild switch --flake ".#${HOSTNAME}"

[macos]
check: build
	sudo ./result/sw/bin/darwin-rebuild check --flake ".#${HOSTNAME}"

