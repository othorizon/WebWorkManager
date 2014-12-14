using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherCenter : System.Web.UI.Page
{
    public static string username = "";
    static string Name = "";
    public static string classid = "[ALL]";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //加载用户名
            username = Request.Cookies["UserStatus"].Values["username"];
            DBBean db = new DBBean();
            string sql = "select Name from TeacherInfo where TeacherID='" + username + "'";
            DataRow dr = db.GetDataRow(sql);
            if (dr != null)
            {
                Name = dr[0].ToString();
                lb_name.Text = Name + "   ，";
            }
            else
            {
                Response.Redirect("Error.aspx?msg=UserError");
            }
            if (Request.QueryString["classid"] != null)
            {
                classid = Request.QueryString["classid"];
            }

            //加载班级
            sql = "select ClassInfo.ClassID,ClassInfo.Name from TeacherInfo,ClassInfo where TeacherID='" + username
                + "' and ClassInfo.ClassID=TeacherInfo.ClassID";
            DataTable dt = db.GetDataTable(sql);
            if (dt != null)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //顺便设置班级名称label
                    string s = dt.Rows[i]["ClassID"].ToString();
                    if (dt.Rows[i]["ClassID"].Equals(classid))
                        classname.Text = dt.Rows[i]["Name"].ToString();
                    lbclass.InnerHtml += " <input type='button' value='" + dt.Rows[i]["Name"].ToString()
                        + "' onclick=\"selectclass('" + dt.Rows[i]["ClassID"].ToString() + "')\" /><br /><br />";
                }
            }
            else
            {
                Response.Redirect("Error.aspx?msg=UserError");
            }


            LoadWork();//加载作业信息


        }
    }
    public static DataTable dt;
    private void LoadWork()
    {
        //筛选班级
        string sql = "select * from ReleaseWork where TeacherID='" + username + "'";
        if (classid != "[ALL]" && classid.Trim() != "")
            sql += " and  ClassID='" + classid + "' ";
        sql += " ORDER BY EndTime ASC,ReleaseTime DESC";

        DBBean db = new DBBean();
        dt = db.GetDataTable(sql);
        if (dt != null)
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                inserOneWork(dt.Rows[i], i, false);
            }
            System.Threading.Thread.Sleep(1000);
            Page.ClientScript.RegisterStartupScript(GetType(), "", "showwork()", true);
            //   dvwork.InnerHtml += "<label style='height:300px;display:block'></label>";
        }
    }

    private void inserOneWork(DataRow dataRow, int num, bool finish)
    {
        //  lb_workid1.Text = dataRow["WorkID"].ToString();
        //   string fun = "";
        //  Page.ClientScript.RegisterStartupScript(GetType(),"", fun, true);



        string committime = "";
        try
        {
            committime = Convert.ToDateTime(dataRow["EndTime"]).ToShortDateString();
        }
        catch { }

        string title = finish == true ? "【已完成】" : "";
        title += dataRow["Title"].ToString() + "\t截止:" + committime
            + "\t发布:" + Convert.ToDateTime(dataRow["ReleaseTime"]).ToShortDateString();
        string content = dataRow["Content"].ToString();
        if (finish)
            dvwork.InnerHtml += " <div name='finish' id='" + num + "' class='touming'style='opacity:0;height:1px; font-weight: bold;font-size:large;color:red;' >";
        else
            dvwork.InnerHtml += " <div  name='notfinish'  id='" + num + "' class='touming' style='opacity:0;height:1px; font-weight: bold;font-size:large;color:red;' >";
        dvwork.InnerHtml += title + "<div id='dvworkceontent" + num + "' style='color:black;height:10px;opacity:0;text-align:left'>"
            + content +
            "<label id='lbworkid" + num + "' style='visibility:collapse'>" + dataRow["WorkID"] + "</label>" +
             "<label id='lbclassid" + num + "' style='visibility:collapse'>" + classid + "</label>" +
             "<label id='lbnum" + dataRow["WorkID"] + "' style='visibility:collapse'>" + num + "</label>" +
            //  " <iframe  id='sinfo"+num+"' scrolling='yes' style='opacity: 1; border: none; width: inherit; height: inherit' src='''></iframe>"
            "</div>"
            + "<input type='button' style='text-align:center;width:500px;' id='button" + num + "'  name='" + dataRow["WorkID"].ToString() + "' value='去完成工作' />"
        + "</div>";
        //  dvwork.InnerHtml += "<div style='height:5px;'></div>";
        dvwork.InnerHtml += "<label style='height:5px;display:block'></label>";

    }
    public void test()
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        try
        {
            HttpCookie cookie = Request.Cookies["UserStatus"];
            cookie.Expires = DateTime.Now;
            Response.Cookies.Add(cookie);
        }
        finally
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void btfinish_Click(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(GetType(), "", "hidefinish()", true);
    }
}