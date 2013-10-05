<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WorkingHistory.Deflaut" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="Content/themes/base/jquery-ui.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/jquery-ui-1.10.3.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <title></title>
    <style>
    body { font-size: 62.5%; }
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
  </style>
  <script>
      $(function () {
          var datepicker = $("#datepicker"),
            email = $("#email"),
            conntent = $("#conntent"),
            allFields = $([]).add(datepicker).add(email).add(conntent),
            tips = $(".validateTips");

          function updateTips(t) {
              tips
                .text(t)
                .addClass("ui-state-highlight");
              setTimeout(function () {
                  tips.removeClass("ui-state-highlight", 1500);
              }, 500);
          }

          function checkLength(o, n, min, max) {
              if (o.val().length > max || o.val().length < min) {
                  o.addClass("ui-state-error");
                  updateTips("Length of " + n + " must be between " +
                    min + " and " + max + ".");
                  return false;
              } else {
                  return true;
              }
          }

          function checkRegexp(o, regexp, n) {
              if (!(regexp.test(o.val()))) {
                  o.addClass("ui-state-error");
                  updateTips(n);
                  return false;
              } else {
                  return true;
              }
          }

          $("#dialog-form").dialog({
              autoOpen: false,
              height: 400,
              width: 450,
              modal: true,
              buttons: {
                  "Create an account": function () {
                      var bValid = true;
                      allFields.removeClass("ui-state-error");

                      //bValid = bValid && checkLength(datepicker, "username", 3, 16);
                      //bValid = bValid && checkLength(email, "email", 6, 80);
                      //bValid = bValid && checkLength(password, "password", 5, 16);

                      //bValid = bValid && checkRegexp(datepicker, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter.");
                      //// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
                      //bValid = bValid && checkRegexp(email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com");
                      //bValid = bValid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9");

                      if (bValid) {
                          $("#users tbody").append("<tr>" +
                            "<td>" + datepicker.val() + "</td>" +
                            "<td>" + email.val() + "</td>" +
                            "<td>" + conntent.val() + "</td>" +
                          "</tr>");
                          $(this).dialog("close");
                      }
                  },
                  Cancel: function () {
                      $(this).dialog("close");
                  }
              },
              close: function () {
                  allFields.val("").removeClass("ui-state-error");
              }
          });

          $("#create-user")
            .button()
            .click(function () {
                $("#dialog-form").dialog("open");
            });
      });
      $(function () {
          $("#datepicker").datepicker();
      });
  </script>
</head>
<body>
    <script>
        $(function () {
            $("#add").hide();
            $("#addbtn").click(function () {
                if ($("#add").hide())
                { $("#add").show(); }
                 })
        });
    </script>
    <form id="form1" runat="server">
    <div id="dialog-form" title="Create new user">
    <p class="validateTips">All form fields are required.</p>
    <fieldset>
    <label for="datepicker">選擇日期</label>
    <input type="text" name="datepicker" id="datepicker" class="text ui-widget-content ui-corner-all" />
    <label for="email">Email</label>
    <input type="text" name="email" id="email" value="" class="text ui-widget-content ui-corner-all" />
    <label for="conntent">Password</label>
    <input type="text" name="conntent" id="conntent" value="" class="text ui-widget-content ui-corner-all" />
  </fieldset>
    </div>
        <button id="create-user">新增紀錄</button>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
         <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <input type="button" id="addbtn" value="Add"/>
                <div id="add">
                    <asp:Label ID="Label1" runat="server" Text="選擇日期 :  "></asp:Label>
                    <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy/MM/dd" TargetControlID="txtStartDate">
                    </asp:CalendarExtender>
                    <asp:Label ID="Label2" runat="server" Text="工作日誌 :  "></asp:Label>
                    <asp:TextBox ID="txtRecord" runat="server" MaxLength="1023" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="新增" OnClick="Button1_Click" />
                </div>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <%#Eval("WRID") %>||
                            <%#Eval("User_ID") %>||
                            <%#Eval("WRDate","{0:dd/MM/yyyy}") %>||
                            <%#Eval("WRecord") %>
                        </li>

                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WorkHistoryConnectionString %>" DeleteCommand="DELETE FROM [WorkingRecord] WHERE [WRID] = @WRID" InsertCommand="INSERT INTO [WorkingRecord] ([WRID], [User_ID], [WRDate], [WRecord], [WRNote]) VALUES (@WRID, @User_ID, @WRDate, @WRecord, @WRNote)" SelectCommand="SELECT * FROM [WorkingRecord] ORDER BY [WRDate]" UpdateCommand="UPDATE [WorkingRecord] SET [User_ID] = @User_ID, [WRDate] = @WRDate, [WRecord] = @WRecord, [WRNote] = @WRNote WHERE [WRID] = @WRID">
                    <DeleteParameters>
                        <asp:Parameter Name="WRID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="WRID" Type="String" />
                        <asp:Parameter Name="User_ID" Type="String" />
                        <asp:Parameter Name="WRDate" Type="DateTime" />
                        <asp:Parameter Name="WRecord" Type="String" />
                        <asp:Parameter Name="WRNote" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="User_ID" Type="String" />
                        <asp:Parameter Name="WRDate" Type="DateTime" />
                        <asp:Parameter Name="WRecord" Type="String" />
                        <asp:Parameter Name="WRNote" Type="String" />
                        <asp:Parameter Name="WRID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Button1" />
            </Triggers>
        </asp:UpdatePanel>
    
    </form>
</body>
</html>
