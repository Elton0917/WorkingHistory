<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WorkingHistory.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>工作日誌</title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <link href="Content/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-size: 62.5%;
        }

        label, input {
            display: block;
        }

            input.text {
                margin-bottom: 12px;
                width: 95%;
                padding: .4em;
            }

        fieldset {
            padding: 0;
            border: 0;
            margin-top: 25px;
        }

        h1 {
            font-size: 1.2em;
            margin: .6em 0;
        }

        div#users-contain {
            width: 350px;
            margin: 20px 0;
        }

            div#users-contain table {
                margin: 1em 0;
                border-collapse: collapse;
                width: 100%;
            }

                div#users-contain table td, div#users-contain table th {
                    border: 1px solid #eee;
                    padding: .6em 10px;
                    text-align: left;
                }

        .ui-dialog .ui-state-error {
            padding: .3em;
        }

        .validateTips {
            border: 1px solid transparent;
            padding: 0.3em;
        }
    </style>
    <style>
        #collect {
            margin-left:auto;
            margin-right:auto;
            width:90%;
        }
    </style>
    <script>
        $(function () {
            var datepicker = $("#datepicker"),
              note = $("#note"),
              content = $("#content"),
              allFields = $([]).add(datepicker).add(content).add(note),
              tips = $(".validateTips");

            //function updateTips(t) {
            //    tips
            //      .text(t)
            //      .addClass("ui-state-highlight");
            //    setTimeout(function () {
            //        tips.removeClass("ui-state-highlight", 1500);
            //    }, 500);
            //}

            //function checkLength(o, n, min, max) {
            //    if (o.val().length > max || o.val().length < min) {
            //        o.addClass("ui-state-error");
            //        updateTips("Length of " + n + " must be between " +
            //          min + " and " + max + ".");
            //        return false;
            //    } else {
            //        return true;
            //    }
            //}

            //function checkRegexp(o, regexp, n) {
            //    if (!(regexp.test(o.val()))) {
            //        o.addClass("ui-state-error");
            //        updateTips(n);
            //        return false;
            //    } else {
            //        return true;
            //    }
            //}

            var dialog = $("#dialog-form").dialog({
                draggable: true,
                resizable: true,
                show: 'Transfer',
                hide: 'Transfer',
                autoOpen: false,
                height: 500,
                width: 450,
                modal: true,
                buttons: {
                    "上傳紀錄": function () {

                        var bValid = true;

                        //allFields.removeClass("ui-state-error");
                        if (bValid) {
                            dialog.parent().appendTo($("#form1"));
                            document.getElementById("<%=Button1.ClientID %>").click();
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
        });
            

        $(function () {
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
    <script>
        $(function () {
            $("#dialog-confirm").dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    "確定刪除": function () {
                        $(this).dialog("close");
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });
        });
  </script>
</head>
<body>

    <form id="form1" runat="server">
        <br />
        <div id="dialog-form" title="工作日誌">
            <fieldset runat="server">
                <label for="datepicker">選擇日期</label>
                <input type="text" name="datepicker" id="datepicker" class="text ui-widget-content ui-corner-all" runat="server"/>
                <label for="content">內容</label>
                <textarea id="content" name="content" cols="50" rows="6" runat="server"></textarea>
                <label for="note">備註</label>
                <input type="text" name="note" id="note" value="" class="text ui-widget-content ui-corner-all" runat="server" />
                <div hidden="hidden">
                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" UseSubmitBehavior="false" ViewStateMode="Disabled" />
                </div>
        </fieldset>
        </div>
        <div id="collect">
        <input type="button" id="create-user"  Class="btn btn-primary" value="新增紀錄"/>
        <br />
         <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="YEAR" DataValueField="YEAR"></asp:DropDownList>&nbsp;年
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="M" DataValueField="M"></asp:DropDownList>&nbsp;月
       
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WorkHistoryConnectionString %>" SelectCommand="SELECT DISTINCT LEFT(WRDate,2) AS M FROM WorkingRecord ORDER BY M DESC"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:WorkHistoryConnectionString %>" SelectCommand="SELECT DISTINCT Year(W.WRDate) AS Year FROM WorkingRecord AS W ORDER BY Year DESC"></asp:SqlDataSource>
          <asp:Button ID="Button3" runat="server" Text="查詢" OnClick="Button2_Click" CssClass="btn btn-info"/>
            <br/>  
            <br/>
        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand"  DataSourceID="SqlDataSource1" >
            <HeaderTemplate>
                <table class="table table-bordered table-hover table-condensed">
                    <thead>
                        <tr class="ui-widget-header ">
                            <th></th>
                            <th></th>
                            <th>日期</th>
                            <th>內容</th>
                            <th>備註</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tbody>
                    <tr>
                         <td style="width:5%">
                          <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="if (!confirm('Are you sure you want delete?')) return false;" CommandName="Delete" CommandArgument='<%# Eval("WRID") %>' CssClass="btn btn-sm  btn-warning">修改 </asp:LinkButton>
                        </td>
                        <td style="width:5%">
                          <asp:LinkButton ID="Delete" runat="server" OnClientClick="if (!confirm('Are you sure you want delete?')) return false;" CommandName="Delete" CommandArgument='<%# Eval("WRID") %>' CssClass="btn btn-sm btn-danger">刪除 </asp:LinkButton>
                        </td>
                        <td style="width:10%">
                            <%#Eval("WRDate","{0:dd/MM/yyyy}") %>
                        </td>
                        <td style="width:60%">
                            <%#Eval("WRecord") %> 
                        </td >
                        <td style="width:10%">
                            <%#Eval("WRNote") %></td>
                    </tr>
                </tbody>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WorkHistoryConnectionString %>" DeleteCommand="DELETE FROM [WorkingRecord] WHERE [WRID] = @WRID" InsertCommand="INSERT INTO [WorkingRecord] ([WRID], [User_ID], [WRDate], [WRecord], [WRNote]) VALUES (@WRID, @User_ID, @WRDate, @WRecord, @WRNote)" SelectCommand="SELECT WRID,User_ID,WRDate,left(WorkingRecord.WRecord,50) AS WRecord,WRNote FROM [WorkingRecord] WHERE YEAR(GETDATE()) = YEAR(WorkingRecord.WRDate) AND MONTH(GETDATE()) = MONTH(WorkingRecord.WRDate)  ORDER BY [WRDate]" UpdateCommand="UPDATE [WorkingRecord] SET [User_ID] = @User_ID, [WRDate] = @WRDate, [WRecord] = @WRecord, [WRNote] = @WRNote WHERE [WRID] = @WRID">
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
            <script>
                $(function () {
                    $('#RecordView').each(function () {
                        var $row = $(this).children('tbody').children('tr');
                        alert($row.find('td:eq(1)').html());
                    });
                });
            </script>

        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:WorkHistoryConnectionString %>" SelectCommand="SELECT * FROM [WorkingRecord] WHERE YEAR(GETDATE()) = YEAR(WorkingRecord.WRDate) AND MONTH(GETDATE()) = MONTH(WorkingRecord.WRDate)  ORDER BY [WRDate]">
          
        </asp:SqlDataSource>
         <asp:Button ID="btnExport" runat="server" Text="輸出Excel" OnClick = "ExportToExcel" />
            </div>
        <div hidden="hidden">
                    <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand"  DataSourceID="SqlDataSource4" >
            <HeaderTemplate>
                <table id="RecordView">
                    <thead>
                        <tr class="ui-widget-header ">
                            <th>Date</th>
                            <th>Content</th>
                            <th>Note</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tbody>
                    <tr>
                        <td>
                            <%#Eval("WRDate","{0:dd/MM/yyyy}") %>
                        </td>
                        <td>
                            <%#Eval("WRecord") %>
                        </td>
                        <td><%#Eval("WRNote") %></td>
                    </tr>
                </tbody>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>

        </asp:Repeater>
        </div>
        <script src="Scripts/bootstrap.js"></script>
    </form>
</body>
</html>
