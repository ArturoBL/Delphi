unit NetworkUtils;

interface

uses winsock,windows,classes,StdCtrls;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..100] of TNetResource;

  TSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TSunW = packed record
    s_w1, s_w2: word;
  end;

  PIPAddr = ^TIPAddr;
  TIPAddr = record
    case integer of
      0: (S_un_b: TSunB);
      1: (S_un_w: TSunW);
      2: (S_addr: longword);
  end;

 IPAddr = TIPAddr;

function IAddrToHostName(const IP: string): string;

function CreateNetResourceList(ResourceType: DWord;
                              NetResource: PNetResource;
                              out Entries: DWord;
                              out List: PNetResourceArray): Boolean;
procedure ScanNetworkResources(ResourceType, DisplayType: DWord; List: TStrings);


function LocalIP: string;
function IPAddrToName(IPAddr: string): string;
function GetIPFromHost(const HostName: string): string;
function ConnectDrive(_drvLetter: string; _netPath: string; _showError: Boolean;
  _reconnect: Boolean): DWORD;
function ConnectPrinterDevice(_lptPort: string; _netPath: string; _showError: Boolean;
  _reconnect: Boolean): DWORD;
function DisconnectNetDrive(_locDrive: string; _showError: Boolean; _force: Boolean;
  _save: Boolean): DWORD;
function GetMACAdress: string;

function NetSend(dest, Source, Msg: string): Longint; overload;
function NetSend(Dest, Msg: string): Longint; overload;
function NetSend(Msg: string): Longint; overload;
procedure shut(system, nachricht: string; force, reboot: Boolean; countdown: Integer);
procedure abortshut(system: string);

function Ping(InetAddress : string) : boolean;

function Ping2(InetAddress : string; numpings : Integer) : boolean;

procedure TranslateStringToTInAddr(AIP: string; var AInAddr);

procedure GetIPList(const List: TStrings);


implementation

uses sysutils, NB30, dialogs,forms;

//get the IP from a given URL?

function IAddrToHostName(const IP: string): string;
var
  i: Integer;
  p: PHostEnt;
begin
  Result := '';
  i      := inet_addr(PChar(IP));
  if i <> u_long(INADDR_NONE) then
  begin
    p := GetHostByAddr(@i, SizeOf(Integer), PF_INET);
    if p <> nil then Result := p^.h_name;
  end
  else
    Result := 'Invalid IP address';
end;


//...get a list of computers in a network?
//Example: ScanNetworkResources(RESOURCETYPE_DISK, RESOURCEDISPLAYTYPE_SERVER, ListBox1.Items);

function CreateNetResourceList(ResourceType: DWord;
                              NetResource: PNetResource;
                              out Entries: DWord;
                              out List: PNetResourceArray): Boolean;
var
  EnumHandle: THandle;
  BufSize: DWord;
  Res: DWord;
begin
  Result := False;
  List := Nil;
  Entries := 0;
  if WNetOpenEnum(RESOURCE_GLOBALNET,
                  ResourceType,
                  0,
                  NetResource,
                  EnumHandle) = NO_ERROR then begin
    try
      BufSize := $4000;  // 16 kByte
      GetMem(List, BufSize);
      try
        repeat
          Entries := DWord(-1);
          FillChar(List^, BufSize, 0);
          Res := WNetEnumResource(EnumHandle, Entries, List, BufSize);
          if Res = ERROR_MORE_DATA then
          begin
            ReAllocMem(List, BufSize);
          end;
        until Res <> ERROR_MORE_DATA;

        Result := Res = NO_ERROR;
        if not Result then
        begin
          FreeMem(List);
          List := Nil;
          Entries := 0;
        end;
      except
        FreeMem(List);
        raise;
      end;
    finally
      WNetCloseEnum(EnumHandle);
    end;
  end;
end;

procedure ScanNetworkResources(ResourceType, DisplayType: DWord; List: TStrings);

procedure ScanLevel(NetResource: PNetResource);
var
  Entries: DWord;
  NetResourceList: PNetResourceArray;
  i: Integer;
begin
  if CreateNetResourceList(ResourceType, NetResource, Entries, NetResourceList) then try
    for i := 0 to Integer(Entries) - 1 do
    begin
      if (DisplayType = RESOURCEDISPLAYTYPE_GENERIC) or
        (NetResourceList[i].dwDisplayType = DisplayType) then begin
        List.AddObject(NetResourceList[i].lpRemoteName,
                      Pointer(NetResourceList[i].dwDisplayType));
      end;
      if (NetResourceList[i].dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
        ScanLevel(@NetResourceList[i]);
      application.ProcessMessages;
    end;
  finally
    FreeMem(NetResourceList);
  end;
end;

begin
  ScanLevel(Nil);
end;


function LocalIP: string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of Char;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I := 0;
  while pPtr^[I] <> nil do
  begin
    Result := inet_ntoa(pptr^[I]^);
    Inc(I);
  end;
  WSACleanup;
end;

function IPAddrToName(IPAddr: string): string;
var
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  WSAStartup($101, WSAData);
  SockAddrIn.sin_addr.s_addr := inet_addr(PChar(IPAddr));
  HostEnt := gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
  if HostEnt <> nil then
    Result := StrPas(Hostent^.h_name)
  else
    Result := '';
end;


{**************************************}

// Function to get the IP Address from a Host

function GetIPFromHost(const HostName: string): string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PChar(HostName));
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;
end;


