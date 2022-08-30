   {*
 * Librer&iacute;a que contiene funciones de utilidad para el SIO2000
 * Autor: Arturo Beristain L&oacute;pez
}

unit MiscUtils;

interface

uses classes,zlib,Oracle,OracleData,graphics, windows, RegExpr, registry;

type
  tTipoDatos = (tNumero, tFecha, tCadena);

const
  {* M&aacute;xima cantidad de caracteres }
  cnMaxVarValueSize = 250;
  {* Arreglo de nombres de los meses}
  mes:array[1..12] of string=('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');


  WIN1252_UNICODE : ARRAY [$00..$FF] OF WORD = (
                    $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009,
                    $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0011, $0012, $0013,
                    $0014, $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D,
                    $001E, $001F, $0020, $0021, $0022, $0023, $0024, $0025, $0026, $0027,
                    $0028, $0029, $002A, $002B, $002C, $002D, $002E, $002F, $0030, $0031,
                    $0032, $0033, $0034, $0035, $0036, $0037, $0038, $0039, $003A, $003B,
                    $003C, $003D, $003E, $003F, $0040, $0041, $0042, $0043, $0044, $0045,
                    $0046, $0047, $0048, $0049, $004A, $004B, $004C, $004D, $004E, $004F,
                    $0050, $0051, $0052, $0053, $0054, $0055, $0056, $0057, $0058, $0059,
                    $005A, $005B, $005C, $005D, $005E, $005F, $0060, $0061, $0062, $0063,
                    $0064, $0065, $0066, $0067, $0068, $0069, $006A, $006B, $006C, $006D,
                    $006E, $006F, $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077,
                    $0078, $0079, $007A, $007B, $007C, $007D, $007E, $007F,

                    $20AC, $0081, $201A, $0192, $201E, $2026, $2020, $2021, $02C6, $2030,
                    $0160, $2039, $0152, $008D, $017D, $008F, $0090, $2018, $2019, $201C,
                    $201D, $2022, $2013, $2014, $02DC, $2122, $0161, $203A, $0153, $009D,
                    $017E, $0178, $00A0, $00A1, $00A2, $00A3, $00A4, $00A5, $00A6, $00A7,
                    $00A8, $00A9, $00AA, $00AB, $00AC, $00AD, $00AE, $00AF, $00B0, $00B1,
                    $00B2, $00B3, $00B4, $00B5, $00B6, $00B7, $00B8, $00B9, $00BA, $00BB,
                    $00BC, $00BD, $00BE, $00BF, $00C0, $00C1, $00C2, $00C3, $00C4, $00C5,
                    $00C6, $00C7, $00C8, $00C9, $00CA, $00CB, $00CC, $00CD, $00CE, $00CF,
                    $00D0, $00D1, $00D2, $00D3, $00D4, $00D5, $00D6, $00D7, $00D8, $00D9,
                    $00DA, $00DB, $00DC, $00DD, $00DE, $00DF, $00E0, $00E1, $00E2, $00E3,
                    $00E4, $00E5, $00E6, $00E7, $00E8, $00E9, $00EA, $00EB, $00EC, $00ED,
                    $00EE, $00EF, $00F0, $00F1, $00F2, $00F3, $00F4, $00F5, $00F6, $00F7,
                    $00F8, $00F9, $00FA, $00FB, $00FC, $00FD, $00FE, $00FF);

procedure DoEnterAsTab(var Msg: TMsg; var Handled: Boolean);
procedure ListImgDir(Path:String; stl:tstrings);     //obtiene la lista de imagenes de un directorio
procedure ListArchDir(Path:String; stl:tstrings);     //obtiene la lista de imagenes de un directorio
procedure ListFiles(Path:String; mask: string; stl:tstrings);     //obtiene la lista de Archivos de un directorio
procedure GetSubDirs(const sRootDir: string; slt: TStrings);    //Obtiene los subdirectorios en un directorio
function token(var cad:string;sep:string):string;               //Obtiene un token de la cadena de entrada separado por un caracter o cadena
function StrIdx(str:string;StrArr:array of string):integer;             //obtiene el índice de una cadena en una lista de cadenas equivalente a position := AnsiIndexStr(source, ['BRIAN', 'JIM', 'HENRY']);
procedure DecompressFiles(const Filename, DestDirectory : String);
procedure CompressFiles(Files : TStrings; const Filename : String);
procedure CompressStream(inpStream, outStream: TStream);
procedure DecompressStream(inpStream, outStream: TStream);
Function existeSQL(sesion:TOracleSession;csql:string):boolean; overload;
Function existeSQL(sesion:TOracleSession;csql:string; params: array of variant):boolean; overload;
Function ejecutaSQL(sesion:TOracleSession;csql:string):boolean; overload;
function ejecutaSQL(session: TOracleSession; cSQL : string; Params : array of Variant): boolean; overload;
Function ejecutaSQLnocommit(sesion:TOracleSession;csql:string):boolean; overload;
Function ejecutaSQLnocommit(sesion:TOracleSession;csql:string; params: array of variant):boolean; overload;
function CampoSQL(sesion:TOracleSession;csql,campo:string):variant;
Function ValorSQL(sesion:TOracleSession;csql:string):variant; overload;
Function ValorSQL(sesion:TOracleSession;csql:string; params : array of variant):variant; overload;
function resultSQL(sesion:TOracleSession;csql:string):TOracleDataset; overload;
function resultSQL(sesion:TOracleSession;csql:string;params : array of variant):TOracleDataset; overload;
function formateaExp(expr:string):string;
function isfloat(expr:string):boolean;
function FileCopy(source,dest: String): Boolean;
Procedure transli(min,max,mip,map:real;var a,b:real);
procedure ListDir(Path: String; mask:string; List: TStrings);
Function Get_Environment_Data(Var EnvironmentStringList: TStrings): Word;
function GetEnvVar(const csVarName : string ) : string;
procedure swap(var v1,v2:single);
function CtrlDown : Boolean;
function ShiftDown : Boolean;
function AltDown : Boolean;
function MouseLeft  : Boolean;
function MouseRight : Boolean;
function GetSpecialFolder(FolderID : longint) : string;
function GetMyDocDir: string;
function tempdir:string;
procedure crearcsv(archivo:string;columnas:array of string);
function DelTree(const Directory: string):boolean;
Function DelTree2(DirName : string): Boolean;
procedure RunOnStartup(sProgTitle, sCmdLine: string; bStartup: boolean );
function TColorToHex(Color : TColor) : string;
function HexToTColor(sColor : string) : TColor;
function var2int(v:variant):integer;
function var2str(v:variant):string;
function var2single(v:variant):single;
function var2double(v:variant):single;
function var2datetime(v:variant):TDateTime;
function SQLint(sesion:TOracleSession;csql:string):integer; overload;
function SQLstr(sesion:TOracleSession;csql:string):string;  overload;
function SQLSingle(sesion:TOracleSession;csql:string):single; overload;
function SQLDateTime(sesion:TOracleSession;csql:string):TDateTime; overload;
function SQLint(sesion:TOracleSession;csql:string; params : array of variant):integer; overload;
function SQLstr(sesion:TOracleSession;csql:string; params : array of variant):string; overload;
function SQLSingle(sesion:TOracleSession;csql:string; params : array of variant):single; overload;
function SQLDouble(sesion:TOracleSession;csql:string; params : array of variant):double; overload;
function SQLDateTime(sesion:TOracleSession;csql:string; params : array of variant):TDateTime; overload;
procedure SetJPGCompression(ACompression : integer; const AInFile : string;
                            const AOutFile : string);
function  DSiGetFileTimes(const fileName: string; var creationTime, lastAccessTime,
  lastModificationTime: TDateTime): boolean;

