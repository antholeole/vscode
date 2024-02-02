{ pkgs, ... }: pkgs.stdenv.mkDerivation {
	name = "vscode";
	src = ./..;

	buildInputs = with pkgs; [
		nodejs_18
		prefetch-yarn-deps
		yarn
	];

	  configurePhase = ''
    runHook preConfigure

    export HOME="$TMPDIR"
    yarn config --offline set yarn-offline-mirror "$offlineCache"
    fixup-yarn-lock yarn.lock
    yarn install --offline --frozen-lockfile --ignore-platform --ignore-scripts --no-progress --non-interactive
    patchShebangs node_modules/

    runHook postConfigure
  '';

    buildPhase = ''
    runHook preBuild

    yarn --offline run build

    runHook postBuild
  '';

}
