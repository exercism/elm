# Tags

This document aims to provide reasoning why `config.json` contains the `"tags"` it contains.

## Paradigms

- [x] `paradigm/declarative`: implied by `paradigm/functional`.
- [x] `paradigm/functional`: Elm is a functional language for the web.
- [ ] `paradigm/imperative`: N/A
- [ ] `paradigm/logic`: N/A
- [ ] `paradigm/object_oriented`: N/A
- [ ] `paradigm/procedural`: N/A

## Typing

- [x] `typing/static`: types are checked at compile time.
- [ ] `typing/dynamic`: types are erased at compile time and hence not available at run time.
- [x] `typing/strong`: types in Elm are unambiguous.
- [ ] `typing/weak`: see `typing/strong`.

## Execution mode

- [x] `execution_mode/compiled`: Elm compiles to Javascript.
- [ ] `execution_mode/interpreted`:  N/A.

## Platform

- [ ] `platform/windows`: Not officially, and possible with Tauri.
- [ ] `platform/mac`: Not officially, and possible with Tauri.
- [ ] `platform/linux`: Not officially, and possible with Tauri.
- [ ] `platform/ios`: Not officially, and possible with Tauri.
- [ ] `platform/android`: Not officially, and possible with Tauri.
- [x] `platform/web`: it Just Works ™️ in all major browsers, and most minor browsers.

## Runtime

- [ ] `runtime/standalone_executable`: it doesn't. Any executable that exists packages Node, or requires Node or a Browser.
- [x] `runtime/language_specific`: it runs on Node or anything that can run the compiled `elm.js`.
- [ ] `runtime/clr`: no support.
- [ ] `runtime/jvm`: no support.
- [ ] `runtime/beam`: no support.
- [ ] `runtime/wasmtime`: no support.

## Used for

- [ ] `used_for/artificial_intelligence`: N/A
- [ ] `used_for/backends`: N/A
- [ ] `used_for/cross_platform_development`: N/A
- [ ] `used_for/embedded_systems`: N/A
- [ ] `used_for/financial_systems`: N/A
- [x] `used_for/frontends`: Elm's only focus is frontend development.
- [ ] `used_for/games`: Possible if the game runs in the browser.
- [ ] `used_for/guis`: N/A
- [ ] `used_for/mobile`: Possible with Tauri.
- [ ] `used_for/robotics`: N/A
- [ ] `used_for/scientific_calculations`: N/A
- [ ] `used_for/scripts`: N/A
- [x] `used_for/web_development`: Elm is a delightful language to build web apps.
