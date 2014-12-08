using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentCenter : System.Web.UI.Page
{
    static string username="";
    static string Name="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //加载用户名
            username=Request.Cookies["UserStatus"].Values["username"];
            DBBean db = new DBBean();
            string sql = "select Name from StudentInfo where StudentID='" + username + "'";
            DataRow dr=db.GetDataRow(sql);
            if (dr != null)
            {
                Name = dr[0].ToString();
                lb_name.Text = Name+"   ，";
            }
            else
            {
                Response.Redirect("Error.aspx?msg=UserError");
            }
            //加载班级
          sql = "select ClassInfo.ClassID,ClassInfo.Name from StudentInfo,ClassInfo where StudentID='"+ username 
              + "' and ClassInfo.ClassID=StudentInfo.ClassID";
          DataTable dt = db.GetDataTable(sql);
          if (dt != null)
          {
              for (int i = 0; i < dt.Rows.Count; i++)
              {
                  ddl_Class.Items.Add(new ListItem(dt.Rows[i]["Name"].ToString(),dt.Rows[i]["ClassID"].ToString()));
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
        string sql = "select * from ReleaseWork where ClassID='" + ddl_Class.SelectedValue + "'";
        DBBean db = new DBBean();
       dt = db.GetDataTable(sql);
        if (dt != null)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                inserOneWork(dt.Rows[i],i);
            }
           Page.ClientScript.RegisterStartupScript(GetType(), "", "showwork()", true);
        //   dvwork.InnerHtml += "<label style='height:300px;display:block'></label>";
        }
    }

    private void inserOneWork(DataRow dataRow,int num)
    {
      //  lb_workid1.Text = dataRow["WorkID"].ToString();
     //   string fun = "";
      //  Page.ClientScript.RegisterStartupScript(GetType(),"", fun, true);
        string title = dataRow["Title"].ToString()+"\t截止时间:"+dataRow["EndTime"].ToString();
        string content = dataRow["Content"].ToString();
        dvwork.InnerHtml += " <div id='dvworktitle" + num + "' class='touming' style='opacity:0;height:1px; font-weight: bold;font-size:large;color:red;' >"          
            + title + "<div id='dvworkceontent" + num + "' style='color:black;height:10px;opacity:0'>" 
          //  + "<iframe  width='100%' height='100%' src='workinfo.aspx?username=" + username + "&workid=" + dataRow["WorkID"].ToString() + "' scrolling='no' frameborder='0'></iframe>"
             + content + "</div>"
               + "<iframe id='iframe"+num+"' width='100%' height='100%' scrolling='no' frameborder='0'></iframe>"
            +"<input type='button' style='text-align:center;width:500px;' id='"+num+"'  name='"+dataRow["WorkID"].ToString()+"' value='去完成工作' />"
        +"</div>";
      //  dvwork.InnerHtml += "<div style='height:5px;'></div>";
        dvwork.InnerHtml += "<label style='height:5px;display:block'></label>";

    }
    public  void test()
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        HttpCookie cookie = Request.Cookies["UserStatus"];
        cookie.Expires = DateTime.Now;
        Response.Cookies.Add(cookie);
        Response.Redirect("Login.aspx");
    }
}