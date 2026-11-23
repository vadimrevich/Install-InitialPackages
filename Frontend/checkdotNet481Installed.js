/* ********************************************************
 *
 * checkdotNet481Installed.js
 * These Scripts will check if Microsoft .Net Framework
 * 4.5 -- 4.8.1 are Installed
 *
***********************************************************/

function IsNet481Installed(){

    // Set Variables
    var wsh= new ActiveXObject("WScript.Shell");
    var RegParm01="HKLM\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full\\Release";
    try {
        var keyValue =wsh.RegRead(RegParm01);
        var bResult = (keyValue >= 533320);
    }
    catch(err){
        bResult = false;
    }
    return(bResult);
}

function CheckNet45pInstalled() {

    // Set Variables
    var wsh= new ActiveXObject("WScript.Shell");
    var RegParm01="HKLM\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full\\Release";
    try {
        var result=wsh.RegRead(RegParm01);

        if(result>=533320)
            return "4.8.1";
        else if(result >= 528040)
            return"4.8";
        else if(result >= 461808)
            return "4.7.2";
        else if(result >= 461308)
            return "4.7.1";
        else if(result >= 460798)
            return "4.7";
        else if(result >= 394802)
            return "4.6.2";
        else if(result >= 394254)
            return "4.6.1";
        else if(result >= 393295)
            return "4.6";
        else if(result >= 379893)
            return "4.5.2";
        else if(result >= 378675)
            return "4.5.1";
        else if(result >= 378389)
            return "4.5"
        else
            return "Unknown";
    }
    catch(e) { 
        return "Unknown Error";
    }
}

/// Test
WScript.Echo("Is a .Net Framework 4.8.1. installed? " + IsNet481Installed());
WScript.Echo("Thete is a .Net Framework version to be installed: " + CheckNet45pInstalled());
