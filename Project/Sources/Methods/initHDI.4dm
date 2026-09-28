//%attributes = {"invisible":true}
If (Records in table:C83([SAMPLES:3])=0) | (Shift down:C543)
	
	ARRAY TEXT:C222($_Names; 0)
	ARRAY PICTURE:C279($_pictures; 10)
	ARRAY DATE:C224($_Dates; 10)
	ARRAY LONGINT:C221($_longint; 10)
	
	APPEND TO ARRAY:C911($_Names; "Alpha")
	APPEND TO ARRAY:C911($_Names; "Bravo")
	APPEND TO ARRAY:C911($_Names; "Charlie")
	APPEND TO ARRAY:C911($_Names; "Delta")
	APPEND TO ARRAY:C911($_Names; "Two strings, 'Hello' and 'there'")
	APPEND TO ARRAY:C911($_Names; "Foxtrot")
	APPEND TO ARRAY:C911($_Names; "Golf")
	APPEND TO ARRAY:C911($_Names; "Hotel")
	APPEND TO ARRAY:C911($_Names; "India")
	APPEND TO ARRAY:C911($_Names; "Juliett")
	
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"Icons"+Folder separator:K24:12+"icon_<x>.tiff"
	ARRAY PICTURE:C279($_pictures; 10)
	
	For ($i; 1; 10)
		$pathPict:=Replace string:C233($path; "<x>"; String:C10($i))
		READ PICTURE FILE:C678($pathPict; $_pictures{$i})
		
		$_Dates{$i}:=Current date:C33+(Random:C100%100)
		$_longint{$i}:=(Random:C100*1000)+Random:C100%1000
		
	End for 
	
	ALL RECORDS:C47([SAMPLES:3])
	DELETE SELECTION:C66([SAMPLES:3])
	
	ARRAY TO SELECTION:C261($_Names; [SAMPLES:3]fText:2; $_pictures; [SAMPLES:3]fPict:3; $_Dates; [SAMPLES:3]fDate:4; $_longint; [SAMPLES:3]fLong:5)
	
End if 
