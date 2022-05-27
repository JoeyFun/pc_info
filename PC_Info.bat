::==========================================================================================
:: \\\\\\\\\\\\\\   Copyright © 2020-Present JoeyFun. All rights reserved.  ////////////////
::==========================================================================================

@echo off
COLOR 9F
echo.
echo       **   *******   ******** **    ** ******** **     ** ****     **
echo      /**  **/////** /**///// //**  ** /**///// /**    /**/**/**   /**
echo      /** **     //**/**       //****  /**      /**    /**/**//**  /**
echo      /**/**      /**/*******   //**   /******* /**    /**/** //** /**
echo      /**/**      /**/**////     /**   /**////  /**    /**/**  //**/**
echo  **  /**//**     ** /**         /**   /**      /**    /**/**   //****
echo //*****  //*******  /********   /**   /**      //******* /**    //***
echo  /////    ///////   ////////    //    //        ///////  //      ///             
echo.
echo.

::==================================================
:: \\\\\\\\\\\\\\   CMD Color Codes   //////////////
::==================================================
:: First Character is the Background
:: Second Character is the Text Color
::
:: Code (Hex)	Color
::=============================
:: 0			black
:: 1			blue
:: 2			green
:: 3			cyan
:: 4			red
:: 5			magenta
:: 6			yellow/brown
:: 7			white
:: 8			gray
:: 9			bright blue
:: A			bright green
:: B			bright cyan
:: C			bright red
:: D			bright magenta
:: E			bright yellow
:: F			white

::============================================
:: \\\\\\\\\\\\\\   Variables   //////////////
::============================================
SET drive=c:\_PC_Info\Logs
SET OutputFile=result.txt
SET tt=%time:~0,2%_%time:~3,2%_result.txt
SET folder=%date:/=-% %tt%
SET site1=8.8.8.8
SET site2=www.google.com
SET site3=localhost


::============================================
:: \\\\\\\\\\\\\\   Message   ////////////////
::============================================

GOTO Google

::======================================================
:: \\\\\\\\\\\\\\   Pinging Google DNS  ////////////////
::======================================================
:Google
ECHO Testing Internet...
ECHO.
PING -n 2 %site1% | find "Reply from"

::Check to see if ping was successful or unsuccesful
::successful = :found1
::unsuccessful = :nfound1
IF NOT ERRORLEVEL 1 GOTO found1
IF ERRORLEVEL 1 GOTO nfound1


::Check to see if folder exists
:found1
echo.
ECHO ************************
ECHO **** INTERNET IS ON ****
ECHO ************************
ECHO.
IF EXIST "%drive%\%folder%" GOTO :write1
IF NOT EXIST "%drive%\%folder%\" GOTO :create1

		::Folder found - writes output
		:write1
		ECHO Ping to Google DNS successful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
		GOTO techpowerup

		::Folder not found - creates folder and writes output
		:create1
		MD "%drive%\%folder%\"

		ECHO Ping to Google DNS successful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
		GOTO techpowerup

:nfound1
IF EXIST "%drive%\%folder%" GOTO :write2
IF NOT EXIST "%drive%\%folder%\" GOTO :create2

		:write2
		ECHO Ping to Google DNS unsuccessful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
		GOTO NoInternet

		:create2
		MD "%drive%\%folder%\"

		ECHO Ping to Google DNS unsuccessful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
		GOTO NoInternet

::===============================================
:: \\\\\\\\\\\\\\   15sec Delay  ////////////////
::===============================================

@PAUSE

::=========================================================
:: \\\\\\\\\\\\\\   Pinging Google Domain  ////////////////
::=========================================================
:techpowerup
PING -n 2 %site2% | find "Reply from"
IF NOT ERRORLEVEL 1 GOTO YesDNS
IF ERRORLEVEL 1 GOTO NoDNS
:YesDNS
ECHO.
COLOR 2F
ECHO *****************************
ECHO **** Google Domain FOUND ****
ECHO *****************************
ECHO.
ECHO Ping to Google Domain successful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
GOTO PCINFO


::===================================================
:: \\\\\\\\\\\\\\   Result Messages  ////////////////
::===================================================


:NoInternet
cls
COLOR 4F
ECHO.
ECHO    *******     ********   ********   **         **   ****     **   ********
ECHO   **/////**   /**/////   /**/////   /**        /**  /**/**   /**  /**///// 
ECHO  **     //**  /**        /**        /**        /**  /**//**  /**  /**      
ECHO /**      /**  /*******   /*******   /**        /**  /** //** /**  /******* 
ECHO /**      /**  /**////    /**////    /**        /**  /**  //**/**  /**////  
ECHO //**     **   /**        /**        /**        /**  /**   //****  /**      
ECHO  //*******    /**        /**        /********  /**  /**    //***  /********
ECHO   ///////     //         //         ////////   //   //      ///   //////// 
ECHO.
GOTO Finished

:NoDNS
cls
COLOR 0E
ECHO.
ECHO  ****     **     *******       *******     ****     **    ********
ECHO /**/**   /**    **/////**     /**////**   /**/**   /**   **////// 
ECHO /**//**  /**   **     //**    /**    /**  /**//**  /**  /**       
ECHO /** //** /**  /**      /**    /**    /**  /** //** /**  /*********
ECHO /**  //**/**  /**      /**    /**    /**  /**  //**/**  ////////**
ECHO /**   //****  //**     **     /**    **   /**   //****         /**
ECHO /**    //***   //*******      /*******    /**    //***   ******** 
ECHO //      ///     ///////       ///////     //      ///   ////////  
ECHO.
ECHO Ping to Google Domain unsuccessful on Date (%date%), Time (%time%). >>"%drive%\%folder%\%tt%"
GOTO Finished


::===========================================
:: \\\\\\\\\\\\\\   PC Info  ////////////////
::===========================================

:PCINFO
cls
echo -----------------------------
echo Computer Name
hostname
echo -----------------------------
echo Computer
wmic computersystem get model
echo -----------------------------
wmic bios get serialnumber
echo -----------------------------
echo MAC Address
getmac
echo -----------------------------
echo IP Address
ipconfig | findstr "IPv4 adapter"
ipconfig | findstr "Subnet Mask"
ipconfig | findstr "Default Gateway"
ipconfig /all | findstr /R "DNS\ Servers"
echo -----------------------------
GOTO Finished

::=========================================================
:: \\\\\\\\\\\\\\   PC Info Test finished  ////////////////
::=========================================================
:Finished
ECHO.
ECHO PC Info v1.3 test Completed!
ECHO.

:Finished2

@PAUSE
