Func _GetSpriteSheetFolder()
    Local $sFolderPath = FileSelectFolder($aTexts[$eFolderSelectDialogText], $sSpriteSheetExampleImagePath)

    If @error == 1 Then
        MsgBox(48, $aTexts[$eWarning], $aTexts[$eWarningNoFolderSelected], 30)
        Exit -1
    EndIf

    Return $sFolderPath
EndFunc

Func _GetFilesOfFolder($sFolder)
    Return _FileListToArray($sFolder, '*.png', 1, True)
EndFunc

Func _SetSpriteSheetData($sFolder)
    $aSpriteSheet[$eWidth]   = StringRegExp($sFolder, '(\d+)', 3)[2]
    $aSpriteSheet[$eHeight]  = StringRegExp($sFolder, '(\d+)', 3)[3]
    $aSpriteSheet[$eRows]    = StringRegExp($sFolder, '(\d+)', 3)[1]
    $aSpriteSheet[$eColumns] = StringRegExp($sFolder, '(\d+)', 3)[0]
EndFunc

Func _SetSingleSpriteData()
    $aSingleSprite[$eWidth]  = $aSpriteSheet[$eWidth]  / $aSpriteSheet[$eColumns]
    $aSingleSprite[$eHeight] = $aSpriteSheet[$eHeight] / $aSpriteSheet[$eRows]
EndFunc

Func _SetGuiData()
   $aGui[$eWidth]     = 354
   $aGui[$eHeight]    = $aSingleSprite[$eHeight] + 145
   $aGui[$eXPosition] = Default
   $aGui[$eYPosition] = Default
EndFunc

Func _SetColor($sColor)
    $vColor = $sColor
EndFunc

Func _GetJustFolderName($sFilePath)
    Return _GetJustFileName($sFilePath)
EndFunc

Func _GetJustFileName($sFilePath)
    Return StringRegExpReplace($sFilePath, '(.+?)\\', '', 0)
EndFunc

Func _GetJustFileExtension($sFileName)
    Return StringReverse(_StringBetween(StringReverse($sFileName), '', '.')[0])
EndFunc

Func _GetCount($aList)
    Return $aList[0]
EndFunc
