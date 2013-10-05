using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

using System.IO;
using System.Data;

namespace WorkingHistory
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataSet ds = new DataSet();
                //ds.ReadXml(Server.MapPath("~/Customers.xml"));
                //Repeater1.DataSource = ds.Tables[0].Rows.Cast<DataRow>().Take(10).CopyToDataTable();
                //Repeater1.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["WorkHistoryConnectionString"].ConnectionString);
            SqlCommand cmdtop1 = new SqlCommand("select TOP 1 WRID from WorkingRecord ORDER BY WRID DESC", Conn);

            try
            {
                Conn.Open();
                object obj = cmdtop1.ExecuteScalar();   //---- getData
                Conn.Close();
                var dateNo = DateTime.Now.ToString("yyMM");
                if (obj != null)
                {
                    Conn.Open();

                    string dr = cmdtop1.ExecuteScalar().ToString();
                    int drpluse = Convert.ToInt32(dr.Substring(6, 4));
                    drpluse++;
                    string GFNO = drpluse.ToString();
                    string showGF = GFNO.PadLeft(4, '0');
                    string strWRID = "WR" + dateNo + showGF.ToString();
                    string addRecord = "Insert INTO WorkingRecord (WRID,WRDate,WRecord,WRNote)  values('" + strWRID + "','" + this.datepicker.Value + "','" + this.content.Value + "','"+this.note.Value+"')";
                    SqlCommand cmd = new SqlCommand(addRecord, Conn);
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                }
                else
                {
                    string strWRID = "WR" + dateNo + "0001";
                }

                Conn.Close();

                Response.Redirect("WebForm1.aspx");
            }
            catch (Exception ex)
            { Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<HR/>"); }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {

            string newSQL = "SELECT WRID,User_ID,WRDate,left(WorkingRecord.WRecord,50) AS WRecord,WRNote FROM WorkingRecord WHERE year(WorkingRecord.WRDate) = '" + DropDownList2.SelectedValue + "' AND month(WorkingRecord.WRDate) = '" + DropDownList1.SelectedValue + "'  ORDER BY WRDate";
            string newSQL2 = "SELECT * FROM WorkingRecord WHERE year(WorkingRecord.WRDate) = '" + DropDownList2.SelectedValue + "' AND month(WorkingRecord.WRDate) = '" + DropDownList1.SelectedValue + "'  ORDER BY WRDate";
           
            SqlDataSource1.SelectCommand = newSQL;
            SqlDataSource4.SelectCommand = newSQL2;
        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (e.CommandName == "Delete")
            {
                //ScriptManager.RegisterStartupScript(Page, GetType(), "temp", "<script type='text/javascript'>$('div').trigger('create');</script>", false);
                
                string detail = Convert.ToString(e.CommandArgument);
                string WPID = detail.ToString();
                string FileDelete = "DELETE FROM [WorkingRecord] WHERE [WRID] = '" + WPID + "'";

                SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["WorkHistoryConnectionString"].ConnectionString);
                try
                {
                    Conn.Open();
                    SqlCommand cmd = new SqlCommand(FileDelete, Conn);
                    cmd.ExecuteNonQuery();
                    Conn.Close();
                    Response.Redirect("WebForm1.aspx");
                }
                catch (Exception ex)
                { Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<HR/>"); }
            }
        }
        protected void ExportToExcel(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=RepeaterExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Repeater2.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
}