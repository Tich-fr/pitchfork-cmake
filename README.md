![pitchefork-cmake logo](data/artwork/pitchfork-logo.png)

# A CMake Implementation Of The Pitchfork Layout

This project aims to be a starting point for whoever wants to create a library in C++ using CMake.
It implements the Pitchfork layout in a `Separated` way and showcase some usage of CMake for a complex
library layout.

It is also a good ressource for some other good practice (licensing, formatting, CI, ...).

**Disclaimer:** while I do have some opinions on how I'd like my project to look like, I am by no mean an absolute
expert of CMake and does not have enough experience to say "this is the only right way to do things". Meaning that if you have
some ideas to improve this CMake implementation or other improvements in mind, feel free to create an issue or a PR
so we can discuss further :)

## Why this project ?

Each time I want to start a project in C++, it really pains me the amount of time I have to spend to go through the whole
initial setup (organizing my source files, what is good CMake again, where to put tests, how to add coverage and CI, ...).
This project aims to be the (at least my) complete cheat sheet for all of these, with a focus on the source code layout.

## Why CMake ?

While it is a very verbose and cumbersome build system generator, it is also very powerfull and more importantly is nowedays
the most used build infrastructure for C++ projects, meaning that it should be pretty easy to use third-party libraries. Also,
with modern CMake enforcing to have a `CMakeLists.txt` in each source directory it already gives us some hints on how to
organize our code properly.

## Why the pitchfork layout ?

This layout has already been discussed intensively and was pretty welcomed by the community. A strong point of this layout is that it has an
extensive documentation : https://api.csswg.org/bikeshed/?force=1&url=https://raw.githubusercontent.com/vector-of-bool/pitchfork/develop/data/spec.bs.
I also just like this layout.

There is two main "implementation" possible for the pitchfork layout, namely merged and separated. The first has top-level `include/` and `tests/` directory,
while the other tries to put headers and test as close as possible to the compile unit. I think the separated layout respects modern CMake and
C++ philosophy more so my implementation will be separated.

### Differences between the pitchfork layout and my implementation

According to the documentation, submodules cannot have subdirectories. I however added an example of a submodule with a subdirectory representing a namespace.
This is because I believe that if your logical and physical layout are alike it will be much simpler to understand what is going on. I'm still unsure if this
is a good thing or not but since I didn't find any corner case where this is annoying, I'll keep this more structured approach for now.

## How to use it ?

This repo is mainly designed to be a complex example to either browse or directly copy-paste to start a new project.
There are however a few files that are worth mentioning because they contains usefull comments and/or design principles :

- (README.md)[README.md] : this README of course :)
- (CMakeLists.txt)[CMakeLists.txt] : for how to setup, install and package a project
- (libs/core/CMakeLists.txt)[libs/core/CMakeLists.txt] : for how to setup and install a target
- (docs/CMakeLists.txt)[docs/CMakeLists.txt] : for how to build a doxygen doc with CMake

What I also want to remind is that files such as `.clang-format`, `.clang-tidy`, `.gitignore` or the `LICENSE` for example
are not noise that has been added just for fun : they are a full part of this project and should be considered like so when
creating your own project.

## List of goals of the repository

- [x] clean and modern CMake infrastructure for a simple separated pitchfork layout
  - [x] implement submodules and optional submodules
  - [x] make submodules available through the `COMPONENTS` keyword of CMake `find_package`
  - [x] make the same code compilable against both build and install directories
  - [x] export targets, library configuration and version
- [x] show simple testing using CTest
- [x] show simple packaging using CPack
- [x] implement a complete pitchfork layout
  - [x] add an `extras/` directory for holding optional submodules disabled by defaults
  - [x] add a `data/` folder for holding any data that is not code-related
  - [x] add an `external/` folder that handles third-party libraries
  - [x] add integration tests

Some additional features unrelated to the pitchfork layout but that should exists for every open-source C++ project (imo) :

- [x] complete Clang configuration to keep the code base readable, consistent in time and warning/error free
- [x] use a testing framework for more comprehensive testing (Catch2 in this case)
- [x] generate API documentation with Doxygen
- [x] use SPDX headers in source files in order to track licensing and copyright informations
- [ ] simple CI integration (either using [GitHub Actions](https://docs.github.com/en/actions), [SonarCloud](https://www.sonarsource.com/products/sonarcloud/) or both)
  - [ ] basic pipeline using CTest
  - [ ] documentation and installation testing
  - [ ] show code coverage
  - [ ] enforce clang rules
- [ ] use git hooks to enforce clear and usefull commit messages (see https://www.conventionalcommits.org/en/v1.0.0/)

## Layout explanation

```
.
|  LICENSE                  -> License of the whole project, applied to all sources of this repo. To apply different licenses add a `LICENSE` file in each directory you want to handle differently,
|                              or use SPDX headers. If you don't know which license to choose see https://choosealicense.com/.
|  README.md                -> This file. Should contain all necessary informations for people to use this project. If you're not sure what a good README is see https://www.makeareadme.com/.
|  .clang-format            -> Define how to format your project
|  .clang-tidy              -> Rules on which code smells / bugs to catch using Clang. This file also add some formatting rules that can only be checked at compile time (such as casing for example).
|  .gitignore               -> Among other things, enforce ignoring the `build/` directory as it is supposed to hold build artefacts
└─ data/                    -> Holds files which should be included in revision control but are not explicitly code nor related to documentation.
└─ tools/                   -> Holds extra scripts and tools related to developing and contributing to the project.
|  └─ cmake/                -> All cmake utilities you need for your project
└─ docs/                    -> All code / ressources related to the documentation.
└─ examples/                -> Usage example of the library. Each example should be one or a few source files only. Compilation of examples should be configurable from the build system.
|  CMakeLists.txt
|  └─ ...
└─ libs/                    -> All sources of the library. The library is composed of several submodules / components.
|  |  CMakeLists.txt        -> Add each submodule according to the current CMake configuration.
|  └─ tests/                -> Directory for integration tests for interaction between classes of several submodules, if any.
|  |  |  CMakeLists.txt
|  |  └─ ...
|  └─ submodule1/           -> Each subdirectory of the "libs" directory represents a submodule of the library.
|  |  |  CMakeLists.txt     -> A submodule is, at its core, just a shared / static library. Each submodule can be imported separately with CMake `find_package` using the `COMPONENTS` keyword.
|  |  └─ tests/             -> Integration tests for this submodule, if any.
|  |  |  |  CMakeLists.txt
|  |  |  └─ ...
|  |  |  Class1.cxx         -> Source of the class Class1 of the current submodule.
|  |  |  Class1.h           -> Header of the class Class1 of the current submodule.
|  |  |  Class1.test.cxx    -> Unit test for the class Class1 of the current submodule.
|  |  |  ...
|  |  └─ namespace1/        -> Subdirectories in submodules are allowed but should represent namespaces.
|  |  |  |  CMakeLists.txt  -> Each namespace will be built as an OBJECT library. All namespace OBJECTs will be then aggregated by their parent submodule.
|  |  |  |  Class1.cxx      -> Classes follow the same naming pattern that for submodules (see above).
|  |  |  └─ ...
|  |  └─ ...
|  └─ ...
```

## Contributing

As I said, pull requests are welcome :) . For major changes, please open an issue first to discuss what you would like to change.
I may not be active every weeks so please bear with me. If you want a faster feedback loop and merge process consider forking this project.

## License

MIT
