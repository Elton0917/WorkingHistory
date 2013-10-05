<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WorkingHistory.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap/bootstrap.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <title></title>
</head>
<body>
    <div class="container">

      <form id="form1" runat="server" class="form-signin">
        <h2 class="form-signin-heading">工作日誌系統</h2>
          <br />
        <input type="text" class="form-control" placeholder="帳號" autofocus="">
        <input type="password" class="form-control" placeholder="密碼">
          <br />
        <button class="btn btn-lg btn-primary btn-block" type="submit">登入</button>
      </form>

    </div>
    
</body>
</html>
