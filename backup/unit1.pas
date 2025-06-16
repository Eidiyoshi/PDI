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
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
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
    procedure MenuItem20Click(Sender: TObject);
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
  ime, ims : array[0..319,0..239] of TColor;
  dct : array[0..319,0..239] of real;
  cor : TColor;
  firstTime: bool;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  firstTime := true;
  for i := 0 to 319 do
    begin
           for j := 0 to 239 do
           begin
               ime[i,j] := RGB(255,255,255);
               ims[i,j] := RGB(255,255,255);
           end;
    end;
end;

procedure loadArray();
begin
    if firstTime = true then
    begin
         for i := 0 to Form1.Image1.Width - 1 do
         begin
             for j := 0 to Form1.Image1.Height - 1 do
             begin
                  ime[i,j] := Form1.Image1.Canvas.Pixels[i,j];
             end;
         end;
         firstTime := false;
    end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem20Click(Sender: TObject);
var
  vmax, vmin, h, s, l, RR, GG, BB, lmax, lmin, temp1, temp2, temp3, delta : Real;
  flag: Integer;
begin
  lmax := -1;
  lmin := 99;
  for i := 0 to Image1.Width do // pegando max e min
  begin
      for j := 0 to Image1.Height do
      begin
       cor := Image1.Canvas.Pixels[i,j];
       r := getRValue(cor);
       g := getGValue(cor);
       b := getBValue(cor);
       vmax := max( (max(r,g)) ,b) / 255;
       vmin := min( (min(r,g)) ,b) / 255;
       l := ( vmax + vmin ) / 2;

       if( l > lmax ) then
       begin
            lmax := l;
       end;

       if( l < lmin ) then
       begin
            lmin := l;
       end;

      end;
  end;

  for i := 0 to Image1.Width do // equalizando
  begin
      for j := 0 to Image1.Height do
      begin
       cor := Image1.Canvas.Pixels[i,j];
       r := getRValue(cor);
       g := getGValue(cor);
       b := getBValue(cor);

       // calcular hsl primeiro pra dps transformar em rgb
       vmax := max( (max(r,g)) ,b) / 255;
       vmin := min( (min(r,g)) ,b) / 255;
       RR := r / 255;
       GG := g / 255;
       BB := b / 255;

       l := ( vmax + vmin ) / 2;
       delta := ( vmax - vmin);


       if ( delta = 0 ) then
       begin
            s := 0;
       end;
       if( delta <> 0 ) then
       begin
            s := (delta) / ( 1.0 - abs((2*l) - 1) ) ;
       end;
       
       l := (( l - lmin ) / ( lmax - lmin ));

       flag := 1;
       if( delta = 0 ) then
       begin
            h := 0;
            flag := 0;
       end;
       if( (vmax = ( RR )) and (flag = 1)) then
       begin
            h := ((GG-BB)/(delta));
       end;
       if( (vmax = ( GG )) and (flag = 1)) then
       begin
            h := 2 + ((BB-RR)/(delta));
       end;
       if( (vmax = ( BB )) and (flag =1)) then
       begin
            h := 4 + ((RR-GG)/(delta));
       end;

       h := h * 60;
       if ( h < 0 ) then
       begin
            h := h + 360;
       end;

       // hsl pra rgb
       temp1 := ( 1 - abs(2 * l - 1.0) ) * s;
       temp2 := temp1 * ( 1 - abs( ((round(h/60)) MOD 2) - 1) );
       temp3 := l - (temp1/2);
       //temp1 = c
       //temp2 = x
       //temp3 = m

       if( (0 <= h) and (h < 60)) then
       begin
        r := round((temp1+ temp3) * 255);
        g := round((temp2+ temp3) * 255);
        b := round((temp3) * 255);
       end;
       if( (60 <= h) and (h < 120)) then
       begin
        r := round((temp2+ temp3) * 255);
        g := round((temp1+ temp3) * 255);
        b := round((temp3) * 255);
       end;
       if( (120 <= h) and (h < 180)) then
       begin
        r := round((temp3) * 255);
        g := round((temp1+ temp3) * 255);
        b := round((temp2+ temp3) * 255);
       end;
       if( (180 <= h) and (h < 240)) then
       begin
        r := round((temp3) * 255);
        g := round((temp2+ temp3) * 255);
        b := round((temp1+ temp3) * 255);
       end;
       if( (240 <= h) and (h < 300)) then
       begin
        r := round((temp2+ temp3) * 255);
        g := round((temp3) * 255);
        b := round((temp1+ temp3) * 255);
       end;
       if( (300 <= h) and (h < 360)) then
       begin
        r := round((temp1+ temp3) * 255);
        g := round((temp3) * 255);
        b := round((temp2+ temp3) * 255);
       end;

       Image2.Canvas.Pixels[i,j] := RGB(r,g,b);

      end;
  end;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
   for i:=0 to Image1.Width do
    Ime[i,j] := Ims[i,j];

  Image1.Picture := Image2.Picture;
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
  tom, soma,  maximo, minimo : Real;
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

      somaInt := round(soma/4);
      Image3.Canvas.Pixels[i,j] := RGB(somaInt,somaInt,somaInt);
    end;
  end;

  // normalizar
  cor := Image3.Canvas.Pixels[0,0];
  maximo := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
  minimo := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
  for i := 0 to Image3.Width do
   begin
    for j := 0 to Image3.Height do
     begin
       cor := Image3.Canvas.Pixels[i,j];
       tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
       if( tom > maximo ) then maximo := tom;
       if( tom < minimo ) then minimo := tom;
     end;
   end;

  for i := 0 to Image3.Width do
   begin
    for j := 0 to Image3.Height do
     begin
      cor := Image3.Canvas.Pixels[i,j];
      tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
      tom := (( tom - minimo ) / ( maximo - minimo )) * 255;
      somaInt := round(tom);
      Image3.Canvas.Pixels[i,j] := RGB(somaInt, somaInt, somaInt);
     end;
   end;
  k:=k;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var
  k,l, soma, somaInt : Integer;
  maximo, minimo, tom: Real;
