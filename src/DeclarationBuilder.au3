Global Const $iEXIT                  = -3
Global Const $iLASTCREATEDCONTROLID  = -1
Global Const $vBORDERCOLOR           = 0x000000
Global Const $vONLYNUMBERINPUTS      = 0x2000

Global $iDrawDelay                   = 50
Global $iCurrentSpriteSheetFileIndex = 1
Global $bShouldSaveToSingleSprite    = False
Global $aListOfSpriteSheetFiles      = Null
Global $hSpriteBitmap, $sFileName
Global $sSingleSpriteImagesPath      = _PathFull('..\images\singleSpriteImages\')
Global $sSpriteSheetExampleImagePath = _PathFull('..\images\spriteSheets\')

Global $sDefaultColor                = '#ABCDEF'
Global $sRedColor                    = '#FF0000'
Global $sGreenColor                  = '#00FF00'
Global $sBlackColor                  = '#000000'
Global $sWhiteColor                  = '#FFFFFF'
Global $vColor                       = $sDefaultColor

Global $aSpriteSheet[$iMaxEnumIndex]
       $aSpriteSheet[$eWidth]        = Null
       $aSpriteSheet[$eHeight]       = Null
       $aSpriteSheet[$eRows]         = Null
       $aSpriteSheet[$eColumns]      = Null

Global $aSingleSprite[$iMaxEnumIndex]
       $aSingleSprite[$eWidth]       = Null
       $aSingleSprite[$eHeight]      = Null

Global $aGui[$iMaxEnumIndex]
       $aGui[$eHandle]               = Null
       $aGui[$eTitle]                = Null
       $aGui[$eWidth]                = Null
       $aGui[$eHeight]               = Null
       $aGui[$eXPosition]            = Null
       $aGui[$eYPosition]            = Null

Global $cImageNameLabel              = Null
Global $cDrawSpeedLabel              = Null
Global $cDrawSpeedInput              = Null
Global $cPreviewButton               = Null
Global $cReloadButton                = Null
Global $cNextButton                  = Null
Global $cDefaultColorButton          = Null
Global $cRedColorButton              = Null
Global $cGreenColorButton            = Null
Global $cBlackColorButton            = Null
Global $cWhiteColorButton            = Null
Global $cSaveButton                  = Null
Global $cExitButton                  = Null
Global $cPicture                     = Null
