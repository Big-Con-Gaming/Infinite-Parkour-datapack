# Welcome to Infinite Parkour's Contribution Guide!
First, thanks for being interested in this project! We have a lot of ideas, and you'd like to get involved, too! Any changes you make will be reflected in Alpha releases to Infinite Parkour, available [here](https://www.planetminecraft.com/project/infinite-parkour-version-2-0-alpha/) on Planet Minecraft!

Please read our [Code of Conduct](https://github.com/Big-Con-Gaming/Infinite-Parkour-datapack/blob/main/CODE_OF_CONDUCT.md) to make sure all contributions keep our community approachable and respectable.

In this guide, you'll get an overview of how to make contributions and what we are looking for in contributions. Please keep in mind this team is currently small and changes will take some time to reflect in the codespace. We appreciate your patience.

You can use the table of contents icon at the top left corner of this document to quickly access a specific section of this guide.

## Getting Started
To be able to effectively use GitHub to submit your contributions to this project, you should take the steps to install the required programs to allow for easy edits. This includes:

- [Set up Git](https://docs.github.com/en/get-started/getting-started-with-git/set-up-git)
- [Install GitHub Desktop](https://docs.github.com/en/desktop)

From there, you will be able to pull the most recent changes to your computer locally. We recommend making a new Minecraft super flat world on Java, version 1.21.4 so that there's nothing from the world that could inflict issues with your experience. Make sure that the world's data pack folder is where you point Github to place the data pack files, for quick testing.

We recommend using [VSCode](https://code.visualstudio.com/docs/setup/setup-overview) for editing the data pack's files as the extensions listed below will help you out, and it's what we're using. This guide will assume you are using VSCode as your IDE. These extensions can be installed directly inside VSCode's extensions panel.
-  [Spyglass](https://marketplace.visualstudio.com/items?itemName=SPGoding.datapack-language-server)
-  [Better Datapack](https://marketplace.visualstudio.com/items?itemName=ExAtom.better-datapack)
-  [MC Datapack](https://marketplace.visualstudio.com/items?itemName=HuJohner.mc-datapack)
-  [Mcfunction Snippets](https://marketplace.visualstudio.com/items?itemName=VidTDM.mcfunction-snippets)
-  [Mcfunction-Debugger](https://marketplace.visualstudio.com/items?itemName=vanilla-technologies.mcfunction-debugger)
-  [syntax-mcfunction](https://marketplace.visualstudio.com/items?itemName=MinecraftCommands.syntax-mcfunction)
-  [Minecraft JSON Schemas](https://marketplace.visualstudio.com/items?itemName=Levertion.mcjson)

Now when you first look at the code, you may find a ton of errors pop up. This is because the syntax profiler is not configured to OfekN's custom compiler. More details about this will be shared in the next section.

## OfekN's Custom Compiler
OfekN has been so kind as to build an entirely custom compiler so that writing data packs is way easier than before. If you want to know how this works and more details about it, we HIGHLY recommend you read the [ReadMe](./README.md) so that you understand how this all works.

Important to note: DO NOT make modifications to the ``/data/`` folder. Usually, this is where you would make modifications to a data pack, but with this compiler, this is not the case. You must make any changes inside of the ``/src/`` folder instead. They have identical structures, but the data folder will be replaced when the compiler runs.

To get the compiler running, you can open a command prompt (in VSCode there's a terminal button at the top that works as well) and run ``./autobuild.bat``. This will keep the ``/data/`` folder up to date with every change you make to the ``/src/`` folder for you automatically.

To remove all the error pop-ups and red underlines, create a folder called ``.vscode`` and make a file inside it called ``settings.json``. inside this file, insert the code:
```
{
  "[mcfunction]": {
    "problems.visibility": false
  }
}
```
## General Guidelines for Making Contributions
- All changes must follow our [Code of Conduct](https://github.com/Big-Con-Gaming/Infinite-Parkour-datapack/blob/main/CODE_OF_CONDUCT.md)
- Check any open [Issues](https://github.com/Big-Con-Gaming/Infinite-Parkour-datapack/issues) before opening your issues and as a starting place for new contributions.
- Peek at any open [Pull Requests](https://github.com/Big-Con-Gaming/Infinite-Parkour-datapack/pulls) so that you don't try doing something that someone else has already done. If they have a similar idea to what you wanted to contribute, try communicating with them to see if you can help them out in their contribution!
- Please prioritize modifying fewer files so that pull requests have a smaller chance of conflict.
- Please test out your changes before making a pull request.
- Please follow the existing plans that have been laid out in our [Discord server](https://discord.com/channels/1302079242929963018/1305018511093141504). Otherwise, we can't promise to accept your request since we need to maintain the original vision.
- Contributions that remove whitespace, add redundant features, cause unnecessary changes, or are poorly documented without comments and descriptions will be denied.
- Please keep your identity or any target selectors containing your username out of the names of any files, folders, or within the contents of functions.
- Please try to update comments surrounding your code to make sure their functionality is clear and easy to understand to a new programmer.
- Keep in mind that this is in Alpha, and bugs can show their ugly heads at any corner. Working towards removing these first is preferred over introducing new features at the moment.

## Conclusion
If you plan on sticking around for a long time, please consider joining the [Discord Server](https://discord.gg/dnNu2xHWsQ) and asking to become a member of the team there! We recommend having some experience with data packs, modding, or Minecraft Java as a whole beforehand.

A list of all contributors who created accepted pull requests will be created and accessible within the data pack itself, as well as on the PMC download page. This is guaranteed to be available before the first official release.

Thanks for your help in advance! Hopefully, this project will continue to grow and we appreciate the support!
