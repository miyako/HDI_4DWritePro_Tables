//%attributes = {}
C_LONGINT:C283($1)

Case of 
	: (Count parameters:C259=0)
		
		var $dataClass; $project; $path : Text
		For each ($dataClass; ds:C1482)
			If (ds:C1482[$dataClass].getCount()=0)
				$path:=File:C1566("/RESOURCES/"+$dataClass+".4ie").platformPath
				If (Test path name:C476($path)=Is a document:K24:1)
					$project:=File:C1566("/RESOURCES/"+$dataClass+".4si").getText()
					IMPORT DATA:C665($path; $project)
				End if 
			End if 
		End for each 
		
		$pss:=New process:C317(Current method name:C684; 64000; Current method name:C684; Red:K11:4)
		
	Else 
		
		$Ref:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("HDI")
		CLOSE WINDOW:C154
		
		If (<>Quit=True:C214)
			QUIT 4D:C291
		Else 
			
			$Ref:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("HDI2")
			CLOSE WINDOW:C154
			
		End if 
		
End case 

