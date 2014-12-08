using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class workinfo : System.Web.UI.Page
{
    public static string username = "1";
    public static string workid = "1";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            workid = Request.QueryString["workid"];
            username = Request.QueryString["username"];
            if (username == null || workid == null)
                Response.Redirect("error.aspx?msg=工作信息错误");

            DBBean db = new DBBean();
            string sql = "select * from ReleaseWork where WorkID='" + workid + "'";
            DataRow dr = db.GetDataRow(sql);
            if (dr != null)
            {
                title.InnerText = dr["Title"].ToString();
                dvcontent.InnerHtml = "" + dr["Content"].ToString();
            }
        }
    }
}