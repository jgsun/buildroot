include package/boxing/*/*.mk

# Make sure the binary packages directory is cleaned on 'make clean'
# The path 'pkgs' is duplicated in support/scripts/create-pkgs
clean: pkg-clean
pkg-clean:
	rm -rf $(BASE_DIR)/pkgs
