using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class openWork : System.Web.UI.Page
{
    static string username;
    static string workid;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            username = Request.QueryString["username"];
            workid = Request.QueryString["workid"];

            if (username == null || workid == null)
                Response.Redirect("error.aspx?msg=openwork工作信息错误");


            loadinfo();
        }
    }

    private void loadinfo()
    {
        string sql = "select * from CommitWork where WorkID='" + workid + "' and StudentID='" + username + "'";
        DBBean db = new DBBean();
        DataRow dr = db.GetDataRow(sql);
        if (dr != null)
        {
            bt_submit.Text = "修改作业";
            bt_delete.Visible = true;
            tbtitle.Text = dr["Title"].ToString();
            if (dr["Attach"] != null)
            {
                string path = dr["Attach"].ToString();
                if (File.Exists(path))
                {
                    lbattach.Text = path;
                    dvattach.Visible = true;
                    dvupfile.Visible = false;
                }
            }
            if (dr["Content"] != null)
                tacontent.InnerText = dr["Content"].ToString();
        }


    }
    private bool overtime()
    {
        string sql = "select EndTime from ReleaseWork where WorkID='" + workid+"'";
        DBBean db = new DBBean();
        DataRow dr=db.GetDataRow(sql);

        if ( dr != null && !(dr["EndTime"] is DBNull))
        {
            if (Convert.ToDateTime(dr["EndTime"]) < DateTime.Now)
                return true;          

        }
        return false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (overtime())
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('O(∩_∩)O哈哈~你完蛋了！超过截止日期，不能提交了！！')", true);
            return;
        }

        string path = "";
        //上传文件
        try
        {
            if (FileUpload1.HasFile)
            {
                if (FileUpload1.FileContent.Length > 10240000)
                {
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('文件大小超过10MB')", true);
                    return;
                }
                path = Server.MapPath(username + "\\" + workid) + "\\";
                if (!Directory.Exists(path))
                {
                    try
                    {
                        Directory.CreateDirectory(path);
                    }
                    catch
                    {
                        Response.Redirect("error.aspx?msg=创建目录失败，服务器异常");
                    }
                }
                path = Server.MapPath(username + "\\" + workid) + "\\" + FileUpload1.FileName;

                FileUpload1.SaveAs(path);
            }
        }
        catch
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('文件上传失败')", true);
            return;
        }

        DBBean db = new DBBean();
        string sql = "";
        if (bt_submit.Text == "提交作业")
        {
            sql = "insert into CommitWork (WorkID,StudentID,Title,Content,Attach,CommitTime) values("
           + "@WorkID,@StudentID,@Title,@Content,@Attach,@CommitTime)";
        }
        else if (bt_submit.Text == "修改作业")
        {
            sql = "update CommitWork set WorkID=@WorkID,StudentID=@StudentID,Title=@Title,Content=@Content,Attach=@Attach,CommitTime=@CommitTime"
                + " where WorkID='" + workid + "' and StudentID='" + username + "'";
        }


        List<SqlParameter> sqlparams = new List<SqlParameter>();

        sqlparams.Add(new SqlParameter("@WorkID", workid));
        sqlparams.Add(new SqlParameter("@StudentID", username));
        sqlparams.Add(new SqlParameter("@Title", tbtitle.Text.Trim()));
        sqlparams.Add(new SqlParameter("@Content", tacontent.InnerText));
        sqlparams.Add(new SqlParameter("@Attach", path));
        sqlparams.Add(new SqlParameter("@CommitTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        int result = db.ExecuteNonQueryWithParam(sql, sqlparams);
        if (result > 0)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('提交成功')", true);
        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('提交失败')", true);
        }
        loadinfo();

    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        // Page.ClientScript.RegisterStartupScript(GetType(), "", "hideattach()", true);
        
        string path = Server.MapPath(username + "\\" + workid);
        try
        {
            Directory.Delete(path, true);
            dvupfile.Visible = true;
        }
        catch
        {
            Response.Redirect("error.aspx?msg=删除失败，服务器异常");
        }
        dvattach.Visible = false;
        path = "";
    }
    protected void bt_delete_Click(object sender, EventArgs e)
    {
        // Page.ClientScript.RegisterStartupScript(GetType(), "", "$(function(){if(confirm('你真的要删除这条数据吗'))return true;else return false; })", true);

    }
}