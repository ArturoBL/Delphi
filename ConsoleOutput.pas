unit ConsoleOutput;



interface

uses Windows,Forms,classes,SysUtils;

function CaptureConsoleOutput(const ACommand, AParameters: String): TStringList;      // a veces se bloquea
function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;             // Nueva función con directorio de trabajo y no se bloquea

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

function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

end.
