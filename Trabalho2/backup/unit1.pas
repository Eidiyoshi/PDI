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
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
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

procedure TForm1.MenuItem12Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var tom: Integer;
begin
  for i:= 0 to Image1.Height do
  begin
   for j := 0 to Image1.Width do
   begin
    cor := Image1.Canvas.Pixels[i,j];
    tom := getRValue(cor);
    if( tom < 64 ) then Image2.Canvas.Pixels[i,j] := RGB(0,0, 4 * tom);
    if( (tom >= 64) and (tom < 128) ) then Image2.Canvas.Pixels[i,j] := RGB(0,(tom-64)*4, 255);
    if( (tom >= 128) and (tom < 192) ) then Image2.Canvas.Pixels[i,j] := RGB(0,255 , 255 - (tom-128)*4);
    if( (tom >= 64) and (tom < 128) ) then Image2.Canvas.Pixels[i,j] := RGB((tom-192)*4 ,255,0 );
   end;
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)then
    begin
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);
    end;

  Image2.Picture := Image1.Picture;
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
  for j:=0 to Image1.Height do
      for i := 0 to Image1.Width do
          begin
               if (i = 0) then
                 begin
                 ci := 1 / sqrt(Image1.Height);
                 end
               else
               begin
                    ci := sqrt(2) / sqrt(Image1.Height);
               end;

               if (j = 0) then
                 begin
                 cj := 1 / sqrt(Image1.Width);
                 end
               else
               begin
                    cj := sqrt(2) / sqrt(Image1.Width);
               end;
               soma := 0;
               for k:= 0 to Image1.Height do
                for l:= 0 to Image1.Width do
                 begin
                      dct1 :=  GetRValue(Image1.Canvas.Pixels[i,k]) *
                               cos((2 * k + 1) * i * 3.14 / (2 * Image1.Height)) *
                               cos((2 * l + 1) * j * 3.14 / (2 * Image1.Width));
                      soma := soma + dct1;
                 end;
                 c := Trunc(ci * cj * soma);
                 Image2.Canvas.Pixels[i,j] := RGB(c,c,c);
          end;
end;


procedure TForm1.MenuItem8Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var
   minimo, ponto, k, l: Integer;
begin
  for i :=1 to Image1.Height - 1 do
   begin
   for j :=1 to Image1.Width - 1 do
    begin
    minimo := 999;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          ponto := getRValue(Image1.Canvas.Pixels[k,l]);
           if( ponto < minimo ) then
             begin
               minimo := ponto;
             end;
          end;
       end;
       Image2.Canvas.Pixels[i,j] := RGB(minimo,minimo,minimo);
    end;
  end;
end;


procedure TForm1.MenuItem10Click(Sender: TObject);
var
   maximo, ponto, k, l: Integer;
begin
  for i :=1 to Image1.Height - 1 do
   begin
   for j :=1 to Image1.Width - 1 do
    begin
    maximo := 0;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          ponto := getRValue(Image1.Canvas.Pixels[k,l]);
           if( ponto > maximo ) then
             begin
               maximo := ponto;
             end;
          end;
       end;
       Image2.Canvas.Pixels[i,j] := RGB(maximo,maximo,maximo);
    end;
  end;
end;


procedure TForm1.MenuItem11Click(Sender: TObject);
var
   minimo, maximo, medio, ponto, k, l: Integer;
begin
  for i :=1 to Image1.Height - 1 do
   begin
   for j :=1 to Image1.Width - 1 do
    begin
    minimo := 999;
    maximo := 0;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          ponto := getRValue(Image1.Canvas.Pixels[k,l]);
           if( ponto < minimo ) then
             begin
               minimo := ponto;
             end;
           if( ponto > maximo ) then
             begin
               maximo := ponto;
             end;
          end;
       end;
       medio := trunc((maximo + minimo) / 2);
       Image2.Canvas.Pixels[i,j] := RGB(medio,medio,medio);
    end;
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

end.
