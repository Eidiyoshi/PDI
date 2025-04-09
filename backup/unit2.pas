unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, math;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label15: TLabel;
    R1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  R, G, B: Extended;
  H, S, V: Extended;
  minimo, maximo, delta: Extended;
implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Edit2Change(Sender: TObject);

begin

end;

procedure TForm2.Button1Click(Sender: TObject);
// RGB para HSL

begin

  R := StrToFloat(Edit1.Text) / 255;
  G := StrToFloat(Edit2.Text) / 255;
  B := StrToFloat(Edit3.Text) / 255;

  H := 0;
  S := 0;
  V := 0;

  minimo := min(min(R,G), B);

  maximo := max(max(R,G), B);

  V := maximo;
  delta := maximo - minimo;



  if( maximo = 0 ) then
      begin
           S:= 0;
      end
  else
      begin
           S := delta/maximo;
      end;

  if( delta = 0 ) then
      begin
           delta := 1;
           H:= 0;
      end;


  if ( B = maximo ) then begin
      H := 4 + ( R - G ) / delta;
      end;

  if ( G = maximo ) then begin
      H := 2 + ( B - R ) / delta;
      end;

  if( R = maximo ) then  begin
      H := ( G - B ) / delta;
      end;

  H := H * 60;

  if( H < 0 ) then
      H := H + 360;

  S *= 100;
  V *= 100;

  Edit4.text := FloatToStr(H);
  Edit5.text := FloatToStr(S);
  Edit6.text := FloatToStr(V);

end;

procedure TForm2.Button2Click(Sender: TObject);
var
  I : Integer;
  F, P, Q, T : Extended;
begin
  H := StrToFloat(Edit4.Text);
  S := StrToFloat(Edit5.Text) /100;
  V := StrToFloat(Edit6.Text) /100;

  H /= 60;

  I := floor(H);
  F := H - I;
  P := V * ( 1 - S );
  Q := V * ( 1 - S * F );
  T := V * ( 1 - S *( 1 - F ) );

  case I of
       0: begin R := V; G := T; B := P;
            end;
       1: begin R := Q; G := V; B := P;
            end;
       2: begin R := P; G := V; B := T;
            end;
       3: begin R := P; G := Q; B := V;
            end;
       4: begin R := T; G := P; B := V;
            end;
       5: begin
              R := V; G := P; B := Q;
         end;

  end;

  if( S = 0 ) then
      begin
          R := V;
          G := V;
          B := V;
      end;

  Edit1.Text := FloatToStr(R*255);
  Edit2.Text := FloatToStr(G*255);
  Edit3.Text := FloatToStr(B*255);


end;

procedure TForm2.Edit3Change(Sender: TObject);
begin

end;

procedure TForm2.Edit4Change(Sender: TObject);
begin

end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.Label2Click(Sender: TObject);
begin

end;

end.