//...map a network drive
//Example ConnectDrive('h:', '\\Servername\C', True, True);

function ConnectDrive(_drvLetter: string; _netPath: string; _showError: Boolean;
  _reconnect: Boolean): DWORD;
var
  nRes: TNetResource;
  errCode: DWORD;
  dwFlags: DWORD;
begin
  { Fill NetRessource with #0 to provide uninitialized values }
  { NetRessource mit #0 füllen => Keine unitialisierte Werte }
  FillChar(NRes, SizeOf(NRes), #0);
  nRes.dwType := RESOURCETYPE_DISK;
  { Set Driveletter and Networkpath }
  { Laufwerkbuchstabe und Netzwerkpfad setzen }
  nRes.lpLocalName  := PChar(_drvLetter);
  nRes.lpRemoteName := PChar(_netPath); { Example: \\Test\C }
  { Check if it should be saved for use after restart and set flags }
  { Überprüfung, ob gespeichert werden soll }
  if _reconnect then
    dwFlags := CONNECT_UPDATE_PROFILE and CONNECT_INTERACTIVE
  else
    dwFlags := CONNECT_INTERACTIVE;

  //errCode := WNetAddConnection3(Form1.Handle, nRes, nil, nil, dwFlags);
  errCode := WNetAddConnection3(0, nRes, nil, nil, dwFlags);
  { Show Errormessage, if flag is set }
  { Fehlernachricht aneigen }
  if (errCode <> NO_ERROR) and (_showError) then
  begin
    showmessage('An error occured while connecting:'+SysErrorMessage(GetLastError));
    {MessageBox(PChar('An error occured while connecting:' + #13#10 +
      SysErrorMessage(GetLastError)),
      'Error while connecting!',
      MB_OK);}
  end;
  Result := errCode; { NO_ERROR }
end;

function ConnectPrinterDevice(_lptPort: string; _netPath: string; _showError: Boolean;
  _reconnect: Boolean): DWORD;
var
  nRes: TNetResource;
  errCode: DWORD;
  dwFlags: DWORD;
begin
  { Fill NetRessource with #0 to provide uninitialized values }
  { NetRessource mit #0 füllen => Keine unitialisierte Werte }
  FillChar(NRes, SizeOf(NRes), #0);
  nRes.dwType := RESOURCETYPE_PRINT;
  { Set Printername and Networkpath }
  { Druckername und Netzwerkpfad setzen }
  nRes.lpLocalName  := PChar(_lptPort);
  nRes.lpRemoteName := PChar(_netPath); { Example: \\Test\Printer1 }
  { Check if it should be saved for use after restart and set flags }
  { Überprüfung, ob gespeichert werden soll }
  if _reconnect then
    dwFlags := CONNECT_UPDATE_PROFILE and CONNECT_INTERACTIVE
  else
    dwFlags := CONNECT_INTERACTIVE;

  //errCode := WNetAddConnection3(Form1.Handle, nRes, nil, nil, dwFlags);
  errCode := WNetAddConnection3(0, nRes, nil, nil, dwFlags);
  { Show Errormessage, if flag is set }
  { Fehlernachricht aneigen }
  if (errCode <> NO_ERROR) and (_showError) then
  begin
    showmessage('An error occured while connecting: '+SysErrorMessage(GetLastError));
    {Application.MessageBox(PChar('An error occured while connecting:' + #13#10 +
      SysErrorMessage(GetLastError)),
      'Error while connecting!',
      MB_OK);}
  end;
  Result := errCode; { NO_ERROR }
end;

//unmap network drive
//Example DisconnectNetDrive('h:', True, True, True);

function DisconnectNetDrive(_locDrive: string; _showError: Boolean; _force: Boolean;
  _save: Boolean): DWORD;
var
  dwFlags: DWORD;
  errCode: DWORD;
begin
  { Set dwFlags, if necessary }
  { Setze dwFlags auf gewünschten Wert }
  if _save then
    dwFlags := CONNECT_UPDATE_PROFILE
  else
    dwFlags := 0;
  { Cancel the connection see also at http://www.swissdelphicenter.ch/en/showcode.php?id=391 }
  { Siehe auch oben genannten Link (Netzlaufwerke anzeigen) }
  errCode := WNetCancelConnection2(PChar(_locDrive), dwFlags, _force);
  { Show Errormessage, if flag is set }
  { Fehlernachricht anzeigen }
  if (errCode <> NO_ERROR) and (_showError) then 
  begin
    showmessage('An error occured while disconnecting: '+SysErrorMessage(GetLastError));
    {Application.MessageBox(PChar('An error occured while disconnecting:' + #13#10 +
      SysErrorMessage(GetLastError)),
      'Error while disconnecting',
      MB_OK);}
  end;
  Result := errCode; { NO_ERROR }
end;

function GetMACAdress: string;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;

  URetCode: PChar;
  RetCode: char;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
  TMPSTR: string;
begin
  Result    := '';
  _SystemID := '';
  Getmem(NCB, SizeOf(TNCB));
  Fillchar(NCB^, SizeOf(TNCB), 0);

  Getmem(Lenum, SizeOf(TLanaEnum));
  Fillchar(Lenum^, SizeOf(TLanaEnum), 0);

  Getmem(Adapter, SizeOf(TAdapterStatus));
  Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);

  Lenum.Length    := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(Lenum);
  NCB.ncb_length  := SizeOf(Lenum);
  RetCode         := Netbios(NCB);

  i := 0;
  repeat
    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBRESET);
    Ncb.ncb_lana_num := lenum.lana[I];
    RetCode          := Netbios(Ncb);

    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBASTAT);
    Ncb.ncb_lana_num := lenum.lana[I];
    // Must be 16
    Ncb.ncb_callname := '*               ';

    Ncb.ncb_buffer := Pointer(Adapter);

    Ncb.ncb_length := SizeOf(TAdapterStatus);
    RetCode        := Netbios(Ncb);
    //---- calc _systemId from mac-address[2-5] XOR mac-address[1]...
    if (RetCode = chr(0)) or (RetCode = chr(6)) then
    begin
      _SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[1]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[2]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[3]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[4]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[5]), 2);
    end;
    Inc(i);
  until (I >= Ord(Lenum.Length)) or (_SystemID <> '00-00-00-00-00-00');
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
  GetMacAdress := _SystemID;
end;

function NetSend(dest, Source, Msg: string): Longint; overload;
type
  TNetMessageBufferSendFunction = function(servername, msgname, fromname: PWideChar;
    buf: PWideChar; buflen: Cardinal): Longint; 
  stdcall;
var
  NetMessageBufferSend: TNetMessageBufferSendFunction;
  SourceWideChar: PWideChar;
  DestWideChar: PWideChar;
  MessagetextWideChar: PWideChar;
  Handle: THandle;
begin
  Handle := LoadLibrary('NETAPI32.DLL');
  if Handle = 0 then
  begin
    Result := GetLastError;
    Exit;
  end;
    @NetMessageBufferSend := GetProcAddress(Handle, 'NetMessageBufferSend');
  if @NetMessageBufferSend = nil then
  begin
    Result := GetLastError;
    Exit;
  end;

  MessagetextWideChar := nil;
  SourceWideChar      := nil;
  DestWideChar        := nil;

  try
    GetMem(MessagetextWideChar, Length(Msg) * SizeOf(WideChar) + 1);
    GetMem(DestWideChar, 20 * SizeOf(WideChar) + 1);
    StringToWideChar(Msg, MessagetextWideChar, Length(Msg) * SizeOf(WideChar) + 1);
    StringToWideChar(Dest, DestWideChar, 20 * SizeOf(WideChar) + 1);

    if Source = '' then
      Result := NetMessageBufferSend(nil, DestWideChar, nil,
        MessagetextWideChar, Length(Msg) * SizeOf(WideChar) + 1)
    else
    begin
      GetMem(SourceWideChar, 20 * SizeOf(WideChar) + 1);
      StringToWideChar(Source, SourceWideChar, 20 * SizeOf(WideChar) + 1);
      Result := NetMessageBufferSend(nil, DestWideChar, SourceWideChar,
        MessagetextWideChar, Length(Msg) * SizeOf(WideChar) + 1);
      FreeMem(SourceWideChar);
    end;
  finally
    FreeMem(MessagetextWideChar);
    FreeLibrary(Handle);
  end;
end;

function NetSend(Dest, Msg: string): Longint; overload;
begin
  Result := NetSend(Dest, '', Msg);
end;

function NetSend(Msg: string): Longint; overload;
begin
  Result := NetSend('', '', Msg);
end;


const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
var
  hdlg: DWORD = 0;

procedure shut(system, nachricht: string; force, reboot: Boolean; countdown: Integer);
var
  otoken, hToken: THandle;
  tp: TTokenPrivileges;
  h: DWORD;
begin
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, hToken);
  otoken := htoken;
  LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME, tp.Privileges[0].luid);
  tp.privilegecount := 1;
  tp.privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  h := 0;
  AdjustTokenPrivileges(hToken, False, tp, 0, PTokenPrivileges(nil)^, h);
  InitiateSystemShutdown(PChar(system), PChar(nachricht), countdown, force, reboot);
  tp.privilegecount := 1;
  tp.privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  h := 0;
  AdjustTokenPrivileges(oToken, False, tp, 0, PTokenPrivileges(nil)^, h);
  CloseHandle(hToken);
