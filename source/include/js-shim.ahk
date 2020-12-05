﻿global $ := {}
$.beep := Func("jsShim_50")
$.click := Func("jsShim_49")
global __index_debounce__ := 0
global __timer_debounce__ := {}
$.debounce := Func("jsShim_48")
$.delay := Func("jsShim_46")
$.exit := Func("jsShim_45")
$.findColor := Func("jsShim_44")
$.findImage := Func("jsShim_43")
$.formatHotkey := Func("jsShim_42")
$.getColor := Func("jsShim_41")
$.getPosition := Func("jsShim_40")
$.getState := Func("jsShim_39")
$.i := Func("jsShim_38")
$.includes := Func("jsShim_37")
$.info := Func("jsShim_36")
$.length := Func("jsShim_35")
$.move := Func("jsShim_34")
$.now := Func("jsShim_33")
$.off := Func("jsShim_32")
$.on := Func("jsShim_31")
$.open := Func("jsShim_30")
$.play := Func("jsShim_29")
$.press := Func("jsShim_28")
$.random := Func("jsShim_27")
$.reload := Func("jsShim_26")
$.replace := Func("jsShim_25")
$.reverse := Func("jsShim_24")
$.setFixed := Func("jsShim_23")
$.sleep := Func("jsShim_22")
$.split := Func("jsShim_21")
$.suspend := Func("jsShim_20")
global __index_throttle__ := 0
global __timer_throttle__ := {}
global __ts_throttle__ := {}
$.throttle := Func("jsShim_19")
$.toLowerCase := Func("jsShim_16")
$.toString := Func("jsShim_15")
$.toUpperCase := Func("jsShim_14")
$.trim := Func("jsShim_13")
$.trimEnd := Func("jsShim_12")
$.trimStart := Func("jsShim_11")
$.type := Func("jsShim_10")
global alert := Func("jsShim_9")
global clearInterval := Func("jsShim_8")
global clearTimeout := Func("jsShim_7")
global Math := {abs: Func("jsShim_6"), ceil: Func("jsShim_5"), floor: Func("jsShim_4"), round: Func("jsShim_3")}
global setInterval := Func("jsShim_2")
global setTimeout := Func("jsShim_1")
jsShim_1(callback, time) {
  if (($.type.Call(callback)) == "function") {
    callback := callback.Bind()
  }
  __type__ := $.type.Call(time)
  if !(__type__ == "number") {
    throw Exception("setTimeout: invalid time type '" . (__type__) . "'")
  }
  if (time <= 0) {
    time := 1
  }
  SetTimer, % callback, % 0 - time
  return callback
}
jsShim_2(callback, time) {
  if (($.type.Call(callback)) == "function") {
    callback := callback.Bind()
  }
  __type__ := $.type.Call(time)
  if !(__type__ == "number") {
    throw Exception("setTimeout: invalid time type '" . (__type__) . "'")
  }
  if !(time > 0) {
    throw Exception("setTimeout: invalid time value '" . (time) . "'")
  }
  SetTimer, % callback, % time
  return callback
}
jsShim_3(n) {
  return Round(n)
}
jsShim_4(n) {
  return Floor(n)
}
jsShim_5(n) {
  return Ceil(n)
}
jsShim_6(n) {
  return Abs(n)
}
jsShim_7(callback) {
  if !(callback) {
    return
  }
  SetTimer, % callback, Delete
}
jsShim_8(callback) {
  if !(callback) {
    return
  }
  SetTimer, % callback, Delete
}
jsShim_9(message := "") {
  __msg__ := $.toString.Call(message)
  MsgBox, % __msg__
}
jsShim_10(input) {
  if input is Number
    return "number"
  if (IsFunc(input)) {
    return "function"
  }
  if (IsObject(input)) {
    if (input.Count() == input.Length()) {
      return "array"
    }
    return "object"
  }
  return "string"
}
jsShim_11(input, omitting := " `t") {
  return LTrim(input, omitting)
}
jsShim_12(input, omitting := " `t") {
  return RTrim(input, omitting)
}
jsShim_13(input, omitting := " `t") {
  return Trim(input, omitting)
}
jsShim_14(input) {
  StringUpper, __result__, input
  return __result__
}
jsShim_15(input) {
  __type__ := $.type.Call(input)
  if (__type__ == "array") {
    __result__ := ""
    for __i__, key in input {
      __result__ := "" . (__result__) . ", " . ($.toString.Call(key)) . ""
    }
    return "[" . ($.trim.Call(__result__, " ,")) . "]"
  } else if (__type__ == "object") {
    __result__ := ""
    for key, value in input {
      __result__ := "" . (__result__) . ", " . (key) . ": " . ($.toString.Call(value)) . ""
    }
    return "{" . ($.trim.Call(__result__, " ,")) . "}"
  }
  return input
}
jsShim_16(input) {
  StringLower, __result__, input
  return __result__
}
jsShim_17(index, callback) {
  callback.Call()
  __ts_throttle__[index] := $.now.Call()
}
jsShim_18(index, time, callback) {
  clearTimeout.Call(__timer_throttle__[index])
  __timer_throttle__[index] := setTimeout.Call(Func("jsShim_17").Bind(index, callback), __ts_throttle__[index] - $.now.Call() + time)
}
jsShim_19(time, callback) {
  __index_throttle__++
  __ts_throttle__[__index_throttle__] := 0
  return Func("jsShim_18").Bind(__index_throttle__, time, callback)
}
jsShim_20(isSuspended := "Toggle") {
  if (isSuspended != "Toggle") {
    if (isSuspended) {
      isSuspended := "On"
    } else {
      isSuspended := "Off"
    }
  }
  Suspend, % isSuspended
}
jsShim_21(input, delimiter) {
  return StrSplit(input, delimiter)
}
jsShim_22(time) {
  Sleep, % time
}
jsShim_23(isFixed := "Toggle") {
  if (isFixed != "Toggle") {
    if (isFixed) {
      isFixed := "On"
    } else {
      isFixed := "Off"
    }
  }
  Winset AlwaysOnTop, % isFixed, A
}
jsShim_24(input) {
  __type__ := $.type.Call(input)
  if !(__type__ == "array") {
    throw Exception("$.reverse: invalid type '" . (__type__) . "'")
  }
  __len__ := $.length.Call(input)
  __output__ := []
  for i, key in input {
    __output__[__len__ - i + 1] := key
  }
  return __output__
}
jsShim_25(input, searchment, replacement, limit := -1) {
  return StrReplace(input, searchment, replacement, limit)
}
jsShim_26() {
  Reload
}
jsShim_27(min := 0, max := 1) {
  Random, __result__, min, max
  return __result__
}
jsShim_28(listInput*) {
  if !($.length.Call(listInput)) {
    throw Exception("$.press: invalid key")
  }
  __listKey__ := []
  for __i__, input in listInput {
    __input__ := $.toLowerCase.Call(input)
    __input__ := $.replace.Call(__input__, " ", "")
    __input__ := $.replace.Call(__input__, "-", "")
    __list__ := $.split.Call(__input__, "+")
    for __i__, it in __list__ {
      __listKey__.Push(it)
    }
  }
  __listResult__ := []
  __len__ := $.length.Call(__listKey__)
  for i, key in __listKey__ {
    if (i == __len__) {
      __listResult__[i] := $.split.Call(key, ":")
      continue
    }
    if ($.includes.Call(key, ":")) {
      __listResult__[i] := $.split.Call(key, ":")
      __listResult__[__len__ * 2 - i] := $.split.Call(key, ":")
    } else {
      __listResult__[i] := [key, "down"]
      __listResult__[__len__ * 2 - i] := [key, "up"]
    }
  }
  for i, it in __listResult__ {
    if (it[1] == "win") {
      it[1] := "lwin"
    }
    __listResult__[i] := $.trim.Call("" . (it[1]) . " " . (it[2]) . "")
  }
  __output__ := ""
  for __i__, it in __listResult__ {
    __output__ := "" . (__output__) . "{" . (it) . "}"
  }
  Send, % __output__
}
jsShim_29(filename) {
  SoundPlay, % filename
}
jsShim_30(source) {
  Run, % source
}
jsShim_31(key, callback) {
  key := $.formatHotkey.Call(key)
  Hotkey, % key, % callback, On
}
jsShim_32(key, callback) {
  key := $.formatHotkey.Call(key)
  Hotkey, % key, % callback, Off
}
jsShim_33() {
  return A_TickCount
}
jsShim_34(point := "", speed := 0) {
  if !(point) {
    throw Exception("$.move: invalid point")
  }
  MouseMove, point[1], point[2], speed
}
jsShim_35(input) {
  __type__ := $.type.Call(input)
  switch __type__ {
    case "array": {
      return input.Length()
    }
    case "object": {
      return input.Count()
    }
    case "string": {
      return StrLen(input)
    }
    default: {
      throw Exception("$.length: invalid type '" . (__type__) . "'")
    }
  }
}
jsShim_36(message, point := "") {
  if !(message) {
    return message
  }
  if !(point) {
    point := $.getPosition.Call()
  }
  __msg__ := $.toString.Call(message)
  ToolTip, % __msg__, % point[1], % point[2]
  return message
}
jsShim_37(input, needle) {
  __type__ := $.type.Call(input)
  if (__type__ == "string" || __type__ == "number") {
    return (InStr(input, needle)) > 0
  }
  if (__type__ == "array") {
    for __i__, it in input {
      if (it == needle) {
        return true
      }
    }
    return false
  }
  throw Exception("$.includes: invalid type '" . (__type__) . "'")
}
jsShim_38(message) {
  $.info.Call("" . ($.now.Call()) . " " . ($.toString.Call(message)) . "")
  return message
}
jsShim_39(key) {
  return GetKeyState(key, "P")
}
jsShim_40() {
  MouseGetPos, __x__, __y__
  return [__x__, __y__]
}
jsShim_41(point := "") {
  if !(point) {
    point := $.getPosition.Call()
  }
  PixelGetColor, __result__, % point[1], % point[2], RGB
  return __result__
}
jsShim_42(key) {
  __listkey__ := []
  __key__ := $.toLowerCase.Call(key)
  __key__ := $.replace.Call(__key__, " ", "")
  __key__ := $.replace.Call(__key__, "-", "")
  _list := $.split.Call(__key__, "+")
  for __i__, it in _list {
    __listkey__.Push(it)
  }
  __isAlt__ := false
  __isCtrl__ := false
  __isShift__ := false
  __isWin__ := false
  __listResult__ := []
  for __i__, key in __listkey__ {
    if (key == "alt") {
      __isAlt__ := true
      continue
    }
    if (key == "ctrl") {
      __isCtrl__ := true
      continue
    }
    if (key == "shift") {
      __isShift__ := true
      continue
    }
    if (key == "win") {
      __isWin__ := true
      continue
    }
    __listResult__.Push(key)
  }
  __prefix__ := ""
  if (__isAlt__) {
    __prefix__ := "" . (__prefix__) . "!"
  }
  if (__isCtrl__) {
    __prefix__ := "" . (__prefix__) . "^"
  }
  if (__isShift__) {
    __prefix__ := "" . (__prefix__) . "+"
  }
  if (__isWin__) {
    __prefix__ := "" . (__prefix__) . "#"
  }
  __result__ := ""
  for __i__, it in __listResult__ {
    __result__ := "" . (__result__) . " & " . (it) . ""
  }
  return $.replace.Call("" . (__prefix__) . "" . ($.trim.Call(__result__, " &")) . "", ":", " ")
}
jsShim_43(source, start := "", end := "") {
  if !(start) {
    start := [0, 0]
  }
  if !(end) {
    end := [A_ScreenWidth, A_ScreenHeight]
  }
  ImageSearch __x__, __y__, start[1], start[2], end[1], end[2], % A_ScriptDir . "\\\" . source
  return [__x__, __y__]
}
jsShim_44(color, start := "", end := "", variation := 0) {
  if !(start) {
    start := [0, 0]
  }
  if !(end) {
    end := [A_ScreenWidth, A_ScreenHeight]
  }
  PixelSearch __x__, __y__, start[1], start[2], end[1], end[2], color, variation, Fast RGB
  return [__x__, __y__]
}
jsShim_45() {
  ExitApp
}
jsShim_46(time, callback) {
  __timer__ := setTimeout.Call(callback, time)
  return __timer__
}
jsShim_47(index, time, callback) {
  clearTimeout.Call(__timer_debounce__[index])
  __timer_debounce__[index] := setTimeout.Call(callback, time)
}
jsShim_48(time, callback) {
  __index_debounce__++
  return Func("jsShim_47").Bind(__index_debounce__, time, callback)
}
jsShim_49(key := "left") {
  key := $.replace.Call(key, "-", "")
  key := $.replace.Call(key, ":", " ")
  Click, % key
}
jsShim_50() {
  SoundBeep
}