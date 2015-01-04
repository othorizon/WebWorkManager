using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReleaseWork : System.Web.UI.Page
{
    static string username;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            username = Request.Cookies["UserStatus"].Values["username"];

            if (username == null)
                Response.Redirect("error.aspx?msg=openwork工作信息错误");



            //加载班级
            DBBean db = new DBBean();
            string sql = "select ClassInfo.ClassID,ClassInfo.Name from TeacherInfo,ClassInfo where TeacherID='" + username
                + "' and ClassInfo.ClassID=TeacherInfo.ClassID";
            DataTable dt = db.GetDataTable(sql);
            if (dt != null)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ListBox1.Items.Add(new ListItem(dt.Rows[i]["Name"].ToString(), dt.Rows[i]["ClassID"].ToString()));
                }
            }
            else
            {
                Response.Redirect("Error.aspx?msg=UserError");
            }



        }
    }
    protected void bt_submit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < ListBox1.Items.Count; i++)
        {
            if (ListBox1.Items[i].Selected)
            {
                if (inserone(ListBox1.Items[i].Value) < 0)
                {
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('"+ListBox1.Items[i].Text+"的作业发布失败，终止发布')", true);
                    return;
                }

            }
        }

        Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('发布成功')", true);
        Response.Write("<script>window.close();</script>");
    }

    private int inserone(string classid)
    {


        string commitetime = "";
        if (tb_endtime.Text.Trim() != "")
        {
            DateTime dt;
            try
            {
                dt = Convert.ToDateTime(tb_endtime.Text);
            }
            catch
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('截止日期格式错误。格式：yyyy-MM-dd HH:mm:ss')", true);
                return -1;
            }
            commitetime = dt.ToString("yyyy-MM-dd HH:mm:ss");
        }
        string sql = "";
        List<SqlParameter> sqlparams = new List<SqlParameter>();

        if (commitetime != "")
        {
            sql = "insert into ReleaseWork (TeacherID,ClassID,Title,Content,ReleaseTime,EndTime)values(@TeacherID,@ClassID,@Title,@Content,@ReleaseTime,@EndTime)";
            sqlparams.Add(new SqlParameter("@EndTime", commitetime));
        }
        else
            sql = "insert into ReleaseWork (TeacherID,ClassID,Title,Content,ReleaseTime)values(@TeacherID,@ClassID,@Title,@Content,@ReleaseTime)";

        sqlparams.Add(new SqlParameter("@ClassID", classid));
        sqlparams.Add(new SqlParameter("@TeacherID", username));
        sqlparams.Add(new SqlParameter("@Title", tbtitle.Text.Trim()));
        sqlparams.Add(new SqlParameter("@Content", tacontent.InnerText));
        sqlparams.Add(new SqlParameter("@ReleaseTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        DBBean db = new DBBean();
        return db.ExecuteNonQueryWithParam(sql, sqlparams);

    }


    /*
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
        string sql = "select EndTime from ReleaseWork where WorkID='" + workid;
        DBBean db = new DBBean();
        DataRow dr=db.GetDataRow(sql);
        if (dr != null)
        {
            if (Convert.ToDateTime(dr[0]) > DateTime.Now)
                return false;          

        }
        return true;
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
    }
    protected void bt_delete_Click(object sender, EventArgs e)
    {
        // Page.ClientScript.RegisterStartupScript(GetType(), "", "$(function(){if(confirm('你真的要删除这条数据吗'))return true;else return false; })", true);

    }*/

}