procedure Split(const Delimiter: Char;Input: string;const Strings: TStrings) ;
procedure RegisterFileType(ExtName:String; AppName:String);
function GetFocusedControlRect: TRect;
function FileVersion(const FileName: String = ''; const Fmt: String = '%d.%d.%d.%d'): String;
function lpad(n, digitos:Integer):string;
FUNCTION  AnsiToUtf8 (Source : ANSISTRING) : STRING;
FUNCTION  Utf8ToAnsi (Source : STRING; UnknownChar : CHAR = '?') : ANSISTRING;
function PadWithZeros(const Value: String; PadLength: Integer): String;
function GetFileTimes(FileName : string; var Created : TDateTime;
    var Modified : TDateTime; var Accessed : TDateTime) : boolean;    //Obtiene fechas de creación, modificación y acceso del archivo
function fechaCrea(arch:string):tdatetime;
function fechaModif(arch:string):tdatetime;
function fechaModif2(arch:string):tdatetime;
function fechaAcceso(arch:string):tdatetime;

function FindFiles(const Path, Mask: string; IncludeSubDir: boolean; list: tstrings): integer;
function fileowner(filename : string) : string;
function ObtainFileSize(const AFile: String): Int64;
procedure getvars(cSQL : string; var s : TStringList);
procedure DeclareAndSetVars(ds : TOracleDataSet; params : array of variant);
procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
procedure Jpeg2Bmp(const BmpFileName, JpgFileName: string);
function GetFileOwner(FileName: string; var Domain, Username: string): Boolean;
procedure saveUTF8(archivo: string; data : string);
function VarToString(Value: Variant): String;
function tipodatos(cad : string) : tTipoDatos;

implementation

uses sysutils,extdlgs,dialogs,buttons,ShlObj, ComObj, variants, jpeg, ShellAPI,messages,forms;

{*
 * Funci&oacute;n usada para mostrar las im&aacute;genes de las obras
 * @param Path Ruta de b&uacute;squeda para las im&aacute;genes
 * @param stl  Almacena la lista de archivos encontrados
}

procedure ListImgDir(Path:String; stl:tstrings);

var
  {* Registro de informaci&oacute;n de b&uacute;squeda }
  SearchRec:TsearchRec;
  Result:integer;
  S:string; { Used to hold current directory, GetDir(0,s) }

  function IsValidDir(SearchRec:TSearchRec):Boolean;
  begin
    //un atributo fadirectory(16) es el default pero un directorio puede tener otros valores
    Result:=SearchRec.attr in [16,17,18,22,48,49];
    //Result:=SearchRec.attr in [16,48];
  end;

