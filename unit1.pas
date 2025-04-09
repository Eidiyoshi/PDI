unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, Unit2, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
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
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
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
  R, G, B, cinza, i, j : integer;
  imgIn, imgOut : array[0..350,0..350] of TColor;
  cor : TColor;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
     if(OpenDialog1.Execute) then
         Image1.Picture.LoadFromFile(OpenDialog1.FileName);
         for i := 0 to Image1.Height do
             for j := 0 to Image1.Width do
                 begin
                      imgIn[i,j] := Image1.Canvas.Pixels[i,j]
                 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             imgIn[i,j] := imgOut[i,j];
     Image1.Picture := Image2.Picture;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
     for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             begin
                  cor := RGB(GetRValue(Image2.Canvas.Pixels[i,j]),GetGValue(Image3.Canvas.Pixels[i,j]),GetBValue(Image4.Canvas.Pixels[i,j]));
                  Image1.Canvas.Pixels[i,j] := cor;
                  imgOut[i,j] := cor;
             end;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);    // inverter imagem
var
  k : Integer;
begin
     for i := 0 to Image1.Height do
         begin
         k := Image1.Width;
         for j := 0 to Image1.Width do
             begin
               cor := Image1.Canvas.Pixels[j,i];
               R := GetRValue(cor);
               G := GetGValue(cor);
               B := GetBValue(cor);

               Image2.Canvas.Pixels[k,i] := RGB(R,G,B);
               k -= 1;
             end;

         end;



end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin                                 // transferir pra direita
    for i:= 0 to Image1.Height do
      for j := 0 to Image1.Width do
          begin
             cor := Image1.Canvas.Pixels[i,j];
             R := GetRValue(cor);
             G := GetGValue(cor);
             B := GetBValue(cor);
             Image2.Canvas.Pixels[i,j] := RGB(R,G,B);
          end;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);     // sal e pimenta
begin
  Randomize();
     for i := 0 to Image1.Height do
       for j:= 0 to Image1.Width do
         begin
             cor := Image1.Canvas.Pixels[i,j];
             R := GetRValue(cor);
             G := GetGValue(cor);
             B := GetBValue(cor);
             Image2.Canvas.Pixels[i,j] := RGB(R,G,B);
             if( random(10) = 0 ) then
                 if( random(2) = 0 ) then
                     begin
                        Image2.Canvas.Pixels[i,j] := RGB(255,255,255);
                     end
                 else
                     begin
                        Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
                     end;
         end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
     for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             begin
                  cor := Image1.Canvas.Pixels[i,j];
                  R := GetRValue(cor);
                  G := GetGValue(cor);
                  B := GetBValue(cor);
                  cinza := round(0.299 * R + 0.587 * G + 0.114 * B);
                  Image2.Canvas.Pixels[i,j] := RGB(cinza,cinza,cinza);
                  imgOut[i,j] := RGB(cinza,cinza,cinza);;
             end;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
     for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             begin
                  cor := imgIn[i,j];
                  R := GetRValue(cor);
                  G := GetGValue(cor);
                  B := GetBValue(cor);
                  cinza := round(0.299 * R + 0.587 * G + 0.114 * B);
                  imgOut[i,j] := 255 - cinza;
                  Image2.Canvas.Pixels[i,j] := RGB(ImgOut[i,j],ImgOut[i,j],ImgOut[i,j]);
             end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             begin
                  cor := Image1.Canvas.Pixels[i,j];
                  R := GetRValue(cor);
                  G := GetGValue(cor);
                  B := GetBValue(cor);
                  Image2.Canvas.Pixels[i,j] := RGB(255 - R,255 - G,255 - B);
                  imgOut[i,j] := RGB(255 - R,255 - G,255 - B);;
             end;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  for i := 0 to Image1.Height do
         for j := 0 to Image1.Width do
             begin
                  cor := Image1.Canvas.Pixels[i,j];
                  R := GetRValue(cor);
                  G := GetGValue(cor);
                  B := GetBValue(cor);
                  Image2.Canvas.Pixels[i,j] := RGB(R,R,R);
                  Image3.Canvas.Pixels[i,j] := RGB(G,G,G);
                  Image4.Canvas.Pixels[i,j] := RGB(B,B,B);
             end;
end;

end.

end.

