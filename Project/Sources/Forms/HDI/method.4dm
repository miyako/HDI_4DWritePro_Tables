Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		If (Is license available:C714(4D Write license:K44:2)#True:C214)
			Form.quit:=True:C214
			OBJECT SET TITLE:C194(*; "BtnDemo"; Localized string("BtnClose"))
			OBJECT SET VISIBLE:C603(*; "TxtLicence"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
		Else 
			Form.quit:=False:C215
		End if 
		
End case 
