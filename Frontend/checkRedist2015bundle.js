/* ********************************************************
 * checkRedist2015bundle.js
 * This function will check if MSVC Redistributable
 * 2015 Bundle is installed
 *
***********************************************************/

function getOSArchiectureWMI(){

    // Set Variables

    var anArch = 0;
    var objWMI, colOS, Serv;
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
    
    try {
        var colOS = Serv.ExecQuery("SELECT OSArchitecture FROM Win32_OperatingSystem");
    }
    catch(err){
        WScript.Echo("WMI Query Error: "+err.message) 
        return 0;
    }
    
    var i;

    if(colOS.Count > 0 ) {

        var objOS = colOS.ItemIndex(0);

        anArchitecture=objOS.OSArchitecture;

        // WScript.Echo(anArchitecture);

        // WScript.Echo("Разрядность: " + objOS.OSArchitecture + " (" + (objOS.OSArchitecture == "64-bit" ? "64-битная" : "32-битная") + ")");
        if(anArchitecture.indexOf('64') === 0 ) {anArch = 64;}
        else if(anArchitecture.indexOf('32') === 0 ) {anArch = 32;}
        else {
          anArch = 0;
        }
    }
    else {
        WScript.Echo("Data are not found!");
    }

    return anArch;
}

function checkRedist2015bundle() {

    // Set Variables
    var anArch = getOSArchiectureWMI();
    var Sys32="C:\\Windows\\System32";
    var SysWow;
    if( anArch === 64 ) {
        SysWow="C:\\Windows\\SysWOW64";
    }
    else if(anArch === 32) {
        SysWow==Sys32;
    }
    else {
        return 1;
    }
    // var components = new Array("vcruntime140.dll", "concrt140.dll", "msvcp140.dll", "vccorlib140.dll", "mfc140.dll", "mfcmifc140.dll");
    var components = new Array("vcruntime140.dll", "concrt140.dll", "msvcp140.dll", "vccorlib140.dll", "mfc140.dll");
    var i;
    var iRes = 0;
    var fso = new ActiveXObject("Scripting.FileSystemObject");

    for (i = 0; i < components.length; i++) {
        var component = components[i];
        var compon32 = Sys32 + "\\" + component;
        var componwow = SysWow + "\\" + component;
        if (! fso.FileExists(compon32)) {
            WScript.Echo("Component " + compon32 + " is not Installed.");
            iRes = 1;
        }
        if (! fso.FileExists(componwow)) {
            WScript.Echo("Component " + componwow + " is not installed.");
            iRes = 1;
        }
    }
    return iRes;
}

/// Test
WScript.Echo("OS Architecture:" + getOSArchiectureWMI() + " bits");
if(checkRedist2015bundle()==0){
    WScript.Echo("MSVC Redistributable 2015 Bundle is Installed");
}
else{
    WScript.Echo("MSVC Redistributable 2015 Bundle is not Installed");
}
    