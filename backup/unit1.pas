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
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
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

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image3Click(Sender: TObject);
begin

end;

procedure TForm1.Image4Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var tom: Integer;
begin
  for i:= 0 to Image1.Height * 2 do
  begin
   for j := 0 to Image1.Width * 2 do
   begin
    cor := Image1.Canvas.Pixels[i,j];
    tom := round(getRValue(cor) * 0.3 + getGValue(cor) * 0.587 + getBValue(cor) * 0.114);
    if( tom < 64 ) then Image2.Canvas.Pixels[i,j] := RGB(0,0, 4 * tom);
    if( (tom >= 64) and (tom < 128) ) then Image2.Canvas.Pixels[i,j] := RGB(0,(tom-64)*4, 255);
    if( (tom >= 128) and (tom < 192) ) then Image2.Canvas.Pixels[i,j] := RGB(0,255 , 255 - (tom-128)*4);
    if( (tom >= 64) and (tom < 128) ) then Image2.Canvas.Pixels[i,j] := RGB((tom-192)*4 ,255,0 );
   end;
  end;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
var
  k,l, somaInt: Integer;
  tom, soma : Real;
begin           //laplaciano normal
  Image3.Visible := True;
  for i := 0 to Image1.Width do
   begin
   for j := 0 to Image1.Height do
    begin
      soma := 0;
      for k := (i - 1) to (i + 1) do
       begin
         for l := (j - 1) to (j + 1) do
          begin
           cor := Image1.Canvas.Pixels[k,l];
           tom := 0;
           if(k = i) then
             begin
               tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * -1;
             end;
           if(l = j) then
             begin
               tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * -1;
             end;
           if((k = i) and (l=j)) then
             begin
               tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * 4;
             end;

            soma := soma + tom;

          end;
       end;

      somaInt := round(soma);
      Image3.Canvas.Pixels[i,j] := RGB(somaInt,somaInt,somaInt);

    end;
  end;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var
  k,l, soma : Integer;
begin     // laplaciano gaussana
 Image4.Visible := True;
  for i := 0 to Image1.Width do
   begin
   for j := 0 to Image1.Height do
    begin
      soma := 0;
      for k := (i - 2) to (i + 2) do
       begin
         for l := (j - 2) to (j + 2) do
          begin
           cor := Image1.Canvas.Pixels[k,l];
           c := 0; // se eu estivesse em C eu faria uma matriz pra multiplicar, mas n qro pesquisar como fazer isso em pascal
                   // caso for extremamente ineficiente e tomar mto mto tempo, vc nem vai ta lendo isso
           if(                            ((k = i-2) and (l=j))or
                  ((k = i-1) and (l = j-1))          or          ((k = i-1) and (l=j+1))or
           ((k = i) and ( l = j-2 ))                 or                 ((k = i) and (l = j+2))or
                  ((k = i+1) and (l= j-1))           or          ((k = i+1) and (l = j+1))or
                                          ((k = i+2) and (l=j))
           ) then
             begin
               c := round((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * -1;
             end;

           if(                                     ((k = i-1) and (l = j))or
                             ((k = i) and (l = j-1))         or            ((k = i) and (l = j+1))or
                                                   ((k = i+1) and (l = j))
           ) then
             begin
               c :=round((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * -2;
             end;
           if((k = i) and (l=j)) then
             begin
               c := round((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114)) * 16;
             end;

            soma := soma + c;

          end;
       end;
      Image4.Canvas.Pixels[i,j] := RGB(soma,soma,soma);

    end;
  end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem18Click(Sender: TObject);
type
 vector = array [0..255] of Integer;
var
 histogram: vector;
 c : Integer;
 begin
  for i := 0 to Image1.Width do
   begin
    for j := 0 to Image1.Height do
     begin
      cor := Image1.Canvas.Pixels[i,j];
      c := round((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
      histogram[c] := histogram[c] + 1;
     end;
   end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)then
    begin
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);
    Image2.Width := Image1.Width;
    Image2.Height := Image1.Height;
    Image3.Width := Image1.Width;
    Image3.Height := Image1.Height;
    Image4.Width := Image1.Width;
    Image4.Height := Image1.Height;
    end;
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
  for i :=1 to Image1.Width *2  do
   begin
   for j :=1 to Image1.Height  do
    begin
    minimo := 999;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          cor := Image1.Canvas.Pixels[k,l];
          ponto := round(getRValue(cor) * 0.3 + getGValue(cor) * 0.587 + getBValue(cor) * 0.114);
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
  for i :=1 to Image1.Width *2do
   begin
   for j :=1 to Image1.Height do
    begin
    maximo := 0;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          cor := Image1.Canvas.Pixels[k,l];
          ponto := round(getRValue(cor) * 0.3 + getGValue(cor) * 0.587 + getBValue(cor) * 0.114);
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
  for i :=1 to Image1.Width *2 do
   begin
   for j :=1 to Image1.Height  do
    begin
    minimo := 999;
    maximo := 0;
      for k := i - 1 to i + 1 do
       begin
         for l := j - 1 to j + 1 do
          begin
          cor := Image1.Canvas.Pixels[k,l];
          ponto := round(getRValue(cor) * 0.3 + getGValue(cor) * 0.587 + getBValue(cor) * 0.114);
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
      c := round( 0.299 *  r + 0.587 * g + 0.114 * b );
      Ims[i,j] := c;
      Image2.Canvas.Pixels[i,j] := RGB(c,c,c);
    end;
end;

end.
