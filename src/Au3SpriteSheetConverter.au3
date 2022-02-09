; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 1.1.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, Au3SpriteSheetConverter)
#pragma compile(ProductVersion, 1.1.0 - 2022-02-09)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
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



; references -------------------------------------------------------------------
#include "Enum.au3"
#include "TextContainer.au3"
#include "DeclarationBuilder.au3"
#include "FunctionController.au3"
#include "GuiBuilder.au3"
#include "SpriteSheetController.au3"



; processing -------------------------------------------------------------------
Global $sSpriteSheetFolderPath  = _getSpriteSheetFolder()
Global $sSpriteSheetFolderName  = _getJustFolderName($sSpriteSheetFolderPath)
       $aListOfSpriteSheetFiles = _getFilesOfFolder($sSpriteSheetFolderPath)
Global $iSpriteSheetFilesCount  = _getCount($aListOfSpriteSheetFiles)

_setSpriteSheetData($sSpriteSheetFolderName)
_setSingleSpriteData()
_setGuiData()
_createGui()
_drawSpriteSheet(1)

While True
    Switch GUIGetMsg()
        Case $iEXIT
            _guiDisposeAndExit()

        Case $cExitButton
            _guiDisposeAndExit()

        Case $cPreviewButton
            If $iCurrentSpriteSheetFileIndex >= 1 Then
                $iCurrentSpriteSheetFileIndex -= 1
            EndIf

            If $iCurrentSpriteSheetFileIndex < 1 Then
                $iCurrentSpriteSheetFileIndex = $iSpriteSheetFilesCount
            EndIf

            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cReloadButton
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cNextButton
            If $iCurrentSpriteSheetFileIndex <= $iSpriteSheetFilesCount Then
                $iCurrentSpriteSheetFileIndex += 1
            EndIf

            If $iCurrentSpriteSheetFileIndex > $iSpriteSheetFilesCount Then
                $iCurrentSpriteSheetFileIndex = 1
            EndIf

            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cSaveButton
            $bShouldSaveToSingleSprite = True

            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)
            ShellExecute( $sSingleSpriteImagesPath )

            $bShouldSaveToSingleSprite = False

        Case $cDefaultColorButton
            _setColor($sDefaultColor)
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cRedColorButton
            _setColor($sRedColor)
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cGreenColorButton
            _setColor($sGreenColor)
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cBlackColorButton
            _setColor($sBlackColor)
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)

        Case $cWhiteColorButton
            _setColor($sWhiteColor)
            _drawSpriteSheet($iCurrentSpriteSheetFileIndex)
    EndSwitch
WEnd
