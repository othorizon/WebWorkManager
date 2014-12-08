using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkStatus : System.Web.UI.Page
{
    static string workid = "456";
    static string classid = "ruanjian121";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            workid = Request.QueryString["workid"];
            classid = Request.QueryString["classid"];
            if (workid == null || classid == null)
                Response.Redirect("error.aspx?msg=openwork工作信息错误");


            loadinfo();
        }
    }

    private void loadinfo()
    {
        string sql = "select distinct WorkID,StudentInfo.StudentID as 学号,StudentInfo.Name as 姓名,Title as 标题,Content as 内容,Attach as 附件 from StudentInfo,CommitWork where CommitWork.WorkID='" +
    workid + "' and StudentInfo.StudentID=CommitWork.StudentID";
        if (classid != "[ALL]" && classid.Trim() != "")
            sql += " and StudentInfo.ClassID='" + classid + "'";

        string ss = sql;
        DBBean db = new DBBean();
        DataTable dt = db.GetDataTable(sql);
        dt.Columns["WorkID"].ColumnMapping = MappingType.Hidden; //隐藏
        GridView1.DataSource = dt;
        GridView1.DataBind();
        int a = GridView1.Columns.Count;

        Label1.Text = GridView1.Rows.Count.ToString();

    }
    private bool overtime()
    {
        string sql = "select EndTime from ReleaseWork where WorkID='" + workid;
        DBBean db = new DBBean();
        DataRow dr = db.GetDataRow(sql);
        if (dr != null)
        {
            if (Convert.ToDateTime(dr[0]) > DateTime.Now)
                return false;

        }
        return true;
    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //FileInfo fileInfo = new FileInfo(path + zip);//文件路径如：E:/11/22  
        //Response.Clear();
        //Response.AddHeader("Content-Disposition", "attachment;   filename=" + Server.UrlEncode(fileInfo.Name.ToString()));//文件名称  
        //Response.AddHeader("Content-Length", fileInfo.Length.ToString());//文件长度  
        //Response.ContentType = "application/octet-stream";//获取或设置HTTP类型  
        //Response.ContentEncoding = System.Text.Encoding.Default;
        //Response.WriteFile(path + zip);//将文件内容作为文件块直接写入HTTP响应输出流  
        DownloadFile(e.CommandArgument.ToString());
        //   Response.Write("<script>window.open( 'openwork.aspx?username=" + e.CommandArgument.ToString() +              
        //          "&workid=" + e.CommandName + "', '', 'menubar=no,location=no,status=no,scroolbars=no,resizable=no,width=350,height=350')</script>");

    }
    protected void DownloadFile(string filename)
    {
        string saveFileName = "test.xls";
        int intStart = filename.LastIndexOf("\\") + 1;
        saveFileName = filename.Substring(intStart, filename.Length - intStart);

        Response.Clear();
        Response.Charset = "utf-8";
        Response.Buffer = true;
        this.EnableViewState = false;
        Response.ContentEncoding = System.Text.Encoding.UTF8;

        Response.AppendHeader("Content-Disposition", "attachment;filename=" + saveFileName);
        Response.WriteFile(filename);
        Response.Flush();
        Response.Close();

        Response.End();
    }
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[1].Visible = false;
    }
}