begin     // laplaciano gaussana
 Image4.Visible := True;
 for i := 0 to Image1.Width-1 do
  begin
   for j := 2 to Image1.Height-3 do
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
      soma := round(soma / 16);
      Image4.Canvas.Pixels[i,j] := RGB(soma,soma,soma);
    end;
  end;
  //normalizar
  maximo := 0;
  minimo := 99999;
  for i := 0 to Image3.Width-1 do
   begin
    for j := 0 to Image3.Height-1 do
     begin
       cor := Image4.Canvas.Pixels[i,j];
       tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
       if( tom > maximo ) then maximo := tom;
       if( tom < minimo ) then minimo := tom;
     end;
   end;

  for i := 0 to Image3.Width-1 do
   begin
    for j := 0 to Image3.Height-1 do
     begin
      cor := Image4.Canvas.Pixels[i,j];
      tom := ((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
      tom := ( tom - minimo ) / ( maximo - minimo );
      somaInt := round(tom*255);
      Image4.Canvas.Pixels[i,j] := RGB(somaInt, somaInt, somaInt);
     end;
   end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem18Click(Sender: TObject);
type
 vector = array [0..256] of Extended;
var
 histogram, binEdges, binMids, weight1, weight2, histogramBinMids, cumsumMean1, cumsumMean2, mean1, mean2, interclassVariance: vector;
 c, getmax, tom : Integer;
 totalSum, maxi : Real;
 temp, temp2: Extended;
 begin // codigo retirado daq https://learnopencv.com/otsu-thresholding-with-opencv/
  DefaultFormatSettings.DecimalSeparator := '.';
  binEdges[1] := 0;
   for i:= 1 to 256 do // n entendi exatamente o que isso era pra ser
   begin
    histogram[i] := 0;
    binEdges[i+1] := binEdges[i] + 1.0;
    binMids[i] := ((binEdges[i] + binEdges[i+1]) / 2);

    histogram[i] := 0; // mas isso é obvio
   end;

   for i := 0 to Image1.Width do
   begin
    for j := 0 to Image1.Height do
     begin
      cor := Image1.Canvas.Pixels[i,j];
      c := round((getRValue(cor) * 0.29) + (getGValue(cor) * 0.587) + (getBValue(cor) * 0.114));
      histogram[c] := histogram[c] + 1;
     end;
   end;

   weight1[1] := histogram[1] + 1;
   for i := 2 to 256 do
   begin
     weight1[i] := histogram[i] + weight1[i-1];
   end;

   totalSum := 0;
   for i := 1 to 256 do
   begin
    totalSum := totalSum + histogram[i];
   end;

   weight2[1] := totalSum;
   for i := 2 to 256 do
   begin
    weight2[i] := weight2[i-1] - histogram[i-1];
    if ( weight2[i] = 0) then
      begin
       weight2[i] := 1;
      end;

   end;

   for i:= 1 to 256 do
   begin
    histogramBinMids[i] := histogram[i] * binMids[i];
   end;

   cumsumMean1[0] := histogramBinMids[0];
   cumsumMean2[0] := histogramBinMids[256];
   j:= 255;
   for i := 2 to 256 do
   begin
    cumsumMean1[i] := cumsumMean1[i-1] + histogramBinMids[i];
    cumsumMean2[i] := cumsumMean2[i-1] + histogramBinMids[j];
    j := j - 1;
   end;

   j := 256;
   for i := 1 to 256 do
   begin
    mean1[i] := cumsumMean1[i] / weight1[i];
    mean2[i] := cumsumMean2[i] / weight2[j];
    j := j - 1;
   end;

   for i := 1 to 255 do                                         // ||||
   begin                                       // pq desse numero? VVVV n sei n explicaram
    temp := ((weight1[i] * weight2[i] * (mean1[i] - mean2[i+1])) / 10000000000);
    temp2 := mean1[i] - mean2[i+1];
    interClassVariance[i] := (temp) * (temp2);
   end;

   maxi := 0;
   getmax := 0;
   for i := 1 to 255 do
   begin
    if( maxi < interClassVariance[i] ) then
      begin
       maxi := interClassVariance[i];
       getmax := i;
      end;
   end;

   // fim do threshold de otsu, q esta em binMids[getmax]

   // limiarizacao
for i:= 0 to Image1.Height * 2 do
  begin
   for j := 0 to Image1.Width * 2 do
   begin
    cor := Image1.Canvas.Pixels[i,j];
    tom := round(getRValue(cor) * 0.3 + getGValue(cor) * 0.587 + getBValue(cor) * 0.114);
    if( tom > binMids[getMax] ) then
      begin
        Image2.Canvas.Pixels[i,j] := RGB(255,255,255);
        end
    else
        begin
         Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
        end;
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
  ci, cj, dct1, soma: real;
  k, l, resultado, resultadoMin : Integer;
begin
  //loadArray();
  for j:=0 to Image1.Height - 1 do
      for i := 0 to Image1.Width - 1 do
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
               for k:= 0 to Image1.Height - 1 do
                begin
                for l:= 0 to Image1.Width - 1 do
                 begin
                      dct1 :=  GetRValue(Image1.Canvas.Pixels[i,k]);//ime[i,k]);
                      dct1 :=  dct1 * cos((2 * k + 1) * i * 3.142857 / (2 * Image1.Height));
                      dct1 :=  dct1 * cos((2 * l + 1) * j * 3.142857 / (2 * Image1.Width));
                      soma := soma + dct1;
                 end;
                end;
                 resultado := trunc(ci * cj * soma);//Trunc();
                 resultadoMin := min(255,resultado);
                 Image2.Canvas.Pixels[i,j] := RGB(resultadoMin,resultadoMin,resultadoMin);
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
