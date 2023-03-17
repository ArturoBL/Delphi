unit IXMLData;

interface

uses
  XMLIntf, XMLDoc, sysutils, classes;

type
  TIXMLDoc = class
  private
    fdoc : IXMLDocument;
    frootnode : IXMLNode;
    fFileName : string;
    procedure setFilename(const Value: string);
    function getXML: string;
  protected

  public
    constructor Create(RootNodeName: string; Encoding : string = 'utf-8');
    constructor CreateFromFile(FileName : string);
    constructor CreateFromString(XMLString : string);
    constructor CreateXMLFile(Filename, RootNodeName: string; Encoding : string = 'utf-8');
    destructor Destroy;
    property document : IXMLDocument read fdoc;
    property rootnode : IXMLNode read frootnode;
    property FileName : string read fFileName write setFilename;
    procedure Save;
    procedure SaveTofile(Filename : string);
    function childcount : integer;
    function FindNode(NodeName : string) : IXMLNode;
    function AttributeValue(NodeName, AttrName : string) : string;
    function Text(NodeName : string) : string;
    function addNode(Node : IXMLNode; NodeName : string) : IXMLNode; overload;
    function addNode(NodeName : string) : IXMLNode; overload;
    property XML : string read getXML;
  published

  end;


implementation

{ TIXMLDoc }

function TIXMLDoc.addNode(Node: IXMLNode; NodeName: string): IXMLNode;
begin
  Result := Node.AddChild(NodeName);
end;

function TIXMLDoc.addNode(NodeName: string): IXMLNode;
begin
  Result := addNode(frootnode, NodeName);
end;

function TIXMLDoc.AttributeValue(NodeName, AttrName: string): string;
var
  n : IXMLNode;
begin
  result := '';
  n := FindNode(NodeName);
  if n <> nil then
    result := n.Attributes[AttrName];
end;

function TIXMLDoc.childcount: integer;
begin
  result := frootnode.ChildNodes.Count;
end;

constructor TIXMLDoc.Create(RootNodeName, Encoding: string);
begin
  try
    fdoc :=  NewXMLDocument;
    fdoc.Encoding := Encoding;
    fdoc.Options := [doNodeAutoIndent]; // looks better in Editor ;)
    frootnode := fdoc.AddChild(RootNodeName);
  except
    on e: exception do
    begin
      raise Exception.Create('Error: ' + e.Message);
    end;
  end;
end;

constructor TIXMLDoc.CreateFromFile(FileName : string);
begin
  if fileexists(FileName) then
  begin
    fdoc := LoadXMLDocument(FileName);
    frootnode := fdoc.DocumentElement;
    fFileName := FileName;
  end
  else
    raise Exception.Create('File not found!');
end;

constructor TIXMLDoc.CreateFromString(XMLString: string);
begin
  fFileName := '';
  fdoc := LoadXMLData(XMLString);
  frootnode := fdoc.DocumentElement;
end;

constructor TIXMLDoc.CreateXMLFile(Filename, RootNodeName: string; Encoding : string = 'utf-8');
begin
  Create(RootNodeName, Encoding);
  fFileName := FileName;
end;

destructor TIXMLDoc.Destroy;
begin

end;

function TIXMLDoc.FindNode(NodeName: string): IXMLNode;
var
  n : IXMLNode;
  i : integer;

  function findFromNode(Node : IXMLNode; NodeName : string) : IXMLNode;
  var
    i : integer;
    n : IXMLNode;
  begin
    Result := nil;
    if node.NodeName = NodeName then
      Result := Node
    else
    begin
      for i := 0 to node.ChildNodes.Count - 1 do
      begin
        result := findFromNode(node.ChildNodes[i],NodeName);
        if result <> nil then exit;
      end;
    end;
  end;
begin
  Result := findFromNode(frootnode, NodeName);
end;

function TIXMLDoc.getXML: string;
begin
  result := '';
  if rootnode <> nil then
    Result := rootnode.XML;
end;

procedure TIXMLDoc.Save;
begin
  if trim(fFileName) = '' then
    raise Exception.Create('Filename not set')
  else
  try
    fdoc.SaveToFile(fFileName);
  except
    on e: Exception do
    begin
      raise Exception.Create('Error saving file: ' + e.message);
    end;
  end;
end;

procedure TIXMLDoc.SaveTofile(Filename: string);
begin
  fdoc.SaveToFile(FileName);
end;

procedure TIXMLDoc.setFilename(const Value: string);
begin
  fFileName := Value;
end;

function TIXMLDoc.Text(NodeName: string): string;
var
  n : IXMLNode;
begin
  result := '';
  n := FindNode(NodeName);
  if n <> nil then
    result := n.Text;
end;

end.
