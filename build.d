module main;

import std.file;
import std.path;
import std.process;
import std.stdio;

void main()
{
    auto command = "dmd -g -w -debug -O -Idsfml/src -ofbin/FarmingAdventure ";
    auto libs = "-L-Ldsfml/lib -L-Ldsfml/SFML/lib -L-ldsfml-graphics " ~
    "-L-ldsfml-window -L-ldsfml-audio -L-ldsfml-system -L-lsfml-graphics " ~
    "-L-lsfml-window -L-lsfml-audio -L-lsfml-system -L-lstdc++ " ~
    "-L-rpath='$ORIGIN'";
    string files;


    auto needsToBuild = false;

    //generate list of files to build
    foreach(ref DirEntry entry; dirEntries("src", SpanMode.depth))
    {
        if(extension(entry.name) == ".d")
        {
            if(!needsToBuild && needToBuild(entry.name, "bin/FarmingAdventure.o"))
            {
                needsToBuild = true;
            }

            files ~= entry.name ~ " ";
        }
    }

    if(needsToBuild)
    {
        auto status = executeShell(command~files~libs);
        if(status.status !=0)
        {
            writeln(status.output);
        }
    }
}

/// Checks if the source file has been edited since the object file was built
bool needToBuild(string srcFile, string objFile)
{
    import std.file: exists, timeStamp = timeLastModified;

    return exists(objFile)? timeStamp(objFile) < timeStamp(srcFile) : true;
}
