# Sentry Native

This is the [sentry-native](https://github.com/getsentry/sentry-native), packaged for [Zig](https://ziglang.org/).

This is a build wrapper, which prepars the library which can be linked and exposes the sentry native C API.

_Note_: This will work for simple use-cases, but this still needs more testing.

## Installation

First add the dependencies to your project

```shell
> zig fetch --save git+https://github.com/olksdr/sentry-native.git
```

And after you can import `sentry_native` in yout `build.zig`. _Note_: the dash ("-") is replaced with underscore ("_") in the name.

```zig

const sentry_native = b.dependency("sentry_native", .{
    .target = target,
    .optimize = optimize,
    // Only if you run on Unix-like system you might want to link with libcurl (deafult is "false").
    .curl = true,
    // Only if you are on Windows (default "false").
    .winhttp = true,
});


// Link the Sentry library to your exe.
exe.linkLibrary(sentry_native.artifact("sentry"));
// Add the imports to the root module, so you can use those in your code, e.g.:
// const sentry = @import("sentry");
exe.root_module.addImport("sentry", sentry_native.module("sentry"));

```

You might have to install additional dependencies and makes sure the your dev environment is configured and all paths and includes are in-place.
Different systems will have different requirements (e.g. on Windows you might have to install WindowsSDK and make sure that `PATH` is properly set up, etc.).

## Maintenance

When updating `sentry-native` to the new relase (or commit), make sure to check and update the list of file `*.c` files, and also make sure that includes are correct.
When updating to the new release, make sure to change also the version in the `build.zig` update fetching new `sentry-native` commit.

### Known limitations:

Currently only `none` or `inproc` (enabled by default) backends are supported.

### TODO:

As part of this build the following items still on the list:

- [ ] Support Crashpad backend.
- [ ] Support Breakpad backend.
