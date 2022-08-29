unit ConsoleOutput;

interface

function CaptureConsoleOutput(const ACommand, AParameters: String): TStringList;

implementation

function CaptureConsoleOutput(const ACommand, AParameters: String): TStringList;
   const
     CReadBuffer = 2400;
   var
     saSecurity: TSecurityAttributes;
     hRead: THandle;
     hWrite: THandle;
     suiStartup: TStartupInfo;
     piProcess: TProcessInformation;
     pBuffer: array[0..CReadBuffer] of Char;
     dRead: DWord;
     dRunning: DWord;
     sl : tstringlist;
  begin
     saSecurity.nLength := SizeOf(TSecurityAttributes);
     saSecurity.bInheritHandle := True;
     saSecurity.lpSecurityDescriptor := nil;
     result := tstringlist.Create;
     sl := tstringlist.create;
     if CreatePipe(hRead, hWrite, @saSecurity, 0) then
     begin    
       FillChar(suiStartup, SizeOf(TStartupInfo), #0);
       suiStartup.cb := SizeOf(TStartupInfo);
       suiStartup.hStdInput := hRead;
       suiStartup.hStdOutput := hWrite;
       suiStartup.hStdError := hWrite;
       suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;    
       suiStartup.wShowWindow := SW_HIDE; 
 
       if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity,
         @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess)
         then
       begin
         repeat
           dRunning  := WaitForSingleObject(piProcess.hProcess, 100);        
           Application.ProcessMessages();
           repeat
             dRead := 0;
             ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);          
             pBuffer[dRead] := #0; 

             OemToAnsi(pBuffer, pBuffer);
             sl.Add(trim(String(pBuffer)));
           until (dRead < CReadBuffer);
         until (dRunning <> WAIT_TIMEOUT);
         CloseHandle(piProcess.hProcess);
         CloseHandle(piProcess.hThread);
       end;

       CloseHandle(hRead);
       CloseHandle(hWrite);
       result.Text := sl.Text;
     end;
  end;

end.
 