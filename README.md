# Infinite Parkour
Infinite parkour is a datapack that generates parkour as you go.<br>
Check out [BCG's videos](https://www.youtube.com/playlist?list=PLSZguD4jJp5oo_iQR-9B0YJo7vNYdANNP
)

## Building
This project uses a custom build tool OfekN made (MinecraftScript.jar)<br>
There are a couple of batch files for you to use:
- [`built.bat`](./build.bat) - builds the project once, will also produce a zip file.
- [`autobuild.bat`](./autobuild.bat) automatically builds when the code changes, doesn't create a zip file.
- [`clean.bat`](./clean.bat) deletes all generated files.
## About MinecraftScript
Minecraft script is a pretty simple preprocessor to help with datapack develoopment, here are all the features:
### Multiple functions within a file
You can declare multiple functions within a file like so
```
/foo
  say hello world
/bar
  execute as @a at @s run tp @s ~ ~1 ~
  /baz
    say this is another function
```
This produces 3 functions, each with only 1 command.
### Anonymous (internal) functions
You can declare anonymous functions by nesting, the preprocessor will change it to `function {namespace}:{path}/internal{n}`
```
execute as @a run
  say hello
  say world
```
This will produce two functions:<br><br>
`func.mcfunction`
```
execute as @a run function ns:func/internal0
```
`func/internal0.mcfunction`
```
say hello
say world
```
### Line breaks / Continue Command
You can continue the previous command with the prefix `+`, this is useful for long commands and for anonymous macros.
```
execute in minecraft:nether
+ positioned 100 100 100
+ as @n[type=hoglin]
+ run say Hello

execute if
  execute if entity @s[tag=evil] run return 1
  say I am not evil.
  return 0
+ run
  say I am evil!

%EMPTY%
  $say $(word)
+ with storage ns:path
# %EMPTY% will be converted to nothing. The generated code will be:
# function ns:func/internal0 with storage ns:path
```
### Macros
Currently custom macros aren't supported, there are 3 macros:
 - `%EMPTY%` - will be converted into empty text: ` `
 - `%FILE%` - will be converted into a function call of the file `function <namespace>:<path>`
 - `%FUNC%` - will be converted into a function call of the function `function <namespace>:<path>/<innerpath>`