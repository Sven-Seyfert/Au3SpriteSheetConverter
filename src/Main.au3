; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 1.3.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, Au3SpriteSheetConverter)
#pragma compile(ProductVersion, 1.3.0 - 2022-03-12)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\icons\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\Au3SpriteSheetConverter.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('Au3SpriteSheetConverter.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <File.au3>
#include <GDIPlus.au3>
#include <Misc.au3>
#include <String.au3>
#include <WindowsConstants.au3>



; modules ----------------------------------------------------------------------
#include "Enum.au3"
#include "TextContainer.au3"
#include "Initializer.au3"
#include "FunctionController.au3"
#include "GuiBuilder.au3"
#include "SpriteSheetController.au3"



; processing -------------------------------------------------------------------
Global $sSpriteSheetFolderPath  = _GetSpriteSheetFolder()
Global $sSpriteSheetFolderName  = _GetJustFolderName($sSpriteSheetFolderPath)
       $aListOfSpriteSheetFiles = _GetFilesOfFolder($sSpriteSheetFolderPath)
Global $iSpriteSheetFilesCount  = _GetCount($aListOfSpriteSheetFiles)

_SetSpriteSheetData($sSpriteSheetFolderName)
_SetSingleSpriteData()
_SetGuiData()
_CreateGui()
_DrawSpriteSheet(1)

While True
    Switch GUIGetMsg()
        Case $iEXIT
            _GuiDisposeAndExit()

        Case $cExitButton
            _GuiDisposeAndExit()

        Case $cPreviewButton
            If $iCurrentSpriteSheetFileIndex >= 1 Then
                $iCurrentSpriteSheetFileIndex -= 1
            EndIf

            If $iCurrentSpriteSheetFileIndex < 1 Then
                $iCurrentSpriteSheetFileIndex = $iSpriteSheetFilesCount
            EndIf

            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cReloadButton
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cNextButton
            If $iCurrentSpriteSheetFileIndex <= $iSpriteSheetFilesCount Then
                $iCurrentSpriteSheetFileIndex += 1
            EndIf

            If $iCurrentSpriteSheetFileIndex > $iSpriteSheetFilesCount Then
                $iCurrentSpriteSheetFileIndex = 1
            EndIf

            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cSaveButton
            $bShouldSaveToSingleSprite = True

            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)
            ShellExecute($sSingleSpriteImagesPath)

            $bShouldSaveToSingleSprite = False

        Case $cDefaultColorButton
            _SetColor($sDefaultColor)
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cRedColorButton
            _SetColor($sRedColor)
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cGreenColorButton
            _SetColor($sGreenColor)
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cBlackColorButton
            _SetColor($sBlackColor)
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cWhiteColorButton
            _SetColor($sWhiteColor)
            _DrawSpriteSheet($iCurrentSpriteSheetFileIndex)
    EndSwitch
WEnd
