using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        isDenglu();//判断是否已登陆
        tb_username.Focus();
    }

    private void isDenglu()
    {
        if (Request.Cookies["UserStatus"] != null)
        {
            //跳转到用户中心
                Response.Redirect("UserCenter.aspx");
        }
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string sql = "select ID from UserInfo where UserID='"
            + tb_username.Text.Trim() + "' and PassWord='" + tb_pwd.Text + "'";
        DBBean db = new DBBean();
        DataRow dr = db.GetDataRow(sql);
        if (dr == null)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('用户名或密码错误')", true);
            return;
        }
        else
        {
            HttpCookie cookie = new HttpCookie("UserStatus");
            cookie.Values.Add("username", tb_username.Text.Trim());
            cookie.Values.Add("type", ddl_type.SelectedValue.ToString());
            if (ddl_expires.SelectedValue.Equals("一天"))
                cookie.Expires = DateTime.Now.AddDays(1);
            if (ddl_expires.SelectedValue.Equals("一周"))
                cookie.Expires = DateTime.Now.AddDays(7);
            if (ddl_expires.SelectedValue.Equals("一个月"))
                cookie.Expires = DateTime.Now.AddMonths(1);
            Response.Cookies.Add(cookie);
            Response.Redirect("UserCenter.aspx");
        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        dvregister.InnerHtml = "<iframe scrolling='no' id='iframeregister' style='opacity:0;border:none;height:0px;width:336px' src=\"MinRegister.aspx\"></iframe>";
          Page.ClientScript.RegisterStartupScript(GetType(), "", "showregister()", true);
    }
}