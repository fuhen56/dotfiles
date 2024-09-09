{
	config,
	pkgs,
	...
}: {
	config.users = {
		users = {
			james = {
				packages = with pkgs; [
					android-tools
					heimdall
				];
			};
		};
	}
};
