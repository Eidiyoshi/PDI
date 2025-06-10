unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  r, g, b, c, i, j : integer;
  ime, ims : array[0..319,0..239] of integer;
  cor : TColor;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    Ime[i,j] := Ims[i,j];

  Image1.Picture := Image2.Picture;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin

end;

procedure TForm1.Image6Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)
   then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
var
  ci, cj, dct1, soma : real;
  k, l : Integer;

begin
  for j:=0 to 128 do
      for i= 0 to 128 do
          begin
               if i = 0 then
                 ci := 1 / sqrt(Image1.Height);
               else
                 ci = sqrt(2) / sqrt(Image1.Height);

               if j = 0 then
                 cj = 1 / sqrt(Image1.Width);
               else
                 cj = sqrt(2) / sqrt(Image1.Width);

               soma := 0;
               for k:= 0 to 128 do
                for l:= 0 to 128 do
                 begin
                      dct1 :=  Image1.Canvas.Pixels[k,l] *
                               cos((2 * k + 1) * i * 3.14 / (2 * 128)) *
                               cos((2 * l + 1) * j * 3.14 / (2 * 128));
                      soma := soma + dct1;
                 end;
               Image2.Canvas.Pixels[i,j] := ci * cj * soma;
          end;





  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    begin
      cor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      c := round( 0.299 *  R + 0.587 * G + 0.114 * B );
      Ims[i,j] := c;
      Image2.Canvas.Pixels[i,j] := RGB(c,c,c);
    end;

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    begin
      cor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      c := round( 0.299 *  R + 0.587 * G + 0.114 * B );
      Ims[i,j] := c;
      Image2.Canvas.Pixels[i,j] := RGB(c,c,c);
    end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    begin
      cor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      Image2.Canvas.Pixels[i,j] := RGB(255-r,255-g,255-b);
    end;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    begin
      cor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      Image3.Canvas.Pixels[i,j] := RGB(r,0,0);
      Image4.Canvas.Pixels[i,j] := RGB(0,g,0);
      Image5.Canvas.Pixels[i,j] := RGB(0,0,b);
    end;
end;

end.

