unit MSG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure ScanNet();
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{��������� ������������ �������� ���������
��������� ������������ ���������� � ���� msg.cfg}
procedure TForm1.Button2Click(Sender: TObject);
Var i:integer;
    s:string;
begin
  for i:=0 to ListBox1.Items.Count-1 do
    if ListBox1.Selected[i] then
      begin
        //�������� ������� � cmd
        s:='cmd /c msg * /server:'+TrimRight(ListBox1.Items[i])+' '+Trim(Edit1.Text);
        //� ���� ����� WinExec �� �����-�� ������� �� ��������� ���������, ���������� ShellExecute
        ShellExecute(Handle, nil, 'cmd.exe', PChar(s), nil, SW_HIDE);
      end;
  {//�������� ������� � cmd
  s:='cmd /c msg * /server:'+TrimRight(ListBox1.Items[0])+' '+Trim(Edit1.Text);
  //debug �������
  label3.Caption:=s+inttostr(s.Length);
  //� ���� ����� WinExec �� �����-�� ������� �� ��������� ���������, ���������� ShellExecute
  ShellExecute(Handle, nil, 'cmd.exe', PChar(s), nil, SW_HIDE);}
end;

//�������� ��� ������ ������
procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to ListBox1.Items.Count-1 do
    ListBox1.Selected[i]:=True;
end;

//������� ��������� �� ���� ����� ������
procedure TForm1.Button4Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to ListBox1.Items.Count-1 do
    ListBox1.Selected[i]:=False;
end;

procedure TForm1.ScanNet();
var s:string;
    i:integer;
begin
  //������� ������
  ListBox1.Items.Clear;
  //��������� ������� ��������� � ����
  WinExec(PAnsiChar('cmd /c net view>msg.cfg'),SW_HIDE);
  //�������� �� ���������������� ����� �����
  //���� ���� ��� �� ����� ����������, ������� ������� � ������� �����
  if FileExists('msg.cfg') then
    ListBox1.Items.LoadFromFile('msg.cfg')
  Else
  Begin
    Sleep(1000);
    ListBox1.Items.LoadFromFile('msg.cfg')
  End;
  //������� ������ ��� ������, ��� ������
  ListBox1.Items.Delete(0);
  ListBox1.Items.Delete(0);
  ListBox1.Items.Delete(0);
  //������� ��������� ��� ������, ��� ���� ������ � �������� �������� �� �����
  ListBox1.Items.Delete(ListBox1.Items.Count-1);
  ListBox1.Items.Delete(ListBox1.Items.Count-1);
  //���������� ��� ������ ������
  for i:=0 to ListBox1.Items.Count-1 do
    begin
      //��������� �������� �� ������ � ���������� ����������
      s:=ListBox1.Items[i];
      //������� ������ ��� ������� ������
      Delete(s,1,2);
      //������� ������� ����� ������
      ListBox1.Items.Delete(i);
      //�������� ������ ���� ������������
      ListBox1.Items.Insert(i,s);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //��������� ��������� �������� �������� ���������
  ScanNet;
end;

end.
