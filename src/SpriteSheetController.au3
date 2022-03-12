Func _CreateGdiPlusBuffer()
    _GDIPlus_Startup()

    Global $hGraphics        = _GDIPlus_GraphicsCreateFromHWND(GUICtrlGetHandle($cPicture))
    Global $hBackBufferBMP   = _GDIPlus_BitmapCreateFromGraphics($aSingleSprite[$eWidth], $aSingleSprite[$eHeight], $hGraphics)
    Global $hBackBufferGraph = _GDIPlus_ImageGetGraphicsContext($hBackBufferBMP)

    _GDIPlus_GraphicsSetSmoothingMode($hGraphics, 0)
EndFunc

Func _DrawSpriteSheet($i)
    $sFileName = _GetJustFileName($aListOfSpriteSheetFiles[$i])

    GUICtrlSetData($cImageNameLabel, $aTexts[$eImage] & $sFileName)

    _DrawEachSingleSprite($aListOfSpriteSheetFiles[$i])
EndFunc

Func _DrawEachSingleSprite($sFileName)
    $hSpriteBitmap = _GDIPlus_ImageLoadFromFile($sFileName)

    For $iRow = 0 To $aSpriteSheet[$eHeight] - $aSingleSprite[$eHeight] Step $aSingleSprite[$eHeight]
        For $iColumn = 0 To $aSpriteSheet[$eWidth] - $aSingleSprite[$eWidth] Step $aSingleSprite[$eWidth]
            Local $sESC = '1B'

            If _IsPressed($sESC, 'user32.dll') Then
                _GuiDisposeAndExit()
            EndIf

            _DrawOnGui($iColumn, $iRow)

            Sleep(GUICtrlRead($cDrawSpeedInput))
        Next
    Next
EndFunc

Func _DrawOnGui($iX, $iY)
    Local $sReplacedColor = StringReplace($vColor, '#', '0xFF')
    Local $hBitmap        = _GetSingleSprite($hSpriteBitmap, $iX, $iY, $aSingleSprite[$eWidth], $aSingleSprite[$eHeight])

    If $bShouldSaveToSingleSprite Then
        _SaveSingleSprite($hBitmap)
    EndIf

    _GDIPlus_GraphicsClear($hBackBufferGraph, $sReplacedColor)
    _GDIPlus_GraphicsDrawImage($hBackBufferGraph, $hBitmap, 0, 0)
    _GDIPlus_GraphicsDrawImage($hGraphics, $hBackBufferBMP, 0, 0)
    _GDIPlus_BitmapDispose($hBitmap)
EndFunc

Func _GetSingleSprite($hSpriteBitmap, $iX, $iY, $iW, $iH)
    Local $hTargetBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hGraphics     = _GDIPlus_ImageGetGraphicsContext($hTargetBitmap)

    _GDIPlus_GraphicsDrawImageRect($hGraphics, $hSpriteBitmap, -$iX, -$iY, $iW * $aSpriteSheet[$eColumns], $iH * $aSpriteSheet[$eRows])
    _GDIPlus_GraphicsDispose($hGraphics)

    Return $hTargetBitmap
EndFunc

Func _SaveSingleSprite($hImage)
    Local $sFileExtension            = _GetJustFileExtension($sFileName)
    Local $sFileExtensionLength      = StringLen($sFileExtension) + 1
    Local $sFileNameWithoutExtension = StringTrimRight($sFileName, $sFileExtensionLength)
    Local $sTimestamp                = '_' & @HOUR & @MIN & @SEC & '_' & @MSEC
    Local $sGeneratedFileName        = $sFileNameWithoutExtension & $sTimestamp & '.' & $sFileExtension

    DirCreate($sSingleSpriteImagesPath)
    _GDIPlus_ImageSaveToFile($hImage, $sSingleSpriteImagesPath & $sGeneratedFileName)
EndFunc

Func _GuiDisposeAndExit()
    _GDIPlus_BitmapDispose($hSpriteBitmap)
    _GDIPlus_BitmapDispose($hBackBufferBMP)
    _GDIPlus_GraphicsDispose($hBackBufferGraph)
    _GDIPlus_GraphicsDispose($hGraphics)

    _GDIPlus_Shutdown()
    GUIDelete($aGui[$eHandle])

    Exit
EndFunc
