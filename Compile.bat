@echo off
cls
echo Compiling ASM files...

ml /c main.asm
ml /c graphics.asm
ml /c mouse.asm
ml /c utils.asm
link16 main.obj graphics.obj mouse.obj utils.obj

echo Build complete!
