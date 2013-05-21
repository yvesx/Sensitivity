MATLAB Compiler

1. Prerequisites for Deployment 

. Verify the MATLAB Compiler Runtime (MCR) is installed and ensure you    
  have installed version 7.15.   

. If the MCR is not installed, run MCRInstaller, located in:

  <matlabroot>*/toolbox/compiler/deploy/maci64/MCRInstaller.dmg

For more information on the MCR Installer, see the MATLAB Compiler 
documentation.    


NOTE: You will need administrator right to run MCRInstaller. 


2. Files to Deploy and Package

Files to package for Standalone 
================================
-run_estimateLassoLambda.sh (shell script run to temporarily set environment variables 
 and execute the application)
   -to run the shell script, type
   
       ./run_estimateLassoLambda.sh <mcr_directory> <argument_list>
       
    at Linux or Mac command prompt. <mcr_directory> is the directory 
    where version 7.15 of MCR is installed or the directory where 
    MATLAB is installed on the machine. <argument_list> is all the 
    arguments you want to pass to your application. For example, 

    If you have version 7.15 of MCR installed in 
    /mathworks/home/application/R2010a/v715, run the shell script as:
    
       ./run_estimateLassoLambda.sh /mathworks/home/application/R2010a/v715
       
    If you have MATLAB installed in /mathworks/devel/application/matlab, 
    run the shell script as:
    
       ./run_estimateLassoLambda.sh /mathworks/devel/application/matlab
-MCRInstaller.dmg 
   -include when building component by clicking "Add MCR" link 
    in deploytool
-The Macintosh bundle directory structure estimateLassoLambda.app 
   -this can be gathered up using the zip command 
    zip -r estimateLassoLambda.zip estimateLassoLambda.app
    or the tar command 
    tar -cvf estimateLassoLambda.tar estimateLassoLambda.app
-This readme file 

3. Definitions

For a complete list of product terminology, go to 
http://www.mathworks.com/help and select MATLAB Compiler.



* NOTE: <matlabroot> is the directory where MATLAB is installed on the target machine.


4. Appendix 

A. On the target machine, add the MCR directory to the environment variable DYLD_LIBRARY_PATH.

        NOTE: <mcr_root> is the directory where MCR is installed
              on the target machine.         


        . Add the MCR directory to the environment variable by issuing 
          the following commands:

            setenv DYLD_LIBRARY_PATH
                <mcr_root>/v715/runtime/maci64:
                <mcr_root>/v715/sys/os/maci64:
                <mcr_root>/v715/bin/maci64:
                /System/Library/Frameworks/JavaVM.framework/JavaVM:
                /System/Library/Frameworks/JavaVM.framework/Libraries
            setenv XAPPLRESDIR <mcr_root>/v715/X11/app-defaults


        NOTE: To make these changes persistent after logout on Linux 
              or Mac machines, modify the .cshrc file to include this  
              setenv command.
        NOTE: The environment variable syntax utilizes forward 
              slashes (/), delimited by colons (:).  
        NOTE: When deploying standalone applications, it is possible 
              to run the shell script file run_estimateLassoLambda.sh 
              instead of setting environment variables. See 
              section 2 "Files to Deploy and Package".    



5. Launching of application using Macintosh finder.

If the application is purely graphical, that is, it doesn't read from standard in or 
write to standard out or standard error, it may be launched in the finder just like any 
other Macintosh application.