end;

procedure abortshut(system: string);
var
  hToken: THandle;
  tp: TTokenPrivileges;
  h: DWORD;
begin
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, hToken);
  LookupPrivilegeValue(PChar(system), SE_SHUTDOWN_NAME, tp.Privileges[0].luid);
  tp.privilegecount := 1;
  tp.privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  h := 0;
  AdjustTokenPrivileges(hToken, False, tp, 0, PTokenPrivileges(nil)^, h);
  CloseHandle(hToken);
  abortSystemShutdown(PChar(system));
end;

function Fetch(var AInput: string; const ADelim: string = ' '; const ADelete: Boolean = true)
 : string;
var
  iPos: Integer;
begin
  if ADelim = #0 then begin
    // AnsiPos does not work with #0
    iPos := Pos(ADelim, AInput);
  end else begin
    iPos := Pos(ADelim, AInput);
  end;
  if iPos = 0 then begin
    Result := AInput;
    if ADelete then begin
      AInput := '';
    end;
  end else begin
    result := Copy(AInput, 1, iPos - 1);
    if ADelete then begin
      Delete(AInput, 1, iPos + Length(ADelim) - 1);
    end;
  end;
end;

procedure TranslateStringToTInAddr(AIP: string; var AInAddr);
var
  phe: PHostEnt;
  pac: PChar;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  try
    phe := GetHostByName(PChar(AIP));
    if Assigned(phe) then
    begin
      pac := phe^.h_addr_list^;
      if Assigned(pac) then
      begin
        with TIPAddr(AInAddr).S_un_b do begin
          s_b1 := Byte(pac[0]);
          s_b2 := Byte(pac[1]);
          s_b3 := Byte(pac[2]);
          s_b4 := Byte(pac[3]);
        end;
      end
      else
      begin
        raise Exception.Create('Error getting IP from HostName');
      end;
    end
    else
    begin
      raise Exception.Create('Error getting HostName');
    end;
  except
    FillChar(AInAddr, SizeOf(AInAddr), #0);
  end;
  WSACleanup;
end;


function IcmpCreateFile : THandle; stdcall; external 'icmp.dll';
function IcmpCloseHandle (icmpHandle : THandle) : boolean; stdcall; external 'icmp.dll'
function IcmpSendEcho (IcmpHandle : THandle; DestinationAddress : IPAddr;
    RequestData : Pointer; RequestSize : Smallint;
    RequestOptions : pointer;
    ReplyBuffer : Pointer;
    ReplySize : DWORD;
    Timeout : DWORD) : DWORD; stdcall; external 'icmp.dll';

function Ping(InetAddress : string) : boolean;
var
 Handle : THandle;
 InAddr : IPAddr;
 DW : DWORD;
 rep : array[1..128] of byte;
begin
  result := false;
  Handle := IcmpCreateFile;
  if Handle = INVALID_HANDLE_VALUE then
   Exit;
  TranslateStringToTInAddr(InetAddress, InAddr);
  DW := IcmpSendEcho(Handle, InAddr, nil, 0, nil, @rep, 128, 0);
  Result := (DW <> 0);
  IcmpCloseHandle(Handle);
end;


function Ping2(InetAddress : string; numpings : Integer) : boolean;
var
  i : integer;
begin
  result := false;
  for i := 1 to numpings do
  begin
    Application.ProcessMessages;
    if Ping(InetAddress) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;


// Se obtiene la ip local y la pública en una lista de cadenas
procedure GetIPList(const List: TStrings);
var
  WSAData: TWSAData;
  HostName: array[0..255] of Char;
  HostInfo: PHostEnt;
  InAddr: ^PInAddr;
begin
  List.Clear;
  if WSAStartup($0101, WSAData) = 0 then
  try
    if gethostname(HostName, SizeOf(HostName)) = 0 then
    begin
      HostInfo := gethostbyname(HostName);
      if HostInfo <> nil then
      begin
        InAddr := Pointer(HostInfo^.h_addr_list);
        if (InAddr <> nil) then
          while InAddr^ <> nil do
          begin
            List.Add(inet_ntoa(InAddr^^));
            Inc(InAddr);
          end;
      end;
    end;
  finally
    WSACleanup;
  end;
end;

end.