begin
  try {Exception handler }
    ChDir(Path);
  except on EInOutError do
    begin
      MessageDlg('Error occurred by trying to change directory',mtWarning,[mbOK],0);
      Exit;
    end;
  end;
  if length(path)<> 3 then path:=path+'\';   { Checking if path is root, if not add }
  FindFirst(path+'*.*',faAnyFile,SearchRec); { '\' at the end of the string         }
                                            { and then add '*.*' for all file     }
  Repeat
    if Pos('JULIO 20082',SearchRec.Name)>0 then
    begin
      Path:=path+'';
    end;
    if IsValidDir(SearchRec) then   { if directory then }
    begin
      if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then { Ignore '.' and '..' }
      begin
        GetDir(0,s); { Get current dir of default drive }
        if length(s)<>3 then s:=s+'\'; { Checking if root }
        ListImgDir(s+SearchRec.Name,stl); { ListDir found directory }
      end;
    end
    else { if not directory }
    begin
      GetDir(0,s); { Get current dir of default drive }
      if pos(lowercase(extractfileext(SearchRec.Name)),'.bmp.jpg.jpeg.psd.png')>0 then
      begin
        if length(s)<>3 then stl.add(s+'\'+SearchRec.Name) { Checking if root }
          else stl.add(s+SearchRec.Name); { Adding to list }
      end;
    end;
    Result:=FindNext(SearchRec);
  until result<>0; { Found all files, go out }
  GetDir(0,s);
  sysutils.FindClose(SearchRec);
  if length(s)<>3 then ChDir('..'); { if not root then go back one level }
end;

procedure ListArchDir(Path:String; stl:tstrings);

var
  {* Registro de informaci&oacute;n de b&uacute;squeda }
  SearchRec:TsearchRec;
  Result:integer;
  S:string; { Used to hold current directory, GetDir(0,s) }

  function IsValidDir(SearchRec:TSearchRec):Boolean;
  begin
    //un atributo fadirectory(16) es el default pero un directorio puede tener otros valores
    Result:=SearchRec.attr in [16,17,18,22,48,49];
    //Result:=SearchRec.attr in [16,48];
  end;

begin
  try {Exception handler }
    ChDir(Path);
  except on EInOutError do
    begin
      MessageDlg('Error occurred by trying to change directory',mtWarning,[mbOK],0);
      Exit;
    end;
  end;
  if length(path)<> 3 then path:=path+'\';   { Checking if path is root, if not add }
  FindFirst(path+'*.*',faAnyFile,SearchRec); { '\' at the end of the string         }
                                            { and then add '*.*' for all file     }
  Repeat
    if Pos('JULIO 20082',SearchRec.Name)>0 then
    begin
      Path:=path+'';
    end;
    if IsValidDir(SearchRec) then   { if directory then }
    begin
      if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then { Ignore '.' and '..' }
      begin
        GetDir(0,s); { Get current dir of default drive }
        if length(s)<>3 then s:=s+'\'; { Checking if root }
        ListImgDir(s+SearchRec.Name,stl); { ListDir found directory }
      end;
    end
    else { if not directory }
    begin
      GetDir(0,s); { Get current dir of default drive }
      if pos(lowercase(extractfileext(SearchRec.Name)),'.bmp.jpg.jpeg.psd.png.pdf.dwg.xlsx.xls.docx.doc.jpg')>0 then
      begin
        if length(s)<>3 then stl.add(s+'\'+SearchRec.Name) { Checking if root }
          else stl.add(s+SearchRec.Name); { Adding to list }
      end;
    end;
    Result:=FindNext(SearchRec);
  until result<>0; { Found all files, go out }
  GetDir(0,s);
  sysutils.FindClose(SearchRec);
  if length(s)<>3 then ChDir('..'); { if not root then go back one level }
end;

procedure ListFiles(Path:String; mask: string; stl:tstrings);

var
  {* Registro de informaci&oacute;n de b&uacute;squeda }
  SearchRec:TsearchRec;
  Result:integer;
  S, ext:string; { Used to hold current directory, GetDir(0,s) }

  function IsValidDir(SearchRec:TSearchRec):Boolean;
  begin
    //un atributo fadirectory(16) es el default pero un directorio puede tener otros valores
    Result:=SearchRec.attr in [16,17,18,22,48,49];
    //Result:=SearchRec.attr in [16,48];
  end;

begin
  try {Exception handler }
    ChDir(Path);
  except on EInOutError do
    begin
      MessageDlg('Error occurred by trying to change directory',mtWarning,[mbOK],0);
      Exit;
    end;
  end;
  if length(path)<> 3 then path:=path+'\';   { Checking if path is root, if not add }
  FindFirst(path+'*.*',faAnyFile,SearchRec); { '\' at the end of the string         }
                                            { and then add '*.*' for all file     }
  Repeat
    if Pos('JULIO 20082',SearchRec.Name)>0 then
    begin
      Path:=path+'';
    end;
    if IsValidDir(SearchRec) then   { if directory then }
    begin
      if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then { Ignore '.' and '..' }
      begin
        GetDir(0,s); { Get current dir of default drive }
        if length(s)<>3 then s:=s+'\'; { Checking if root }
        ListImgDir(s+SearchRec.Name,stl); { ListDir found directory }
      end;
    end
    else { if not directory }
    begin
      GetDir(0,s); { Get current dir of default drive }
      if pos(lowercase(extractfileext(SearchRec.Name)),mask)>0 then
      begin
//        ext := extractfileext(searchrec.Name);
//        if ext <> searchrec.Name then
          stl.Add(searchrec.Name);
//        if length(s)<>3 then stl.add(s+'\'+SearchRec.Name) { Checking if root }
//          else stl.add(s+SearchRec.Name); { Adding to list }
      end;
    end;
    Result:=FindNext(SearchRec);
  until result<>0; { Found all files, go out }
  GetDir(0,s);
  sysutils.FindClose(SearchRec);
  if length(s)<>3 then ChDir('..'); { if not root then go back one level }
end;

procedure DoEnterAsTab(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.Message = WM_KEYDOWN then
  begin
    if Msg.wParam = VK_RETURN then
      Keybd_event(VK_TAB, 0, 0, 0);
  end; //if
end;

procedure GetSubDirs(const sRootDir: string; slt: TStrings);
var
  srSearch: TSearchRec;
  sSearchPath: string;
  sltSub: TStrings;
  i: Integer;
begin
  sltSub := TStringList.Create;
  slt.BeginUpdate;
  try
    sSearchPath := sRootDir+'\';
    if FindFirst(sSearchPath + '*', faDirectory, srSearch) = 0 then
      repeat
        if ((srSearch.Attr and faDirectory) = faDirectory) and
          (srSearch.Name <> '.') and
          (srSearch.Name <> '..') then
        begin
          slt.Add(srSearch.Name);
          sltSub.Add(sSearchPath + srSearch.Name);
        end;
      until (FindNext(srSearch) <> 0);

    sysutils.FindClose(srSearch);

    for i := 0 to sltSub.Count - 1 do
      GetSubDirs(sltSub.Strings[i], slt);
  finally
    slt.EndUpdate;
    FreeAndNil(sltSub);
  end;
end;

function token(var cad:string;sep:string):string;
var p,n:integer;
begin
   p:=pos(sep,cad);
   if p>0 then
      n:=p-1
   else
      n:=length(cad);
   result:=copy(cad,1,n);
   delete(cad,1,n+length(sep));
end;

function StrIdx(str:string;StrArr:array of string):integer;
var n,i:integer;
begin
   result:=-1;
   n:=high(strarr);
   if length(str)<1 then exit;
   for i:=0 to n do
      if StrArr[i]=str then
      begin
         result:=i;
         exit;
      end;
end;




procedure CompressFiles(Files : TStrings; const Filename : String);
var
  infile, outfile, tmpFile : TFileStream;
  compr : TCompressionStream;
  i,l : Integer;
  s : String;

begin
  if Files.Count > 0 then
  begin
    outFile := TFileStream.Create(Filename,fmCreate);
    try
      { the number of files }
      l := Files.Count;
      outfile.Write(l,SizeOf(l));
      for i := 0 to Files.Count-1 do
      begin
        infile := TFileStream.Create(Files[i],fmOpenRead);
        try
          { the original filename }
          s := ExtractFilename(Files[i]);
          l := Length(s);
          outfile.Write(l,SizeOf(l));
          outfile.Write(s[1],l);
          { the original filesize }
          l := infile.Size;
          outfile.Write(l,SizeOf(l));
          { compress and store the file temporary}
          tmpFile := TFileStream.Create('tmp',fmCreate);
          compr := TCompressionStream.Create(clMax,tmpfile);
          try
            compr.CopyFrom(infile,l);
          finally
            compr.Free;
            tmpFile.Free;
          end;
          { append the compressed file to the destination file }
          tmpFile := TFileStream.Create('tmp',fmOpenRead);
          try
            outfile.CopyFrom(tmpFile,0);
          finally
            tmpFile.Free;
          end;
        finally
          infile.Free;
        end;
      end;
    finally
      outfile.Free;
    end;
    DeleteFile('tmp');
  end;
end;

procedure DecompressFiles(const Filename, DestDirectory : String);
var
  dest,s : String;
  decompr : TDecompressionStream;
  infile, outfile : TFilestream;
  i,l,c : Integer;
begin
  // IncludeTrailingPathDelimiter (D6/D7 only)
  dest := IncludeTrailingPathDelimiter(DestDirectory);

  infile := TFileStream.Create(Filename,fmOpenRead);
  try
    { number of files }
    infile.Read(c,SizeOf(c));
    for i := 1 to c do
    begin
      { read filename }
      infile.Read(l,SizeOf(l));
      SetLength(s,l);
      infile.Read(s[1],l);
      { read filesize }
      infile.Read(l,SizeOf(l));
      { decompress the files and store it }
      s := dest+s; //include the path
      outfile := TFileStream.Create(s,fmCreate);
      decompr := TDecompressionStream.Create(infile);
      try
        outfile.CopyFrom(decompr,l);
      finally
        outfile.Free;
        decompr.Free;
      end;
    end;
  finally
    infile.Free;
  end;
end;

procedure CompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  InpBytes, OutBytes: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  try
    GetMem(InpBuf, inpStream.Size);
    inpStream.Position := 0;
    InpBytes := inpStream.Read(InpBuf^, inpStream.Size);
    CompressBuf(InpBuf, InpBytes, OutBuf, OutBytes);
    outStream.Write(OutBuf^, OutBytes);
  finally
    if InpBuf <> nil then FreeMem(InpBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
end;


{ Decompress a stream }
procedure DecompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  OutBytes, sz: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  sz     := inpStream.Size - inpStream.Position;
  if sz > 0 then
    try
      GetMem(InpBuf, sz);
      inpStream.Read(InpBuf^, sz);
      DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes);
      outStream.Write(OutBuf^, OutBytes);
    finally
      if InpBuf <> nil then FreeMem(InpBuf);
      if OutBuf <> nil then FreeMem(OutBuf);
    end;
  outStream.Position := 0;
end;


Function existeSQL(sesion:TOracleSession;csql:string):boolean;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(nil);
  
  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    try
      Open;
      result:=recordcount>0;
    finally
      q.Close;
      q.Free;
    end;
  end;
end;

Function existeSQL(sesion:TOracleSession;csql:string; params: array of variant):boolean;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(nil);

  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    declareandsetvars(q,Params);
    try
      Open;
      result:=recordcount>0;
    finally
      q.Close;
      q.Free;
    end;
  end;
end;

Function ejecutaSQL(sesion:TOracleSession;csql:string):boolean;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(sesion);
  q.OracleDictionary.UseMessageTable := true;
  with q do begin
    Session:=sesion;
    SQL.text:=csql;
    try
      ExecSQL;
      sesion.Commit;
      result:=true;
    finally
      q.Close;
      q.Free;
    end;
  end;
end;

function ejecutaSQL(session: TOracleSession; cSQL : string; Params : array of Variant): boolean;
var
  q : TOracleDataset;
begin
  q := TOracleDataset.Create(nil);
  q.Session := session;

  with q do
  begin
    SQL.Text := cSQL;
    declareandsetvars(q,Params);
    try
      ExecSQL;
      session.Commit;
      Result := True;
    finally
      q.Close;
      q.Free;
    end;
  end;

end;

Function ejecutaSQLnocommit(sesion:TOracleSession;csql:string):boolean;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(sesion);
  with q do begin
    Session:=sesion;
    SQL.text:=csql;
    try
      ExecSQL;
      result:=true;
    finally
      q.Close;
      q.Free;
    end;
  end;
end;

Function ejecutaSQLnocommit(sesion:TOracleSession;csql:string; params : array of variant):boolean;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(sesion);
  with q do begin
    Session:=sesion;
    SQL.text:=csql;
    declareandsetvars(q,Params);
    try
      ExecSQL;
      result:=true;
    finally
      q.Close;
      q.Free;
    end;
  end;
end;


function CampoSQL(sesion:TOracleSession;csql,campo:string):variant;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(nil);
  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    try
      Open;
      result:=q.fieldbyname(campo).Value;
    finally
      q.close;
      q.Free;
    end;
  end;
end;

Function ValorSQL(sesion:TOracleSession;csql:string):variant;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(nil);
  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    try
      Open;
      result:=q.Fields[0].Value;
    finally
      q.close;
      q.Free;
    end;
  end;
end;

Function ValorSQL(sesion:TOracleSession;csql:string; params : array of variant):variant;
var
  q:TOracleDataset;
begin
  q:=TOracleDataset.Create(nil);

  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    DeclareAndSetVars(q, params);
    
    try
      Open;
      result:=q.Fields[0].Value;
    finally
      q.close;
      q.Free;
    end;
  end;
end;

function resultSQL(sesion:TOracleSession;csql:string):TOracleDataset;
var q:TOracleDataset;
begin
  q:=TOracleDataset.Create(sesion);
  q.RefreshOptions := [roAfterInsert, roAfterUpdate, roAllFields];
  q.CommitOnPost := true;
  with q do
  begin
    Session:=sesion;
    q.SQL.text:=csql;
    q.Open;
    result:=q;
  end;
end;

function resultSQL(sesion:TOracleSession;csql:string;params : array of variant):TOracleDataset;
var
  d : TOracleDataSet;
begin
  d:=TOracleDataset.Create(sesion);
  d.RefreshOptions := [roAfterInsert, roAfterUpdate, roAllFields];
  d.CommitOnPost := true;
  with d do
  begin
    Session := sesion;
    d.SQL.Text := csql;
    DeclareAndSetVars(d, params);
    d.Open;
    result := d;
  end;
end;


function formateaExp(expr:string):string;
var n,e:string;
    i:integer;

begin
  e:='';
  i:=1;
  repeat
    if not (expr[i] in ['-','+','/','*','(',')']) then
      e:=e+expr[i]
    else
    begin
      if isfloat(e) then
      begin
        delete(expr,i-length(e),length(e));
        n:=format('%0.2f',[strtofloat(e)]);
        insert(n,expr,i-length(e));
        i:=i-length(e)+length(n);
      end;
      e:='';
    end;
    inc(i);
  until i>length(expr);
  if isfloat(e) then
  begin
    delete(expr,i-length(e),length(e));
    n:=format('%0.2f',[strtofloat(e)]);
    insert(n,expr,i-length(e));
    //i:=i-length(e)+length(n);
  end;
  result:=expr;
end;

function isfloat(expr:string):boolean;
begin
  try
    strtofloat(expr);
    result:=true;
  except
    result:=falsE;
  end;
end;



function FileCopy(source,dest: String): Boolean;
var
  fSrc,fDst,len: Integer;
  size: Longint;
  buffer: packed array [0..2047] of Byte;
begin
  Result := False; { Assume that it WONT work }
  if source <> dest then begin
    fSrc := FileOpen(source,fmOpenRead);
    if fSrc >= 0 then begin
      size := FileSeek(fSrc,0,2);
      FileSeek(fSrc,0,0);
      fDst := FileCreate(dest);
      if fDst >= 0 then begin
        while size > 0 do begin
          len := FileRead(fSrc,buffer,sizeof(buffer));
          FileWrite(fDst,buffer,len);
          size := size - len;
        end;
        FileSetDate(fDst,FileGetDate(fSrc));
        FileClose(fDst);
        FileSetAttr(dest,FileGetAttr(source));
        Result := True;
      end;
      FileClose(fSrc);
    end;
  end;
end;

Procedure transli(min,max,mip,map:real;var a,b:real);
begin
  a:=(mip-map)/(min-max);
  b:=(min*map-mip*max)/(min-max);
end;


procedure ListDir(Path: String; mask:string; List: TStrings);
var
  SearchRec:TsearchRec;
  Result:integer;
  S:string;
begin
  try {Exception handler }
    ChDir(Path);
  except on EInOutError do
    begin
      MessageDlg('Error occurred by trying to change directory',mtWarning,[mbOK],0);
      Exit;
    end;
  end;
  if length(path)<> 3 then path:=path+'\';   { Checking if path is root, if not add }
  FindFirst(path+mask,faAnyFile,SearchRec); { '\' at the end of the string         }
                                            { and then add '*.*' for all file     }
  Repeat
    if SearchRec.Attr=faDirectory then   { if directory then }
    begin
      if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then { Ignore '.' and '..' }
      begin
        GetDir(0,s); { Get current dir of default drive }
        if length(s)<>3 then s:=s+'\'; { Checking if root }

        List.Add(s+SearchRec.Name); { Adding to list }
        ListDir(s+SearchRec.Name,mask,List); { ListDir found directory }
      end;
    end
    else { if not directory }
    begin
      GetDir(0,s); { Get current dir of default drive }
      if length(s)<>3
      then List.add(s+'\'+SearchRec.Name) { Checking if root }
      else List.add(s+SearchRec.Name); { Adding to list }
    end;
    Result:=FindNext(SearchRec);
  until result<>0; { Found all files, go out }
  GetDir(0,s);
  sysutils.findclose(searchRec);
  if length(s)<>3 then ChDir('..'); { if not root then go back one level }
end;

function GetEnvVar(
  const csVarName : string ) : string;
{$IFDEF WIN32}
var
  pc1,
  pc2  : PChar;
begin
{
 although you can use huge strings with
 Delphi 2.x, we'll use good old PChars
 and allocate memory here
}
  pc1 :=
    StrAlloc( Length( csVarName )+1 );
  pc2 :=
    StrAlloc( cnMaxVarValueSize + 1 );
  StrPCopy( pc1, csVarName );
  GetEnvironmentVariableA(
    pc1, pc2, cnMaxVarValueSize );
  Result := StrPas( pc2 );
  StrDispose( pc1 );
  StrDispose( pc2 );
end;

{$ELSE}

var
  w1  : Word;
  pc1 : PChar;
begin
  GetEnvVar     := '';

  w1 := Length( csVarName );

{$IFDEF Windows}
  pc1 := GetDosEnvironment;
{$ELSE}
  pc1 :=
    Ptr(Word( Ptr( PrefixSeg, $2C )^),
    0 );
{$ENDIF}
  while( #0 <> pc1^ ) do
  begin
    if( 0 = StrLIComp( pc1,
            @csVarName[ 1 ], w1 ) )
        and ( '=' = pc1[ w1 ] ) then
    begin
      GetEnvVar :=
        StrPas( pc1 + w1 + 1 );
      Exit;
    end;
    Inc( pc1, StrLen( pc1 ) + 1 );
  end;
  GetEnvVar := '';
end;
{$ENDIF}


Function Get_Environment_Data(Var EnvironmentStringList: TStrings): Word;
Var
 pbuf1:    Pointer;
 pbuf:     Pointer;
 s1,s2:    String;
 ok:       Boolean;
begin // Build a StringList containing all of the Environment Variable Strings
 pbuf:=nil;
 TRY
  pbuf:=GetEnvironmentStrings; //
  TRY
   pbuf1:=pbuf; // duplicate the environment buffer pointer because we will need the original pointer to "free" the buffer later
   s1:=''; ok:=true;
   Result:=0; // EnvironmentStringCount
   while (ok=true) and (length(s1)<4096) do // limit on the buffer size should be more than ample - but you could make it bigger
    begin // build one big string that contains all of the environment variables
     s1:=s1+char(pbuf1^);
     pbuf1:=pointer(longword(pbuf1)+1); // pointer arithmetic (simple but effective)
     if pos(#0+#0,s1)<>0 then ok:=false; // double null indicates end of the last environment string
    end;

   if ok=true then if s1[length(s1)]<>#0 then s1:=s1+#0; // ensure presence of null terminator for last environment variable

   while pos(#0+#0,s1)<>0 do delete(s1,pos(#0+#0,s1),1); // probably uneccessary, but, reduce any "double nulls" to a single null
   while length(s1)>0 do
    begin // break the big string into individual environment strings
     if copy(s1,1,pred(pos(#0,s1)))<>'' then
      begin // there is some "stuff" to be processed
       s2:=copy(s1,1,pred(pos(#0,s1)));
       if length(s2)>=3 then // we require at least char+'='+char otherwise string can not be a valid environment variable
        if pos('=',s2)>1 then // '=' can not be first, if it is string can be valid
         if pos('=',s2)<length(s2) then // '=' can not be last, if ir is string can not be valid
          begin
           EnvironmentStringList.Add(s2); // retain valid Environment Variable String
           Inc(Result); // Increment the EnvironmentStringCount
           end;
      end;
     delete(s1,1,pos(#0,s1)); // get rid of the bit we have just processed
    end;
  EXCEPT // exception error! (this would be unlikely)
   Result:=0;
   EnvironmentStringList.Clear;
  END;
 FINALLY
  if pbuf<>nil then FreeEnvironmentStrings(pbuf); // get rid of the buffer
 END;
end;



procedure swap(var v1,v2:single);
var t:single;
begin
  t:=v1;
  v1:=v2;
  v2:=t;
end;


function CtrlDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Control] And 128) <> 0) ;
end;

function ShiftDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Shift] and 128) <> 0) ;
end;

function AltDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Menu] and 128) <> 0) ;
end;

function MouseLeft : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[VK_LBUTTON] and 128) <> 0) ;
end;

function MouseRight : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[VK_RBUTTON] and 128) <> 0) ;
end;



{
  GetSpecialFolder:   Función que sirve para obtener la ruta definida por el S.O.
                      para ciertas carpetas, como por ejemplo mis documentos,
                      Escritorio, etc.

  Constantes:

  CSIDL_DESKTOP
  CSIDL_INTERNET
  CSIDL_PROGRAMS
  CSIDL_CONTROLS
  CSIDL_PRINTERS
  CSIDL_PERSONAL
  CSIDL_FAVORITES
  CSIDL_STARTUP
  CSIDL_RECENT
  CSIDL_SENDTO
  CSIDL_BITBUCKET
  CSIDL_STARTMENU
  CSIDL_DESKTOPDIRECTORY
  CSIDL_DRIVES
  CSIDL_NETWORK
  CSIDL_NETHOOD
  CSIDL_FONTS
  CSIDL_TEMPLATES
  CSIDL_COMMON_STARTMENU
  CSIDL_COMMON_PROGRAMS
  CSIDL_COMMON_STARTUP
  CSIDL_COMMON_DESKTOPDIRECTORY
  CSIDL_APPDATA
  CSIDL_PRINTHOOD
  CSIDL_ALTSTARTUP
  CSIDL_COMMON_ALTSTARTUP
  CSIDL_COMMON_FAVORITES
  CSIDL_INTERNET_CACHE
  CSIDL_COOKIES
  CSIDL_HISTORY

}
function GetSpecialFolder(FolderID : longint) : string;
var
 Path : pchar;
 idList : PItemIDList;
begin
 GetMem(Path, MAX_PATH);
 SHGetSpecialFolderLocation(0, FolderID, idList);
 SHGetPathFromIDList(idList, Path);
 Result := string(Path);
 FreeMem(Path);
end;

function GetMyDocDir: string;
begin
  Result := GetSpecialFolder(CSIDL_PERSONAL);
end;

function tempdir:string;
begin
  result:=getmydocdir+'\temp\';
  forcedirectories(result);
end;

procedure crearcsv(archivo:string;columnas:array of string);
var
  tf:textfile;
  i:integer;
begin
  assignfile(tf,archivo);
  rewrite(tf);
  for i:=0 to high(columnas)-1 do
    write(tf,columnas[i],',');
  write(tf,columnas[high(columnas)]);
  closefile(tf);
end;


function DelTree(const Directory: string):boolean;
var
  DrivesPathsBuff: array[0..1024] of char;
  DrivesPaths: string;
  len: longword;
  ShortPath: array[0..MAX_PATH] of char;
  dir: TFileName;
  procedure rDelTree(const Directory: TFileName);
  // Borrar recursivamente todos los archivos y directorios
  // dentro del directorio que se pasa como parámetro.
  var
    SearchRec: TSearchRec;
    Attributes: LongWord;
    ShortName, FullName: TFileName;
    pname: pchar;
  begin
    if FindFirst(Directory + '*', faAnyFile and not faVolumeID,
       SearchRec) = 0 then begin
      try
        repeat // Procesa todos los archivos y directorios
          if SearchRec.FindData.cAlternateFileName[0] = #0 then
            ShortName := SearchRec.Name
          else
            ShortName := SearchRec.FindData.cAlternateFileName;
          FullName := Directory + ShortName;
          if (SearchRec.Attr and faDirectory) <> 0 then begin
            // Es un directorio
            if (ShortName <> '.') and (ShortName <> '..') then
              rDelTree(FullName + '\');
          end else begin
            // Es un archivo
            pname := PChar(FullName);
            Attributes := GetFileAttributes(pname);
            if Attributes = $FFFFFFFF then
              raise EInOutError.Create(SysErrorMessage(GetLastError));
            if (Attributes and FILE_ATTRIBUTE_READONLY) <> 0 then
              SetFileAttributes(pname, Attributes and not
                FILE_ATTRIBUTE_READONLY);
            if Windows.DeleteFile(pname) = False then
              raise EInOutError.Create(SysErrorMessage(GetLastError));
          end;
        until FindNext(SearchRec) <> 0;
      except
        sysutils.FindClose(SearchRec);
        raise;
      end;
      sysutils.FindClose(SearchRec);
    end;

    if Pos(#0 + Directory + #0, DrivesPaths) = 0 then begin
      // Si no es un directorio raíz, lo remueve
      pname := PChar(Directory);
      Attributes := GetFileAttributes(pname);
      if Attributes = $FFFFFFFF then
        raise EInOutError.Create(SysErrorMessage(GetLastError));
      if (Attributes and FILE_ATTRIBUTE_READONLY) <> 0 then
        SetFileAttributes(pname, Attributes and not
          FILE_ATTRIBUTE_READONLY);
      if Windows.RemoveDirectory(pname) = False then begin
        raise EInOutError.Create(SysErrorMessage(GetLastError));
      end;
    end;
  end;

// ----------------
begin
  if directoryexists(directory) then
  try
    DrivesPathsBuff[0] := #0;
    len := GetLogicalDriveStrings(1022, @DrivesPathsBuff[1]);
    if len = 0 then
    begin
      result:=false;
      raise
      EInOutError.Create(SysErrorMessage(GetLastError));
    end;
    SetString(DrivesPaths, DrivesPathsBuff, len + 1);
    DrivesPaths := Uppercase(DrivesPaths);
    len := GetShortPathName(PChar(Directory), ShortPath, MAX_PATH);
    if len = 0 then
      raise EInOutError.Create(SysErrorMessage(GetLastError));
    SetString(dir, ShortPath, len);
    dir := Uppercase(dir);
    rDelTree(IncludeTrailingBackslash(dir));
    result:=true;
  except
    result:=false;
  end
  else result:=true;
end;


Function DelTree2(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;


procedure RunOnStartup(sProgTitle, sCmdLine: string; bStartup: boolean );
var
  sKey: string;
  reg : TRegIniFile;
begin
  sKey := ''; //sKey := 'Once' if you wish it to only run on the next time you startup.
  if bStartup = false then //If value passed is false, then value deleted from Registry.
  begin
    try
      reg := TRegIniFile.Create( '' );
      reg.RootKey := HKEY_LOCAL_MACHINE;
      reg.DeleteKey(
      'Software\Microsoft'
      + '\Windows\CurrentVersion\Run'
      + sKey + #0,
      sProgTitle);
      reg.Free;
      exit;
    except //Using Try Except so that if value can not be placed in registry, it
    //will not give and error.
    end;
  end;
  try
    reg := TRegIniFile.Create( '' );
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.WriteString(
    'Software\Microsoft'
    + '\Windows\CurrentVersion\Run'
    + sKey + #0,
    sProgTitle,
    sCmdLine );
    reg.Free;
  except
  end;
end;

function TColorToHex(Color : TColor) : string;
begin
   Result :=
     IntToHex(GetRValue(Color), 2) +
     IntToHex(GetGValue(Color), 2) +
     IntToHex(GetBValue(Color), 2) ;
end;

function HexToTColor(sColor : string) : TColor;
begin
   Result :=
     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     ) ;
end;

function var2int(v:variant):integer;
begin
  if v=null
  then result:=0
  else result:=v;
end;

function var2str(v:variant):string;
begin
  if v=null
  then result:=''
  else result:=v;
end;

function var2single(v:variant):single;
begin
  if v=null
  then result:=0
  else result:=v;
end;

function var2double(v:variant):single;
begin
  if v=null
  then result:=0
  else result:=v;
end;

function var2datetime(v:variant):TDateTime;
begin
  if v = null
  then Result := EncodeDate(1900,1,1)
  else Result := v;
end;

function SQLint(sesion:TOracleSession;csql:string):integer;
begin
  result := var2int(valorsql(sesion,csql));
end;

function VarToString(Value: Variant): String;
begin
  case TVarData(Value).VType of
    varSmallInt,
    varInteger   : Result := IntToStr(Value);
    varSingle,
    varDouble,
    varCurrency  : Result := FloatToStr(Value);
    varDate      : Result := FormatDateTime('dd/mm/yyyy', Value);
    varBoolean   : if Value then Result := 'T' else Result := 'F';
    varString    : Result := Value;
    else           Result := '';
  end;
end;


function SQLstr(sesion:TOracleSession;csql:string):string;
begin
  result:=var2str(valorsql(sesion,csql));
end;

function SQLSingle(sesion:TOracleSession;csql:string):single;
begin
  result:=var2single(valorsql(sesion,csql));
end;

function SQLint(sesion:TOracleSession;csql:string; params : array of variant):integer;
begin
  result := var2int(valorsql(sesion,csql,params));
end;


function SQLstr(sesion:TOracleSession;csql:string; params : array of variant):string;
begin
  result:=var2str(valorsql(sesion,csql,params));
end;

function SQLSingle(sesion:TOracleSession;csql:string; params : array of variant):single;
begin
  result:=var2single(valorsql(sesion,csql, params));
end;
function SQLDouble(sesion:TOracleSession;csql:string; params : array of variant):double;
begin
  result := var2double(valorsql(sesion,csql, params));
end;

function SQLDateTime(sesion:TOracleSession;csql:string):TDateTime;
begin
  result:=var2DateTime(valorsql(sesion,csql));
end;

function SQLDateTime(sesion:TOracleSession;csql:string; params : array of variant):TDateTime;
begin
  result:=var2DateTime(valorsql(sesion,csql, params));
end;


procedure SetJPGCompression(ACompression : integer; const AInFile : string;
                            const AOutFile : string);
var iCompression : integer;
    oJPG : TJPegImage;
    oBMP : graphics.TBitMap;
begin
  // Force Compression to range 1..100
  iCompression := abs(ACompression);
  if iCompression = 0 then iCompression := 1;
  if iCompression > 100 then iCompression := 100;

  // Create Jpeg and Bmp work classes
  oJPG := TJPegImage.Create;
  oJPG.LoadFromFile(AInFile);

  oBMP := graphics.TBitMap.Create;
  oBMP.Assign(oJPG);

  // Do the Compression and Save New File
  oJPG.CompressionQuality := iCompression;
  oJPG.Compress;
  oJPG.SaveToFile(AOutFile);

  // Clean Up
  oJPG.Free;
  oBMP.Free;
end;

function DSiFileTimeToDateTime(fileTime: TFileTime; var dateTime: TDateTime): boolean;
var
  sysTime: TSystemTime;
begin
  Result := FileTimeToSystemTime(fileTime, sysTime);
  if Result then
    dateTime := SystemTimeToDateTime(sysTime);
end; { DSiFileTimeToDateTime }

function  DSiGetFileTimes(const fileName: string; var creationTime, lastAccessTime,
  lastModificationTime: TDateTime): boolean;
var
  fileHandle            : cardinal;
  fsCreationTime        : TFileTime;
  fsLastAccessTime      : TFileTime;
  fsLastModificationTime: TFileTime;
begin
  Result := false;
  fileHandle := CreateFile(PChar(fileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if fileHandle <> INVALID_HANDLE_VALUE then try
    Result :=
      GetFileTime(fileHandle, @fsCreationTime, @fsLastAccessTime,
         @fsLastModificationTime) and
      DSiFileTimeToDateTime(fsCreationTime, creationTime) and
      DSiFileTimeToDateTime(fsLastAccessTime, lastAccessTime) and
      DSiFileTimeToDateTime(fsLastModificationTime, lastModificationTime);
  finally
    CloseHandle(fileHandle);
  end;
end; { DSiGetFileTimes }

function fechaCrea(arch:string):tdatetime;
var f1,f2:tdatetime;
begin
  GetFileTimes(arch,f1,f2,f2);
  result:=f1;
end;

function fechaModif(arch:string):tdatetime;
var f1,f2:tdatetime;
begin
  GetFileTimes(arch,f2,f1,f2);
  result:=f1;
end;

function fechaModif2(arch:string):tdatetime;
var filedate : Integer;
begin
  fileDate := FileAge(arch);
  result := FileDateToDateTime(fileDate);
end;

function fechaAcceso(arch:string):tdatetime;
var f1,f2:tdatetime;
begin
  GetFileTimes(arch,f2,f2,f1);
  result:=f1;
end;

procedure Split
   (const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

procedure RegisterFileType(ExtName:String; AppName:String) ;
var
  reg:TRegistry;
begin
  //if ExtName[1] = '.' then ExtName := Copy(ExtName,1,2);  
  reg := TRegistry.Create;
  try
   reg.RootKey:=HKEY_CLASSES_ROOT;
   reg.OpenKey('.' + ExtName, True) ;
   reg.WriteString('', ExtName + 'file') ;
   reg.CloseKey;
   reg.CreateKey(ExtName + 'file') ;
   reg.OpenKey(ExtName + 'file\DefaultIcon', True) ;
   reg.WriteString('', AppName + ',0') ;
   reg.CloseKey;
   reg.OpenKey(ExtName + 'file\shell\open\command', True) ;
   reg.WriteString('',AppName+' "%1"') ;
   reg.CloseKey;
  finally
   reg.Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil) ;
end;

//get the rectangle of the active control (outside of the application)
function GetFocusedControlRect: TRect;
var
  focusedHandle, activeWinHandle: HWND;
  focusedRect: TRect;
  focusedThreadID : DWORD;
begin
  activeWinHandle := GetForegroundWindow;
  focusedThreadID := GetWindowThreadProcessID(activeWinHandle, nil) ;
  if AttachThreadInput(GetCurrentThreadID, focusedThreadID, true) then
  try
    focusedHandle := GetFocus;
    if focusedHandle <> 0 then
    begin
      GetWindowRect(focusedHandle, focusedRect) ;
      result := focusedRect;
    end
    else
      result := rect(0, 0, Screen.width, Screen.height) ;
  finally
    AttachThreadInput(GetCurrentThreadID, focusedThreadID, false) ;
  end;
end;

function FileVersion(const FileName: String = '';
  const Fmt: String = '%d.%d.%d.%d'): String;
var
  sFileName: String;
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: array[1..4] of Word;
begin
  // set default value
  Result := '';
  // get filename of exe/dll if no filename is specified
  sFileName := Trim(FileName);
  if (sFileName = '') then
    sFileName := GetModuleName(HInstance);
  // get size of version info (0 if no version info exists)
  iBufferSize := GetFileVersionInfoSize(PChar(sFileName), iDummy);
  if (iBufferSize > 0) then
  begin
    GetMem(pBuffer, iBufferSize);
    try
    // get fixed file info (language independent)
    GetFileVersionInfo(PChar(sFileName), 0, iBufferSize, pBuffer);
    VerQueryValue(pBuffer, '\', pFileInfo, iDummy);
    // read version blocks
    iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    iVer[4] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      FreeMem(pBuffer);
    end;
    // format result string
    Result := Format(Fmt, [iVer[1], iVer[2], iVer[3], iVer[4]]);
  end;
end;


function lpad(n, digitos:Integer):string;
var i,l : Integer;
begin
  result := IntToStr(n);
  l := Length(result);
  for i := l to digitos-1 do
    result := '0' + Result;
end;

FUNCTION  AnsiToUtf8 (Source : ANSISTRING) : STRING;
          (* Converts the given Windows ANSI (Win1252) String to UTF-8. *)
VAR
  I   : INTEGER;  // Loop counter
  U   : WORD;     // Current Unicode value
  Len : INTEGER;  // Current real length of "Result" string
BEGIN
  SetLength (Result, Length (Source) * 3);   // Worst case
  Len := 0;
  FOR I := 1 TO Length (Source) DO BEGIN
    U := WIN1252_UNICODE [ORD (Source [I])];
    CASE U OF
      $0000..$007F : BEGIN
                       INC (Len);
                       Result [Len] := CHR (U);
                     END;
      $0080..$07FF : BEGIN
                       INC (Len);
                       Result [Len] := CHR ($C0 OR (U SHR 6));
                       INC (Len);
                       Result [Len] := CHR ($80 OR (U AND $3F));
                     END;
      $0800..$FFFF : BEGIN
                       INC (Len);
                       Result [Len] := CHR ($E0 OR (U SHR 12));
                       INC (Len);
                       Result [Len] := CHR ($80 OR ((U SHR 6) AND $3F));
                       INC (Len);
                       Result [Len] := CHR ($80 OR (U AND $3F));
                     END;
      END;
    END;
  SetLength (Result, Len);
END;


FUNCTION  Utf8ToAnsi (Source : STRING; UnknownChar : CHAR = '?') : ANSISTRING;
          (* Converts the given UTF-8 String to Windows ANSI (Win-1252).
             If a character can not be converted, the "UnknownChar" is inserted. *)
VAR
  SourceLen : INTEGER;  // Length of Source string
  I, K      : INTEGER;
  A         : BYTE;     // Current ANSI character value
  U         : WORD;
  Ch        : CHAR;     // Dest char
  Len       : INTEGER;  // Current real length of "Result" string
BEGIN
  SourceLen := Length (Source);
  SetLength (Result, SourceLen);   // Enough room to live
  Len := 0;
  I   := 1;
  WHILE I <= SourceLen DO BEGIN
    A := ORD (Source [I]);
    IF A < $80 THEN BEGIN                                               // Range $0000..$007F
      INC (Len);
      Result [Len] := Source [I];
      INC (I);
      END
    ELSE BEGIN                                                          // Determine U, Inc I
      IF (A AND $E0 = $C0) AND (I < SourceLen) THEN BEGIN               // Range $0080..$07FF
        U := (WORD (A AND $1F) SHL 6) OR (ORD (Source [I+1]) AND $3F);
        INC (I, 2);
        END
      ELSE IF (A AND $F0 = $E0) AND (I < SourceLen-1) THEN BEGIN        // Range $0800..$FFFF
        U := (WORD (A AND $0F) SHL 12) OR
             (WORD (ORD (Source [I+1]) AND $3F) SHL 6) OR
             (      ORD (Source [I+2]) AND $3F);
        INC (I, 3);
        END
      ELSE BEGIN                                                        // Unknown/unsupported
        INC (I);
        FOR K := 7 DOWNTO 0 DO
          IF A AND (1 SHL K) = 0 THEN BEGIN
            INC (I, (A SHR (K+1))-1);
            BREAK;
            END;
        U := WIN1252_UNICODE [ORD (UnknownChar)];
        END;
      Ch := UnknownChar;                                                // Retrieve ANSI char
      FOR A := $00 TO $FF DO
        IF WIN1252_UNICODE [A] = U THEN BEGIN
          Ch := CHR (A);
          BREAK;
          END;
      INC (Len);
      Result [Len] := Ch;
      END;
    END;
  SetLength (Result, Len);
END;


function PadWithZeros(const Value: String; PadLength: Integer): String;
begin
result:= StringOfChar('0', PadLength - Length(Value)) + Value;
end;

// ================================================================
// Return the three dates (Created,Modified,Accessed)
// of a given filename. Returns FALSE if file cannot
// be found or permissions denied. Results are returned
// in TdateTime VAR parameters
// ================================================================
// ================================================================
// Devuelve las tres fechas (Creación, modificación y último acceso)
// de un fichero que se pasa como parámetro.
// Devuelve FALSO si el fichero no se ha podido acceder, sea porque
// no existe o porque no se tienen permisos. Las fechas se devuelven
// en tres parámetros de ipo DateTime
// ================================================================
function GetFileTimes(FileName : string; var Created : TDateTime;
    var Modified : TDateTime; var Accessed : TDateTime) : boolean;
var
   FileHandle : integer;
   Retvar : boolean;
   FTimeC,FTimeA,FTimeM : TFileTime;
   LTime : TFileTime;
   STime : TSystemTime;
begin
  // Abrir el fichero
  FileHandle := FileOpen(FileName,fmShareDenyNone);
  // inicializar
  Created := 0.0;
  Modified := 0.0;
  Accessed := 0.0;
  // Ha tenido acceso al fichero?
  if FileHandle < 0 then
    RetVar := false
  else begin
 
    // Obtener las fechas
    RetVar := true;
    GetFileTime(FileHandle,@FTimeC,@FTimeA,@FTimeM);
    // Cerrar
    FileClose(FileHandle);
    // Creado
    FileTimeToLocalFileTime(FTimeC,LTime);
 
    if FileTimeToSystemTime(LTime,STime) then begin
      Created := EncodeDate(STime.wYear,STime.wMonth,STime.wDay);
      Created := Created + EncodeTime(STime.wHour,STime.wMinute,
              STime.wSecond, STime.wMilliSeconds);
    end;
 
    // Accedido
    FileTimeToLocalFileTime(FTimeA,LTime);
 
    if FileTimeToSystemTime(LTime,STime) then begin
      Accessed := EncodeDate(STime.wYear,STime.wMonth,STime.wDay);
      Accessed := Accessed + EncodeTime(STime.wHour,STime.wMinute,
              STime.wSecond, STime.wMilliSeconds);
    end;
 
    // Modificado
    FileTimeToLocalFileTime(FTimeM,LTime);
 
    if FileTimeToSystemTime(LTime,STime) then begin
      Modified := EncodeDate(STime.wYear,STime.wMonth,STime.wDay);
      Modified := Modified + EncodeTime(STime.wHour,STime.wMinute,
                     STime.wSecond, STime.wMilliSeconds);
    end;
  end;
  Result := RetVar;
end;


function FindFiles(const Path, Mask: string; IncludeSubDir: boolean; list: tstrings): integer;
var
 FindResult: integer;
 SearchRec : TSearchRec;
begin
 result := 0;

 FindResult := FindFirst(Path + Mask, faAnyFile - faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   { do whatever you'd like to do with the files found }
   list.Add(Path + SearchRec.Name);
   result := result + 1;

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);

 if not IncludeSubDir then
   Exit;

 FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
     result := result +
       FindFiles (Path + SearchRec.Name + '\', Mask, TRUE, list);

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);
end;



function fileowner(filename : string) : string;
var dom, owner : string;
begin
  result := '';
  if GetFileOwner(filename, dom, owner) then
    Result := owner;
end;

function ObtainFileSize(const AFile: String): Int64;
begin
 with TFileStream.Create(AFile, fmOpenRead or fmShareDenyNone) do
 begin
 try
 Result := Size;
 finally
 Free;
 end;
 end;
end;


procedure getvars(cSQL : string; var s : TStringList);
var
  r : TRegExpr;
  i : integer;
  cv : string;
  function stripvar(s : string) : string;
  begin
    while Pos(':',s) > 0 do Delete(s, Pos(':',s),1);
    result := s;
  end;
begin
  r := TRegExpr.Create;
  s := TStringList.Create;
  try // ensure memory clean-up
     r.Expression := '(:[_a-zA-Z]+)+';
     if r.Exec (cSQL) then
      REPEAT
        for i := 0 to r.SubExprMatchCount - 1 do
        begin
          cv := stripvar(r.Match[i]);
          if s.IndexOf(cv) < 0 then
            s.Add(cv);
        end;
      UNTIL not r.ExecNext;
    finally r.Free;
   end;
end;


procedure DeclareAndSetVars(ds : TOracleDataSet; params : array of variant);
var
  s : TStringList;
  i : integer;

  function tipovar(v : Variant) : Integer;
  var
    basicType  : Integer;
    typestring : string;
  begin
//    basicType := VarType(v) and VarTypeMask;
//
//  case basicType of
//    varEmpty     : typeString := 'varEmpty';
//    varNull      : typeString := 'varNull';
//    varSmallInt  : typeString := 'varSmallInt';
//    varInteger   : typeString := 'varInteger';
//    varSingle    : typeString := 'varSingle';
//    varDouble    : typeString := 'varDouble';
//    varCurrency  : typeString := 'varCurrency';
//    varDate      : typeString := 'varDate';
//    varOleStr    : typeString := 'varOleStr';
//    varDispatch  : typeString := 'varDispatch';
//    varError     : typeString := 'varError';
//    varBoolean   : typeString := 'varBoolean';
//    varVariant   : typeString := 'varVariant';
//    varUnknown   : typeString := 'varUnknown';
//    varByte      : typeString := 'varByte';
//    varWord      : typeString := 'varWord';
//    varLongWord  : typeString := 'varLongWord';
//    varInt64     : typeString := 'varInt64';
//    varStrArg    : typeString := 'varStrArg';
//    varString    : typeString := 'varString';
//    varAny       : typeString := 'varAny';
//    varTypeMask  : typeString := 'varTypeMask';
//  end;

    basicType := VarType(v) and VarTypeMask;

    Result := -1;
    case basicType of
      varSmallInt, varInteger, varByte, varWord, varLongWord, varInt64  : Result := otInteger;
      varSingle, varDouble, varCurrency : Result := otFloat;
      varDate      : result := otDate;
      varBoolean   : result := otBoolean;
      varString, varStrArg    : result := otString;
    end;
  end;
begin
  getvars(ds.SQL.Text, s);
  if s.Count - 1 = High(params) then
  for i := 0 to High(params) do
  begin
    if params[i] = Null then
      ds.DeclareAndSet(s.Strings[i],otString,null)
    else
      ds.DeclareAndSet(s.Strings[i], tipovar(Params[i]), params[i]);
  end;
end;


procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
var
  Bmp: graphics.TBitmap;
  Jpg: TJPEGImage;
begin

  Bmp := graphics.TBitmap.Create;
  Jpg := TJPEGImage.Create;
  try
    Bmp.LoadFromFile(BmpFileName);
    Jpg.Assign(Bmp);
    Jpg.SaveToFile(JpgFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

procedure Jpeg2Bmp(const BmpFileName, JpgFileName: string);
var
  Bmp: graphics.TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := graphics.TBitmap.Create;
  Jpg := TJPEGImage.Create;
  try
    Jpg.LoadFromFile(JpgFileName);
    Bmp.Assign(Jpg);
    Bmp.SaveToFile(BmpFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

function GetFileOwner(FileName: string;
  var Domain, Username: string): Boolean;
var
  SecDescr: PSecurityDescriptor;
  SizeNeeded, SizeNeeded2: DWORD;
  OwnerSID: PSID;
  OwnerDefault: BOOL;
  OwnerName, DomainName: PChar;
  OwnerType: SID_NAME_USE;
begin
  GetFileOwner := False;
  GetMem(SecDescr, 1024);
  GetMem(OwnerSID, SizeOf(PSID));
  GetMem(OwnerName, 1024);
  GetMem(DomainName, 1024);
  try
    if not GetFileSecurity(PChar(FileName),
      OWNER_SECURITY_INFORMATION,
      SecDescr, 1024, SizeNeeded) then
      Exit;
    if not GetSecurityDescriptorOwner(SecDescr,
      OwnerSID, OwnerDefault) then
      Exit;
    SizeNeeded  := 1024;
    SizeNeeded2 := 1024;
    if not LookupAccountSID(nil, OwnerSID, OwnerName,
      SizeNeeded, DomainName, SizeNeeded2, OwnerType) then
      Exit;
    Domain   := DomainName;
    Username := OwnerName;
  finally
    FreeMem(SecDescr);
    FreeMem(OwnerName);
    FreeMem(DomainName);
  end;
  GetFileOwner := True;
end;


procedure saveUTF8(archivo: string; data : string);
var
  astr : AnsiString;
  f : File;
  c, escritos : integer;
begin
  astr := AnsiString(data);
  astr := UTF8Encode(astr);
  aStr:= #$EF#$BB#$BF + aStr;
  AssignFile(f,archivo);
  {$I-}
  Rewrite(F,Sizeof(AnsiChar));
  {$I+}
  if IOResult = 0 then
  begin
    c := Length(astr);
    BlockWrite(F,pansichar(aStr)^,c, Escritos);
    CloseFile(F);
  end;
end;

function tipodatos(cad : string) : tTipoDatos;
var
  r : TRegExpr;
begin
  result := tcadena;
  if trim(cad) = '' then exit;
  r := TRegExpr.Create;

  try
    r.Expression := '^((0|-?[1-9]*)(\.[0-9]+)*|-0.[0-9]+)$';
    if r.Exec(cad) then
      result := tNumero
    else
    begin
      r.Expression := '^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[12])/[0-9]{4}$';
      if r.Exec(cad) then
        result := tfecha;
    end;
  finally
    r.Free;
  end;
end;

end.




