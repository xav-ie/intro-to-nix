<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	// import { tween } from '@animotion/motion'
	import dedent from 'dedent'

	// listen, I know this is bad
	let text: HTMLParagraphElement
	let codeNixSlide2: Code
	let codeShSlide2: Code

	let codeNixSlide3: Code
	let codeShSlide3: Code

	let codeNixSlide4: Code
	let codeShSlide4: Code

	let codeNixSlide5: Code
	let codeShSlide5: Code

	let codeNixSlide6: Code
	// let circle = tween({ x: 0, y: 80, r: 80, fill: '#00ffff' })
	//let items = $state([1, 2, 3, 4])
	//let layout = $state('flex gap-4')
	const concepts = [
		'Declarative',
		'Reproducible',
		'Immutable',
		'Functional',
		'Distributed',
		'Lazy',
		'Correct',
		'Fun',
		'Awesome',
		'Wonderful'
	]

	const makeFullScreen = () => {
		document.documentElement.requestFullscreen()
	}
</script>

<Presentation options={{ history: true, transition: 'slide', controls: true, progress: true }}>
	<!-- intro -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-8xl">
			<span>Declarative Builds with Nix</span>
		</h1>
		<p class="text-dimmed ml-[3rem] text-4xl">(and deployments) ^</p>
		<div class="justify-content-center mt-8 flex flex-row items-center gap-8">
			<img
				src="/fonts/COWBOY/Vectors/Cowboy Hat with Lightning.svg"
				alt="cowboy hat"
				class="h-32 w-32"
			/>
			<span class="teal-emoji pt-[2rem] text-8xl"> ❄️ </span>
			<img src="/fonts/COWBOY/Vectors/Cactus.svg" alt="cactus" class="h-32 w-32" />
		</div>

		<button
			on:click={makeFullScreen}
			class="mt-8 rounded-lg border-2 border-white bg-transparent p-3 text-white"
			>Make full screen</button
		>
	</Slide>

	<!-- nix concepts -->
	<Slide class="h-full place-content-center place-items-center">
		<p bind:this={text} class="text-8xl drop-shadow-sm">
			Nix Concepts <span class="teal-emoji py-4">💡</span>
		</p>
		<ul class="text-left">
			{#each concepts as concept, i}
				<li style={`opacity: ${1 - (0.1 + i / concepts.length)};`}>{concept}</li>
			{/each}
		</ul>
		<Transition>
			<h1 class="teal-emoji text-8xl">🤷</h1>
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2>A simple example</h2>
		<Transition class="mt-8" visible={true}>
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeNixSlide2}
				lang="nix"
				theme="github-dark"
				code={dedent`
          # some-file.nix
          {
            x = 2;
          }
				`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
		</Transition>
		<Transition class="mt-8">
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeShSlide2}
				lang="sh"
				theme="github-dark"
				code={dedent`
          $ nix-instantiate --eval --json       some-file.nix
          # { ^ run the nix file } { ^ format } { ^ input }
          { "x" : 2 }
				`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
			<Action do={() => codeShSlide2.selectToken`1 nix-instantiate --eval`} />
			<Action do={() => codeShSlide2.selectToken`1 --json`} />
			<Action do={() => codeShSlide2.selectToken`1 some-file.nix`} />
			<Action do={() => codeShSlide2.selectLines`*`} />
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2>What else can we do?</h2>
		<Transition class="mt-8" visible={true}>
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeNixSlide3}
				lang="nix"
				theme="github-dark"
				code={dedent`
          # some-file-2.nix
          let 
            x = 2;
            y = 3;
          in
          {
            z = x + y;
          }
				`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
		</Transition>

		<Transition class="mt-8">
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeShSlide3}
				lang="sh"
				theme="github-dark"
				code={`$ nix-instantiate --eval --json some-file-2.nix`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
			<Action
				do={() => codeShSlide3.update`$ nix-instantiate --eval --json some-file-2.nix
error: cannot convert a thunk to JSON
 at /home/x/Projects/intro-to-nix/some2.nix:6:3:

      5| {
      6|   z = x + y;
       |   ^
      7| }`}
			/>
			<Action
				do={() => codeShSlide3.update`$ nix-instantiate --eval --json --strict some-file-2.nix`}
			/>
			<Action
				do={() => codeShSlide3.update`$ nix-instantiate --eval --json --strict some-file-2.nix
{ "z": 5 }`}
			/>
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2>A little more advanced</h2>
		<Transition class="mt-8" visible={true}>
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeNixSlide4}
				lang="nix"
				theme="github-dark"
				code={dedent`
          # some-file-3.nix
          { pkgs ? import <nixpkgs> {} }: # <- inputs
          let 
            x = 2;
            y = 3;
          in
          {
            z = x + y;
            myHello = pkgs.hello;
          }
				`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
		</Transition>

		<Transition class="mt-8">
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeShSlide4}
				lang="sh"
				theme="github-dark"
				code={`$ nix-instantiate --eval --json --strict some-file-3.nix`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
			<Action
				do={() => codeShSlide4.update`$ nix-instantiate --eval --json --strict some-file-3.nix
error: cannot convert a function to JSON

at /home/x/Projects/intro-to-nix/some3.nix:1:1:

    1| {
     | ^
    2|   pkgs ? import <nixpkgs> { },`}
			/>
			<Action
				do={() =>
					codeShSlide4.update`$ nix-instantiate --eval --expr "(import ./some-file-3.nix {}).z"`}
			/>
			<Action
				do={() => codeShSlide4.update`$ nix-instantiate --eval --expr "(import ./some-file-3.nix {}).z"
5`}
			/>
			<Action
				do={() =>
					codeShSlide4.update`$ nix-instantiate --eval --expr "(import ./some-file-3.nix {}).myHello"`}
			/>
			<Action
				do={() => codeShSlide4.update`$ nix-instantiate --eval --expr "(import ./some-file-3.nix {}).myHello"
{ __ignoreNulls = true; __structuredAttrs = <CODE>; all = <CODE>; args = 
<CODE>; buildInputs = <CODE>; builder = <CODE>; cmakeFlags = <CODE>; 
configureFlags = <CODE>; depsBuildBuild = <CODE>; depsBuildBuildPropagated
= <CODE>; depsBuildTarget = <CODE>; depsBuildTargetPropagated = <CODE>;
depsHostHost = <CODE>; depsHostHostPropagated = <CODE>; depsTargetTarget
= <CODE>; depsTargetTargetPropagated = <CODE>; doCheck = <CODE>; 
doInstallCheck = <CODE>; drvAttrs = { __ignoreNulls = true; __structuredAttrs
= <CODE>; args = <CODE>; buildInputs = <CODE>; builder = <CODE>; 
cmakeFlags = <CODE>; configureFlags = <CODE>; depsBuildBuild = <CODE>; 
depsBuildBuildPropagated = <CODE>; depsBuildTarget = <CODE>; 
depsBuildTargetPropagated = <CODE>; depsHostHost = <CODE>; 
depsHostHostPropagated = <CODE>; depsTargetTarget = <CODE>; 
depsTargetTargetPropagated = <CODE>; doCheck = <CODE>; doInstallCheck
= <CODE>; mesonFlags = <CODE>; name = <CODE>; nativeBuildInputs = <CODE>;
outputs = [ "out" ]; patches = <CODE>; pname = "hello"; postInstallCheck 
= <CODE>; propagatedBuildInputs = <CODE>; propagatedNativeBuildInputs = 
<CODE>; src = <CODE>; stdenv = { __extraImpureHostDeps = <CODE>; all = 
<CODE>; allowedRequisites = <CODE>; args = <CODE>; bootstrapTools = { 
all = <CODE>; args = [ "ash" "-e" /nix/store/d9gbq853jvbccrz5g3y0irbwgc57w137-source/
pkgs/stdenv/linux/bootstrap-tools/glibc/unpack-bootstrap-tools.sh ];
builder = { all = <CODE>; builder = "builtin:fetchurl"; drvAttrs = { 
builder = "builtin:fetchurl"; executable = true; impureEnvVars = [ 
"http_proxy" "https_proxy" "ftp_proxy" "all_proxy" "no_proxy" ]; name
= "busybox"; outputHash = "sha256-QrTEnQTBM1Y/qV9odq8irZkQSD9uOMbs2Q5NgCvKCNQ=";
outputHashAlgo = ""; outputHashMode = "recursive"; preferLocalBuild = true; 
system = "builtin"; unpack = false; url = 
"http://tarballs.nixos.org/stdenv/x86_64-unknown-lin...`}
			/>
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2>A simpler command</h2>
		<Transition class="mt-8" visible={true}>
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeNixSlide5}
				lang="nix"
				theme="github-dark"
				code={dedent`
          # some-file-3.nix
          { pkgs ? import <nixpkgs> {} }: # <- inputs
          let 
            x = 2;
            y = 3;
          in
          {
            z = x + y;
            myHello = pkgs.hello;
          }
				`}
				autoIndent={false}
				options={{ duration: 600, stagger: 0.3, lineNumbers: true, containerStyle: false }}
			/>
		</Transition>

		<Transition class="mt-8">
			<Code
				class="max-h-[80dvh] overflow-scroll "
				bind:this={codeShSlide5}
				lang="sh"
				theme="github-dark"
				code={`$ nix-build some-file-3.nix`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd $(!!)`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd /nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd /nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ `}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd /nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ls
 bin   share`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd /nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ls
 bin   share
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ls bin
 hello`}
			/>
			<Action
				do={() => codeShSlide5.update`$ nix-build some-file-3.nix
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
$ cd /nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ls
 bin   share
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ls bin
 hello
/nix/store/39z5zpb72qrnxl832nwphcd4ihfhix3j-hello-2.12.1$ ./bin/hello
Hello, world!`}
			/>
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2 class="text-8x">
			<a href="https://nixos.org/guides/how-nix-works/" target="_blank">
				https://nixos.org/guides/how-nix-works/
			</a>
		</h2>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2 class="text-8xl">An example package</h2>
		<a
			class="text-3xl"
			href="https://github.com/NixOS/nixpkgs/blob/05d8b74b04f1b16898c4b81da8eef65ac432e4e3/pkgs/applications/video/obs-studio/plugins/obs-gradient-source.nix"
			>https://github.com/NixOS/nixpkgs/blob/05d8b74b04f1b16898c4b81da8eef65ac432e4e3/pkgs/applications/video/obs-studio/plugins/obs-gradient-source.nix</a
		>
		<Transition>
			<a
				class="text-3xl"
				href="https://github.com/xav-ie/dots/blob/fbbdf4d/modules/home-manager/programs/obs/obs-stroke-glow-shadow.nix"
			>
				👁️
				https://github.com/xav-ie/dots/blob/fbbdf4d/modules/home-manager/programs/obs/obs-stroke-glow-shadow.nix
				👁️
			</a>
		</Transition>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2 class="text-8x">
			<span class="teal-emoji"> 🏆</span>Achievement Unlocked!<span class="teal-emoji"> 🏆</span>
		</h2>
		<h1 class="text-8xl">Yak Shaver</h1>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2 class="text-8x">NIXVIM DEMO</h2>
		<p>Run some random nixvims!</p>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h2 class="text-8x">Nix can also manage your environment with devenv and direnv</h2>
		<p>Another demo!!!</p>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h1>
			<span class="teal-emoji"> 📖</span> Resources
		</h1>
		<ul class="mt-8 text-left">
			<li><a href="discourse.nixos.org">discourse.nixos.org</a></li>
			<li><a href="nix.dev">nix.dev</a></li>
			<li><a href="wiki.nixos.org">wiki.nixos.org</a></li>
			<li><a href="youtube.com">youtube.com</a></li>
			<li><a href="github.com">github.com</a></li>
		</ul>
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<h1>
			<span class="teal-emoji"> 🤠</span> Thank you! <span class="teal-emoji">🐮</span>
		</h1>
		<ul class="mt-8 text-left">
			<li><a href="xav.ie">xav.ie</a></li>
			<li><a href="github.com/xav-ie">github.com/xav-ie</a></li>
			<li><a href="x.com/xorlop">x.com/xorlop</a></li>
			<li><a href="hachyderm.io/@xorlop">hachyderm.io/@xorlop</a></li>
		</ul>
	</Slide>
</Presentation>
