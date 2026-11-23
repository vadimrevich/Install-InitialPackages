/* ********************************************************
 * getWinOperationSystems
 * A Set of functions which reads the Windows Operation
 * System Settings
 *
***********************************************************/

/* ********************************************************
 * getWinOperationSystemsMain
 * A main function
 * *******************************************************/

function getWinOperationSystemsMain() {

    // Set Variables

    var aRes = 0;
    var objWMI, colOS, Serv;
    var aSystemInformation = "";
    var fso = new ActiveXObject("Scripting.FileSystemObject");

    try {
        objWMI = new ActiveXObject( "WbemScripting.SWbemLocator" );
    }
    catch(e) {
        WScript.echo("WMI Object Create Error: " +e.message);
            return -0;
    }

    try {
        Serv = objWMI.ConnectServer(".", "root\\cimv2");
    }
    catch(err2) {
        WScript.Echo("WMI Connector Error" + err2.message);
        return 0;
    }
    
    // Os Parameter Items (auxiliary)
    var anOSItems = "BuildNumber, Caption, CountryCode, CSDVersion, CSName, CurrentTimeZone, Description, Distributed, InstallDate, LocalDateTime, Locale, Manufacturer, Name, NumberOfLicensedUsers, NumberOfUsers, OperatingSystemSKU, Organization, OSArchitecture, OSLanguage, OSType, PlusProductID, Primary, ProductType, RegisteredUser, SerialNumber, SystemDirectory, Version";

    try {
        var colOS = Serv.ExecQuery("SELECT " + anOSItems + " FROM Win32_OperatingSystem");
    }
    catch(err){
        WScript.Echo("WMI Query Error: "+err.message) 
        return 0;
    }
    

    if(colOS.Count > 0 ) {

        var objOS = colOS.ItemIndex(0);
        var aProdTypeNo, aProdTypeName;
        var aVersion, verArray;
        aVersion=objOS.Version;
        verArray=aVersion.split('.');


        aProdTypeNo = objOS.ProductType;
        if(aProdTypeNo == 0 )
            aProdTypeName = "Unknown";
        else if( aProdTypeNo==1 )
            aProdTypeName="Workstation";
        else if( aProdTypeNo==2 )
            aProdTypeName=	"Domain Controller Server";
        else if( aProdTypeNo==3 )
            aProdTypeName ="Standalone Server";
        else
            aProdTypeName="ERROR";


        aSystemInformation += "OS Name: " + objOS.Name + "\n\n";
        // aSystemInformation += "Description" + objOS.Description + "\n";
        aSystemInformation += "OS Caption: " + objOS.Caption +"\n";
        //aSystemInformation += "OS SCU: " + objOS.OperatingSystemSku + "\n";
        aSystemInformation += "Version Major: "+ verArray[0] + "\n";
        aSystemInformation += "Version Minor: "   +verArray[1]+"\n";
        aSystemInformation += "Build number: " + objOS.Buildnumber + "\n";
        aSystemInformation += "OS Product type: " + aProdTypeName+"\n";
        aSystemInformation += "CSD Version: " + objOS.CSDVersion + "\n";
        aSystemInformation += "Serial Namber: "  + objOS.SerialNumber + "\n";
        aSystemInformation += "OS Type: "  + objOS.OSType + "\n";
        // aSystemInformation += "Plus Product ID: "  + objOS.PlusProductID + "\n";
        aSystemInformation += "BIOS Name: " + objOS.CSName + "\n";
        aSystemInformation += "Manufacturer: " + objOS.Manufacturer + "\n";
        aSystemInformation += "Os Version: " + objOS.Version + "\n";
        aSystemInformation += "Kernel Version: " + fso.GetFileVersion("C:\\Windows\\System32\\kernel32.dll") + "\n";

        // WScript.Echo("Разрядность: " + objOS.OSArchitecture + " (" + (objOS.OSArchitecture == "64-bit" ? "64-битная" : "32-битная") + ")");
        WScript.Echo(aSystemInformation);

        aSystemInformation = "";
        aSystemInformation += "Os Architecture: "  + objOS.OSArchitecture + "\n";
        aSystemInformation += "Locale: " + objOS.Locale + "\n";
        aSystemInformation += "Country Code: " + objOS.CountryCode +"\n";
        aSystemInformation += "OS Language: " + objOS.OSLanguage +"\n";
        aSystemInformation += "Current Time Zone: " + objOS.CurrentTimezone + "\n";
        aSystemInformation += "LocalDateTime: " + objOS.LocalDateTime + "\n";
        aSystemInformation += "Install Date: " + objOS.InstallDate + "\n";
        aSystemInformation += "Organization: " + objOS.Organization +"\n";
        aSystemInformation += "Registred User: " + objOS.RegistredUser + "\n";
        aSystemInformation += "Number of Users: " + objOS.NumberOfUsers + "\n";
        aSystemInformation += "Number of Licensed Users: " + objOS.NunberOfLicensedUsers + "\n";

        WScript.Echo(aSystemInformation);

    }
    else {
        WScript.Echo("Data are not found!");
    }

    return aRes;
}

// Test Main
getWinOperationSystemsMain();
