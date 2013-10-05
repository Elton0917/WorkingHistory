using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//--------
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WorkingHistory
{
    public partial class Deflaut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                string addRecord = "Insert INTO WorkingRecord (WRID,WRDate,WRecord)  values('"+strWRID+"','" + txtStartDate.Text + "','" + txtRecord.Text +"')";
                SqlCommand cmd = new SqlCommand(addRecord, Conn);
                cmd.ExecuteNonQuery();
                Conn.Close();
            }
            else
            {
                string strWRID = "WR"+ dateNo +"0001";
            }

            Conn.Close();
            }
            catch (Exception ex)
            { Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<HR/>"); }
        }
    }
}