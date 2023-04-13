unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Notification;

type
  TfrmMain = class(TForm)
    btnSendNot: TButton;
    btnSendScheduleNot: TButton;
    btnCancelSchedule: TButton;
    btnCancelAll: TButton;
    memLog: TMemo;
    NotificationCenter1: TNotificationCenter;
    procedure btnSendNotClick(Sender: TObject);
    procedure btnCancelScheduleClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure btnSendScheduleNotClick(Sender: TObject);
    procedure btnCancelAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnSendNotClick(Sender: TObject);
var
  Notification: TNotification;
begin
  { verify if the service is actually supported }
  Notification := NotificationCenter1.CreateNotification;
  try
    Notification.Name := 'MyNotification';
    Notification.AlertBody := 'Delphi for Mobile is here!';
    Notification.FireDate := Now;
    { Send notification in Notification Center }
    NotificationCenter1.PresentNotification(Notification);
  finally
    Notification.DisposeOf;
  end;
end;

procedure TfrmMain.btnSendScheduleNotClick(Sender: TObject);
var
  Notification: TNotification;
begin
  { verify if the service is actually supported }
  Notification := NotificationCenter1.CreateNotification;
  try
    Notification.Name := 'MyNotification';
    Notification.AlertBody :=
      'Notificación desde Delphi for Mobile (Scheduled10 sec)';
    { Fired in 10 second }
    Notification.FireDate := Now + EncodeTime(0, 0, 10, 0);
    { Send notification in Notification Center }
    NotificationCenter1.ScheduleNotification(Notification);
  finally
    Notification.DisposeOf;
  end;
end;

procedure TfrmMain.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  memLog.Lines.Add(ANotification.AlertBody);
end;

procedure TfrmMain.btnCancelAllClick(Sender: TObject);
begin

  // cancelar todas las notificaciones.
  if NotificationCenter1.Supported then
  begin
    // Si hay notificaciones pendientes
    NotificationCenter1.CancelAll;
  end;
end;

procedure TfrmMain.btnCancelScheduleClick(Sender: TObject);
begin
  // si hay notificaciones pendientes
  if NotificationCenter1.Supported then
  begin
    NotificationCenter1.CancelNotification('MyNotification');
  end;
end;

end.
